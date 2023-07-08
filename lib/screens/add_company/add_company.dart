// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:truck_monitor/screens/add_company/widgets/add_company_modal.dart';
// import 'package:truck_monitor/screens/homepage/homepage.dart';
// import 'package:truck_monitor/utils/navigation.dart';
// import 'package:truck_monitor/widgets/app_bar.dart';
// import 'package:truck_monitor/widgets/big_button.dart';
// import 'package:truck_monitor/widgets/card_outline.dart';
// import 'package:truck_monitor/widgets/row_text.dart';

// class AddCompany extends StatefulWidget {
//   const AddCompany({super.key});

//   @override
//   State<AddCompany> createState() => _AddCompanyState();
// }

// class _AddCompanyState extends State<AddCompany> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         title: 'Company',
//         isMainTab: false,
//         onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
//       ),
//       bottomSheet: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: CustomBigButton(
//                 onTap: () {
//                   showModalBottomSheet(
//                     isScrollControlled: true,
//                     context: context,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(16.r),
//                         topRight: Radius.circular(16.r),
//                       ),
//                     ),
//                     builder: (context) {
//                       return const AddCompanyModal(title: 'Add Company');
//                     },
//                   );
//                 },
//                 buttonText: 'ADD COMPANY',
//               ),
//             ),
//             SizedBox(height: 12.w)
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//         child: const Column(
//           children: [
//             CardOutline(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RowText(
//                             title: 'Company: ',
//                             text: 'ABC',
//                           ),
//                           RowText(
//                             title: 'Location: ',
//                             text: 'Kozhikode',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
