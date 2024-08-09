import 'dart:convert';
import 'package:emergency/data/model/number.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../data/model/district.dart';
import '../data/model/division.dart';
import '../data/model/postcode.dart';
import '../data/model/upazila.dart';

Future<List<Division>> loadDivisions() async {
  final String response =
      await rootBundle.loadString('assets/data/bd-divisions.json');
  final data = await json.decode(response);
  return parseDivisions(data);
}

Future<List<District>> loadDistricts() async {
  final String response =
      await rootBundle.loadString('assets/data/bd-districts.json');
  final data = await json.decode(response);
  return parseDistricts(data);
}

Future<List<Upazila>> loadUpazilas() async {
  final String response =
      await rootBundle.loadString('assets/data/bd-upazilas.json');
  final data = await json.decode(response);
  return parseUpazilas(data);
}

Future<List<Postcode>> loadPostcodes() async {
  final String response =
      await rootBundle.loadString('assets/data/bd-postcodes.json');
  final data = await json.decode(response);
  return parsePostcodes(data);
}

Future<List<Number>> loadNumbers() async {
  final String response =
      await rootBundle.loadString('assets/data/bd-number.json');
  final data = await json.decode(response);
  return parseNumbers(data);
}

List<Division> parseDivisions(Map<String, dynamic> json) {
  final parsed = json['divisions'].cast<Map<String, dynamic>>();
  return parsed.map<Division>((json) => Division.fromJson(json)).toList();
}

List<District> parseDistricts(Map<String, dynamic> json) {
  final parsed = json['districts'].cast<Map<String, dynamic>>();
  return parsed.map<District>((json) => District.fromJson(json)).toList();
}

List<Upazila> parseUpazilas(Map<String, dynamic> json) {
  final parsed = json['upazilas'].cast<Map<String, dynamic>>();
  return parsed.map<Upazila>((json) => Upazila.fromJson(json)).toList();
}

List<Postcode> parsePostcodes(Map<String, dynamic> json) {
  final parsed = json['postcodes'].cast<Map<String, dynamic>>();
  return parsed.map<Postcode>((json) => Postcode.fromJson(json)).toList();
}

List<Number> parseNumbers(Map<String, dynamic> json) {
  final parsed = json['phone_number'].cast<Map<String, dynamic>>();
  return parsed.map<Number>((json) => Number.fromJson(json)).toList();
}
