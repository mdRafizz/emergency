import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency/common/reusable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  final user = FirebaseAuth.instance.currentUser;
  String? username;
  String? bloodGroup;
  String? dob;
  String? photoUrl;
  var dataFaced = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
        ),
      ),
      body: dataFaced
          ? ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
              children: [
                Gap(20.h),
                CachedNetworkImage(
                  imageUrl: photoUrl!,
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: const Color(0xfff5f8f3),
                    radius: 55.h,
                    child: CupertinoActivityIndicator(
                      radius: 6.sp,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    backgroundColor: const Color(0xfff5f8f3),
                    radius: 55.h,
                  ),
                ),
                Gap(30.h),
                Row(
                  children: [
                    const ReusableText(
                      "Name:",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    ReusableText(
                      "    $username",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ],
                ),
                Gap(30.h),
                Row(
                  children: [
                    const ReusableText(
                      "Age:",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    ReusableText(
                      "    ${calculateAge(dob!)}",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ],
                ),
                Gap(30.h),
                Row(
                  children: [
                    const ReusableText(
                      "Blood Group:",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    ReusableText(
                      "    $bloodGroup",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ],
                ),
              ],
            )
          : const Center(child: CupertinoActivityIndicator()),
    );
  }

  Future<void> getUserData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      if (docSnapshot.exists) {
        setState(() {
          final data = docSnapshot.data();
          username = data!['name'] as String; // Cast to String
          bloodGroup = data['bloodGroup'] as String;
          dob = data['dob'] as String;
          photoUrl = data['photoUrl'] as String;
          if (kDebugMode) {
            print(username);
            print(bloodGroup);
            print(dob);
            print(photoUrl);
          }
          dataFaced = true;
        });
      } else {
        if (kDebugMode) {
          print("User document does not exist");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user data: $e");
      }
    }
  }

  int calculateAge(String birthDateString) {
    // Parse the birth date string using Intl's date format
    final formatter = DateFormat('MMMM d, yyyy'); // Adjust format if needed
    final birthDate = formatter.parse(birthDateString);

    // Get today's date
    final today = DateTime.now();

    // Calculate age in years
    int age = today.year - birthDate.year;

    // Check if birthday has passed in the current year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
