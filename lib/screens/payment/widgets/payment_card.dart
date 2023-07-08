import 'package:flutter/material.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.name,
    required this.address,
    required this.from,
    required this.to,
    required this.mob,
    required this.addMob,
    required this.payment,
  });
  final String name, address, from, to, mob, addMob, payment;

  @override
  Widget build(BuildContext context) {
    return CardOutline(
      child: Column(
        children: [
          SeparatedRowText(title: 'Name', text: name),
          SeparatedRowText(title: 'Address', text: address),
          SeparatedRowText(title: 'From', text: from),
          SeparatedRowText(title: 'To', text: to),
          SeparatedRowText(title: 'Mobile', text: mob),
          SeparatedRowText(title: 'Additional Mobile', text: addMob),
          SeparatedRowText(title: 'Payment', text: payment),
        ],
      ),
    );
  }
}
