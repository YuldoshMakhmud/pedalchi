import 'package:flutter/material.dart';
import 'package:foodchi/common/app_style.dart';
import 'package:foodchi/common/back_ground_container.dart';
import 'package:foodchi/common/reusable_text.dart';
import 'package:foodchi/constants/constants.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        title: ReusableText(
          text: "My Orders",
          style: appStyle(14, kPrimary, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(color: kLightWhite, child: Container()),
    );
  }
}

List<String> orderList = [
  "Pending",
  "Preparing",
  "Delivering",
  "Delivered",
  "Cancelled",
];
