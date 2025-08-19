import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodchi/common/app_style.dart';
import 'package:foodchi/common/reusable_text.dart';
import 'package:foodchi/constants/constants.dart';
import 'package:foodchi/controllers/user_location_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
      height: 105.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage(
                    'https://dbestech-code.oss-ap-southeast-1.aliyuncs.com/foodly_flutter/icons/profile-photo.png?OSSAccessKeyId=LTAI5t8cUzUwGV1jf4n5JVfD&Expires=36001721319904&Signature=mxqrJ0bGFdbh05ORP7QHQsI3Ty0%3D',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Deliver to",
                        style: appStyle(13, kSecondary, FontWeight.w600),
                      ),
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          "16768 21st Ave N, Plymouth, MN 55447",
                          overflow: TextOverflow.ellipsis,
                          style: appStyle(11, kGrayLight, FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(getTimeOfDay(), style: const TextStyle(fontSize: 35)),
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️ ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return ' 🌙 ';
    }
  }
}

Future<void> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }
  _getCurentLocation();
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
}

Future<void> _getCurentLocation() async {
  final controller = Get.put(UserLocationController());
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );
  LatLng currentLocation = LatLng(position.latitude, position.longitude);
  controller.setPosition(currentLocation);
  print(currentLocation);

  controller.getUserAddress(currentLocation);
}
