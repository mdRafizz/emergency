import 'package:emergency/views/login/login_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../common/custom_textfield.dart';
import '../../common/reusable_text.dart';
import '../../utils/constants.dart';

class SignUpMain extends StatefulWidget {
  const SignUpMain({super.key});

  @override
  State<SignUpMain> createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();

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
              controller: _username,
              height: 55.h,
              hintText: 'Enter username',
              prefixIcon: Icon(
                Icons.person,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
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
              controller: _email,
              height: 55.h,
              hintText: 'exmaple@gmail.com',
              prefixIcon: Icon(
                Icons.mail_rounded,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
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
              controller: _password,
              height: 55.h,
              hintText: 'Enter password',
              prefixIcon: Icon(
                Icons.password_rounded,
                size: 20.sp,
                color: AppConstants.kBkDark,
              ),
            ),
            Gap(45.h),
            MaterialButton(
              onPressed: () async {
                if (_email.text.isEmpty ||
                    _password.text.isEmpty ||
                    _username.text.isEmpty) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                          ),
                          Gap(8),
                          ReusableText(
                            'Fill the form first.',
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  setState(() {
                    _isLoading = true;
                  });

                  String? errorMessage = await signUpWithEmailAndPassword(
                    _email.text,
                    _password.text,
                  );

                  if (errorMessage != null) {
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
                                errorMessage,
                                maxLines: 5,
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                            ),
                            Gap(8),
                            ReusableText(
                              'Account successfully created.',
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
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
                    Future.delayed(const Duration(milliseconds: 500), () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (_) => const LoginMain(),
                        ),
                      );
                    });
                  }
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

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
