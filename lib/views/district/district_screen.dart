import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/district.dart';
import '../../utils/utils.dart';
import '../upazila/upazila_screen.dart';

class DistrictScreen extends StatefulWidget {
  final String divisionId;
  final String title;

  const DistrictScreen({
    required this.divisionId,
    required this.title,
  });

  @override
  createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  late Future<List<District>> futureDistricts;

  @override
  void initState() {
    super.initState();
    futureDistricts = loadDistricts().then((districts) => districts
        .where((district) => district.divisionId == widget.divisionId)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Districts'),
      ),
      body: FutureBuilder<List<District>>(
        future: futureDistricts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final districts = snapshot.data!;
            return ListView.builder(
              itemCount: districts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(districts[index].name),
                  onTap: () {
                    Get.to(
                      () => UpazilaScreen(
                        districtId: districts[index].id,
                        title: widget.title,
                      ),
                      duration: const Duration(
                        milliseconds: 654,
                      ),
                      transition: Transition.fade,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
