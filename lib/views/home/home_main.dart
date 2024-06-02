import 'package:emergency/utils/constants.dart';
import 'package:emergency/views/home/tabs/contact_lists.dart';
import 'package:emergency/views/home/tabs/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: [
          Home(),
          Container(),
          ContactLists(),
          Container(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: const BoxDecoration(
          color: Color(0xfffae7af),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          dividerHeight: 0,
          // indicator: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //   color: Colors.white.withOpacity(.94),
          // ),
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 9.h),
          // indicatorPadding: EdgeInsets.symmetric(horizontal: -30.w),
          unselectedLabelColor: Colors.grey.shade400,
          labelColor: Colors.black,
          tabs: [
            Icon(
              Icons.home_rounded,
              size: 26.3.sp,
            ),
            Icon(
              Icons.contact_mail_rounded,
              size: 24.sp,
            ),
            Icon(
              Icons.contact_emergency_rounded,
              size: 24.sp,
            ),
            Icon(
              CupertinoIcons.bell_fill,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
