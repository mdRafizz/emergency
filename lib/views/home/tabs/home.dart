import 'package:emergency/app_route.dart';
import 'package:emergency/views/division/division_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common/reusable_text.dart';
import '../../location/location_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var buttonData = <IconData, String>{
      Icons.local_police_rounded: 'Police Station',
      Icons.local_hospital_rounded: 'Hospital',
      Icons.fire_truck_rounded: 'Fire Service',
      Icons.bus_alert_rounded: 'Bus Station',
      Icons.vaccines_rounded: 'Pharmacy',
      Icons.location_on_rounded: 'Own Location',
    };

    var buttonActions = <VoidCallback>[
      () {
        Get.to(
              () => DivisionScreen(),
          duration: const Duration(
            milliseconds: 654,
          ),
          transition: Transition.fade,
        );
        // Action for Police Station button
        debugPrint('Police Station button pressed');
      },
      () {
        Get.to(
              () => DivisionScreen(),
          duration: const Duration(
            milliseconds: 654,
          ),
          transition: Transition.fade,
        );
        // Action for Hospital button
        debugPrint('Hospital button pressed');
      },
      () {
        Get.to(
              () => DivisionScreen(),
          duration: const Duration(
            milliseconds: 654,
          ),
          transition: Transition.fade,
        );
        // Action for Fire Service button
        debugPrint('Fire Service button pressed');
      },
      () {
        Get.to(
              () => DivisionScreen(),
          duration: const Duration(
            milliseconds: 654,
          ),
          transition: Transition.fade,
        );
        debugPrint('Bus Station button pressed');
      },
      () {
        Get.to(
          () => DivisionScreen(),
          duration: const Duration(
            milliseconds: 654,
          ),
          transition: Transition.fade,
        );
        // Action for Fire Service button
        debugPrint('Pharmacy button pressed');
      },
      () {
        Get.to(() => LocationScreen());
        debugPrint('Own Location button pressed');
      },
    ];

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Gap(14.h),
          // Top Section with App Icon, Search, and Logout buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/safety_logo.png',
                  height: 30.sp,
                  fit: BoxFit.cover,
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(7.sp),
                  decoration: const BoxDecoration(
                    color: Color(0xfffae7af),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                    size: 17.sp,
                  ),
                ),
                Gap(25.w),
                Container(
                  padding: EdgeInsets.all(7.sp),
                  decoration: const BoxDecoration(
                    color: Color(0xfffae7af),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profile),
                    child: Icon(
                      CupertinoIcons.person,
                      size: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(30.h),
          // Middle Section with an Image taking 30% of the screen height
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/alert_img.png',
                  ),
                  // Change to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Gap(50.h),
          // Bottom Section with 6 buttons in 2 rows
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: .83,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
              children: List.generate(6, (index) {
                return MaterialButton(
                  // height: 199.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  color: const Color(0xffd9d9d9),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  onPressed: buttonActions[index],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Icon(
                            buttonData.keys.toList()[index],
                            color: Colors.black,
                            size: 33.sp,
                          ),
                        ),
                      ),
                      // Change to your icon
                      // Gap(17.h),
                      Expanded(
                        child: Center(
                          child: ReusableText(
                            buttonData.values.toList()[index],
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins',
                            fontSize: 14,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
