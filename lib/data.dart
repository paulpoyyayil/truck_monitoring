import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

bool isLoggedIn = false;
String? role;

class TilesWidgetClass {
  IconData icon;
  String label;

  TilesWidgetClass({required this.icon, required this.label});
}

List<TilesWidgetClass> userWidgets = [
  TilesWidgetClass(
    icon: Remix.user_2_line,
    label: 'Drivers',
  ),
  TilesWidgetClass(
    icon: Remix.truck_line,
    label: 'Trucks',
  ),
  TilesWidgetClass(
    icon: Remix.bus_line,
    label: 'Bookings & Loads',
  ),
  TilesWidgetClass(
    icon: Remix.secure_payment_line,
    label: 'Payments',
  ),
  TilesWidgetClass(
    icon: Remix.upload_2_line,
    label: 'Add Load',
  ),
  TilesWidgetClass(
    icon: Remix.chat_2_line,
    label: 'Messages',
  ),
];

List<TilesWidgetClass> driverWidgets = [
  TilesWidgetClass(
    icon: Remix.truck_line,
    label: 'Vehicle',
  ),
  TilesWidgetClass(
    icon: Remix.book_3_line,
    label: 'Booking',
  ),
  TilesWidgetClass(
    icon: Remix.download_2_line,
    label: 'Load Request',
  ),
  TilesWidgetClass(
    icon: Remix.download_2_line,
    label: 'Accepted Loads',
  ),
];
