import 'package:flutter/material.dart';

import '../../data/model/postcode.dart';
import '../../data/model/upazila.dart';
import '../../utils/utils.dart';

class UpazilaScreen extends StatefulWidget {
  final String districtId;

  const UpazilaScreen({required this.districtId});

  @override
  createState() => _UpazilaScreenState();
}

class _UpazilaScreenState extends State<UpazilaScreen> {
  late Future<List<Upazila>> futureUpazilas;
  late Future<List<Postcode>> futurePostcodes;

  @override
  void initState() {
    super.initState();
    futureUpazilas = loadUpazilas().then((upazilas) =>
        upazilas.where((upazila) => upazila.districtId == widget.districtId).toList());
    futurePostcodes = loadPostcodes().then((postcodes) =>
        postcodes.where((postcode) => postcode.districtId == widget.districtId).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upazilas'),
      ),
      body: FutureBuilder<List<Upazila>>(
        future: futureUpazilas,
        builder: (context, upazilaSnapshot) {
          if (upazilaSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (upazilaSnapshot.hasError) {
            return Center(child: Text('ErrorU: ${upazilaSnapshot.error}'));
          } else {
            final upazilas = upazilaSnapshot.data!;
            return FutureBuilder<List<Postcode>>(
              future: futurePostcodes,
              builder: (context, postcodeSnapshot) {
                if (postcodeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (postcodeSnapshot.hasError) {
                  return Center(child: Text('ErrorP: ${postcodeSnapshot.error}'));
                } else {
                  final postcodes = postcodeSnapshot.data!;
                  return ListView.builder(
                    itemCount: upazilas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${upazilas[index].name} (${upazilas[index].bnName})'),
                        subtitle: Text('  -Post Office: ${postcodes[index].postOffice}\n  -Postcode: ${postcodes[index].postCode}'),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}