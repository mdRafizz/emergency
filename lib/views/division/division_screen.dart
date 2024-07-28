import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/model/division.dart';
import '../../utils/utils.dart';
import '../district/district_screen.dart';

class DivisionScreen extends StatefulWidget {
  const DivisionScreen({super.key});

  @override
  createState() => _DivisionScreenState();
}

class _DivisionScreenState extends State<DivisionScreen> {
  late Future<List<Division>> futureDivisions;

  @override
  void initState() {
    super.initState();
    futureDivisions = loadDivisions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Divisions'),
      ),
      body: FutureBuilder<List<Division>>(
        future: futureDivisions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final divisions = snapshot.data!;
            return ListView.builder(
              itemCount: divisions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(divisions[index].name),
                  onTap: () {
                    Get.to(
                          () => DistrictScreen(divisionId: divisions[index].id),
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
