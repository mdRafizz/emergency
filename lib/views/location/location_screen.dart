import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../data/model/district.dart';
import '../../data/model/division.dart';
import '../../data/model/postcode.dart';
import '../../data/model/upazila.dart';
import '../../utils/utils.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "";
  String addressMessage = "";
  bool isLoading = false;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint('Placemark: $place');

        setState(() {
          addressMessage = "${place.locality}, ${place.postalCode}, ${place.country}";
        });

        // Match with your local JSON data
        await _matchAddressWithJsonData(place);
      } else {
        setState(() {
          addressMessage = "No address found.";
        });
      }
    } catch (e) {
      setState(() {
        addressMessage = 'Error: $e';
      });
      debugPrint('Error: $e');
    }
  }

  Future<void> _matchAddressWithJsonData(Placemark place) async {
    // Assuming your JSON data is already loaded into these lists
    List<Postcode> postcodes = await loadPostcodes();
    List<Upazila> upazilas = await loadUpazilas();
    List<District> districts = await loadDistricts();
    List<Division> divisions = await loadDivisions();

    Postcode? matchingPostcode;
    Upazila? matchingUpazila;
    District? matchingDistrict;
    Division? matchingDivision;

    for (var postcode in postcodes) {
      if (postcode.upazila.toLowerCase() == place.locality.toString().toLowerCase()) {
        matchingPostcode = postcode;
        break;
      }else if(postcode.postCode == place.postalCode){
        matchingPostcode = postcode;
        break;
      }
    }

    if (matchingPostcode != null) {
      matchingUpazila = upazilas.firstWhere((u) => u.name == matchingPostcode!.upazila, orElse: () => Upazila(id: '0', districtId: '0', name: 'Unknown', bnName: 'Unknown'));
      matchingDistrict = districts.firstWhere((d) => d.id == matchingUpazila!.districtId, orElse: () => District(id: '0', divisionId: '0', name: 'Unknown', bnName: 'Unknown', lat: '0', long: '0'));
      matchingDivision = divisions.firstWhere((div) => div.id == matchingDistrict!.divisionId, orElse: () => Division(id: '0', name: 'Unknown', bnName: 'Unknown', lat: '0', long: '0'));

      setState(() {
        addressMessage = '''
        Post Office: ${matchingPostcode?.postOffice ?? 'N/A'}
        Post Code: ${matchingPostcode?.postCode ?? 'N/A'}
        Upazila: ${matchingUpazila?.name ?? 'N/A'} (${matchingUpazila?.bnName ?? 'N/A'})
        District: ${matchingDistrict?.name ?? 'N/A'} (${matchingDistrict?.bnName ?? 'N/A'})
        Division: ${matchingDivision?.name ?? 'N/A'} (${matchingDivision?.bnName ?? 'N/A'})
      ''';
        isLoading = false;
      });
    }


  }

  void _getAddressDetails() async {
    setState(() {
      isLoading = true;
      locationMessage = "";
      addressMessage = "";
    });

    try {
      Position position = await _getCurrentLocation();
      setState(() {
        locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });

      await _getAddressFromLatLng(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        isLoading = false;
        addressMessage = 'Error: $e';
      });
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isLoading)
              CircularProgressIndicator()
            else ...[
              Text(locationMessage),
              Text(addressMessage),
              ElevatedButton(
                onPressed: _getAddressDetails,
                child: Text("Get Current Location"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// Add your JSON loading functions (loadUpazilas, loadPostcodes, loadDistricts, loadDivisions) here