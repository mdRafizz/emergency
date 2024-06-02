import 'package:emergency/common/custom_textfield.dart';
import 'package:emergency/common/reusable_text.dart';
import 'package:emergency/utils/constants.dart';
import 'package:emergency/views/home/home_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../signup/signup_main.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

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
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Center(
                child: Image.asset(
                  'assets/images/safety_logo.png',
                  height: 165.h,
                ),
              ),
            ),
            // const Center(
            //   child: ReusableText(
            //     'LogIn',
            //     fontSize: 27,
            //     letterSpacing: 5,
            //     fontFamily: 'fira',
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Gap(40.h),
            const ReusableText(
              'Email',
              fontSize: 15,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
              prefixIcon: Icon(Icons.password_rounded,size: 20.sp,color: AppConstants.kBkDark,),
              controller: TextEditingController(),
            ),
            Gap(10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: ReusableText(
                  'Forget Password?',
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            Gap(16.h),
            MaterialButton(
              onPressed: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => const HomeMain(),
                ),
              ),
              color: Colors.white,
              height: 55.h,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              child: const Center(
                child: ReusableText(
                  'LogIn',
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
                  "Don't have an account?",
                  color: Colors.white,
                  fontSize: 13,
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (_) => const SignUpMain(),
                    ),
                  ),
                  child: const ReusableText(
                    'Sign Up',
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Gap(50.h),
          ],
        ),
      ),
    );
  }
}
