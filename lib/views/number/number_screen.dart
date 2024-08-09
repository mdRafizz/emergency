import 'package:emergency/common/reusable_text.dart';
import 'package:emergency/data/model/number.dart';
import 'package:emergency/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({
    super.key,
    required this.title,
    required this.upazillaId,
  });

  final String title;
  final String upazillaId;

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late Future<List<Number>> futureNumbers;

  @override
  void initState() {
    super.initState();
    futureNumbers = loadNumbers().then((numbers) => numbers
        .where((number) => number.upazilla_id == widget.upazillaId)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Number>>(
        future: futureNumbers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final numbers = snapshot.data!;
            return ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return content(numbers[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget content(Number num){
    switch(widget.title){
      case 'Police Station':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            ReusableText('Number: ${num.police_num}',fontSize: 20,),
            Gap(22.h),
            ElevatedButton(
              onPressed: () {
                makePhoneCall(num.police_num);
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.call,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Make Call',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
            Gap(15.h),
            ElevatedButton(
              onPressed: () {
                openSMS(num.police_num, 'Please help me...');
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.message,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Send message',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Hospital':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            ReusableText('Number: ${num.hospital_num}',fontSize: 20,),
            Gap(22.h),
            ElevatedButton(
              onPressed: () {
                makePhoneCall(num.hospital_num);
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.call,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Make Call',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
            Gap(15.h),
            ElevatedButton(
              onPressed: () {
                openSMS(num.hospital_num, 'Please help me...');
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.message,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Send message',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Fire Service':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            ReusableText('Number: ${num.fire_service}',fontSize: 20,),
            Gap(22.h),
            ElevatedButton(
              onPressed: () {
                makePhoneCall(num.fire_service);
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.call,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Make Call',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
            Gap(15.h),
            ElevatedButton(
              onPressed: () {
                openSMS(num.fire_service, 'Please help me...');
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.message,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Send message',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Bus Station':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            ReusableText('Number: ${num.bus_station}',fontSize: 20,),
            Gap(22.h),
            ElevatedButton(
              onPressed: () {
                makePhoneCall(num.bus_station);
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.call,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Make Call',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
            Gap(15.h),
            ElevatedButton(
              onPressed: () {
                openSMS(num.bus_station, 'Please help me...');
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.message,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Send message',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Pharmacy':
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            ReusableText('Number: ${num.pharmacy}',fontSize: 20,),
            Gap(22.h),
            ElevatedButton(
              onPressed: () {
                makePhoneCall(num.pharmacy);
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.call,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Make Call',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
            Gap(15.h),
            ElevatedButton(
              onPressed: () {
                openSMS(num.pharmacy, 'Please help me...');
              },
              child: SizedBox(
                width: 150.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 13.h,),
                  child: Row(
                    children: [
                      Icon(Icons.message,color: Colors.black,size: 20.sp,),
                      Gap(9.w),
                      const ReusableText('Send message',fontSize: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
  void openSMS(String phoneNumber, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(message),
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }

}
