import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency/app_route.dart';
import 'package:emergency/views/login/login_main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
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
  String _dob = 'Select your birthday';
  String _bloodGroup = 'O+';

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  _uploadData() async {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _username.text.isEmpty ||
        _dob == 'Select your birthday' ||
        _photo == null) {
      Get.snackbar(
        'Empty form!',
        'Fill all the form first.',
      );
    } else {
      try {
        setState(() {
          _isLoading = true;
        });
        signUpWithEmailAndPassword(_email.text, _password.text);
        final fileName = _email.text;
        final destination = 'files/$fileName';
        final ref = FirebaseStorage.instance.ref(destination).child('file/');
        final uploadTask = ref.putFile(_photo!);
        final snapshot = await uploadTask.whenComplete(() => null);
        final url = await snapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection('users').doc(_email.text).set({
          'email': _email.text,
          'name': _username.text,
          'photoUrl': url,
          'fileName': fileName,
          'dob': _dob,
          'bloodGroup': _bloodGroup,
        }).then(
          (_) {
            setState(() {
              _isLoading = false;
            });
            Get.offNamed(AppRoutes.login);
            Get.snackbar(
              'Account Created!',
              'Account created successfully.\nLog in to continue.',
            );
          },
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar(
          'Failed!',
          '$e',
        );
      }
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  final bloodGroups = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff9e5ae),
              Color(0xffb1a99c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Center(
                child: Image.asset(
                  'assets/images/safety_logo.png',
                  height: 50.h,
                ),
              ),
            ),
            const Center(
              child: ReusableText(
                'Select Profile Picture',
                fontSize: 15,
                letterSpacing: 1.5,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins',
              ),
            ),
            Gap(10.h),
            Center(
              child: GestureDetector(
                onTap: () {
                  imgFromGallery();
                },
                child: CircleAvatar(
                  radius: 55.h,
                  backgroundColor: const Color(0xffe8dcbe),
                  child: _photo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50.h),
                          child: Image.file(
                            _photo!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50.h),
                          ),
                          width: 100.w,
                          height: 100.h,
                          child: Icon(
                            Icons.add_photo_alternate_rounded,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            Gap(35.h),
            const ReusableText(
              'Name',
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
              hintText: 'Enter your name',
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
              'Date of Birth',
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () => _datePicker(context),
              child: Container(
                height: 45.h,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(right: 130.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  color: Color(0xffe8dcbe),
                ),
                child: Text(
                  _dob,
                  style: TextStyle(
                    color: _dob == 'Select your birthday'
                        ? Colors.black54
                        : Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Gap(35.h),
            const ReusableText(
              'Blood Group',
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              padding: EdgeInsets.only(right: 130.w),
              hint: const Text(
                'Select your blood group',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                ),
              ),
              value: _bloodGroup,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'poppins',
              ),
              items: bloodGroups.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: ReusableText(
                    value,
                    fontSize: 14,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _bloodGroup = newValue!;
                });
              },
              decoration: const InputDecoration(
                fillColor: Color(0xffe8dcbe),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
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
              onPressed: _uploadData,
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
                  onTap: () => Get.offNamed(AppRoutes.login),
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

  void _datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dob = DateFormat.yMMMMd('en_US').format(picked);
      });
    }
  }
}
