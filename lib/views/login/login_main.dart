import 'package:emergency/common/custom_textfield.dart';
import 'package:emergency/common/reusable_text.dart';
import 'package:emergency/utils/constants.dart';
import 'package:emergency/views/home/home_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../signup/signup_main.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

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
              controller: _email,
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
              obscureText: true,
              height: 55.h,
              hintText: 'Enter password',
              prefixIcon: Icon(
                Icons.password_rounded,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
              controller: _password,
            ),
            Gap(10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const ReusableText(
                  'Forget Password?',
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            Gap(16.h),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                String? errorMsg = await signUpWithEmailAndPassword(
                  _email.text,
                  _password.text,
                );
                if (errorMsg == null) {
                  _isLoading = false;
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (_) => const HomeMain(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                          ),
                          const Gap(8),
                          Flexible(
                            child: ReusableText(
                              errorMsg,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              color: Colors.white,
              height: 55.h,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              child: Center(
                child: _isLoading
                    ? const CupertinoActivityIndicator(
                        color: Colors.black,
                      )
                    : const ReusableText(
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

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If successful, return null (no error)
      return null;
    } on FirebaseAuthException catch (e) {
      // If sign up fails, return the error message
      return e.message;
    } catch (e) {
      // For other errors, return a generic error message
      return 'Error occurred while signing up. Please try again later.';
    }
  }
}
