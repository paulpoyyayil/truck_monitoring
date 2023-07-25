import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/user_view_load.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/user_accept_load.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';

class LoadRequestCard extends StatefulWidget {
  const LoadRequestCard({super.key, required this.data});
  final UserViewLoadData data;

  @override
  State<LoadRequestCard> createState() => _LoadRequestCardState();
}

class _LoadRequestCardState extends State<LoadRequestCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CardOutline(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowText(
                    title: 'Driver Name: ',
                    text: widget.data.drivername!.titleCase,
                  ),
                  RowText(
                    title: 'Load From: ',
                    text: widget.data.loadFrom!.titleCase,
                  ),
                  RowText(
                    title: 'Load To: ',
                    text: widget.data.loadTo!.toUpperCase(),
                  ),
                  RowText(
                    title: 'Quantity: ',
                    text: widget.data.loadQuantity!.toUpperCase(),
                  ),
                ],
              ),
            ],
          ),
          StatusButton(
            onTap: () async {
              if (!isLoading) {
                if (mounted) {
                  setState(() {
                    isLoading = true;
                  });
                }
                try {
                  bool status = await userAcceptLoad(
                      context: context, loadId: widget.data.id.toString());
                  if (status) {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    getSnackbar(context, 'Request Accepted');
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: Center(
                                child: CircularProgressIndicator.adaptive()),
                          ),
                        );
                      },
                    );
                    navigationPush(context, Homepage(selectedIndex: 0));
                  } else {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    getSnackbar(context, 'Unexpected error occurred.');
                  }
                } catch (e) {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  getSnackbar(context, e.toString());
                }
              }
            },
            buttonText: 'Accept Load',
            status: isLoading,
          ),
        ],
      ),
    );
  }
}
