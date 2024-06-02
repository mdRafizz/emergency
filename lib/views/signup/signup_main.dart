import 'package:emergency/views/login/login_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../common/custom_textfield.dart';
import '../../common/reusable_text.dart';
import '../../utils/constants.dart';

class SignUpMain extends StatelessWidget {
  const SignUpMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xfff9e5ae),
            Color(0xffb1a99c),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: Center(
                child: Image.asset(
                  'assets/images/safety_logo.png',
                  height: 120.h,
                ),
              ),
            ),
            // const Center(
            //   child: ReusableText(
            //     'SignUp',
            //     fontSize: 27,
            //     letterSpacing: 5,
            //     fontFamily: 'fira',
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Gap(40.h),
            const ReusableText(
              'Username',
              fontSize: 15,
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
            Gap(10.h),
            CustomTextField(
              height: 55.h,
              hintText: 'Enter username',
              prefixIcon: Icon(
                Icons.person,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
              controller: TextEditingController(),
            ),
            Gap(35.h),
            const ReusableText(
              'Email',
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
            Gap(10.h),
            CustomTextField(
              height: 55.h,
              hintText: 'exmaple@gmail.com',
              prefixIcon: Icon(
                Icons.mail_rounded,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
              controller: TextEditingController(),
            ),
            Gap(35.h),
            const ReusableText(
              'Password',
              fontSize: 15,
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
            Gap(10.h),
            CustomTextField(
              height: 55.h,
              hintText: 'Enter password',
              prefixIcon: Icon(
                Icons.password_rounded,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
              controller: TextEditingController(),
            ),
            Gap(45.h),
            MaterialButton(
              onPressed: () {},
              color: Colors.white,
              height: 55.h,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              child: const Center(
                child: ReusableText(
                  'Sign Up',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.9,
                ),
              ),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ReusableText(
                  "Already have an account?",
                  color: Colors.white,
                  fontSize: 13,
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (_) => const LoginMain(),
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Gap(50.h),
          ],
        ),
      ),
    );
  }
}
