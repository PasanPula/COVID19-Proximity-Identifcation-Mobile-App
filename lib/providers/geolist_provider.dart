import 'dart:convert';
import '/services/api%20services/location_api_services.dart';
import '../models/Location.History.Models/location.history.payload_model.dart';
import '../models/Location.History.Models/location.history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//provider responsible for geolist screen
class Geolistprovider with ChangeNotifier {
  late LocationHistoryPayloadModel _jsonResponse;

//get loaction history and parse to list
  Future<List<LocationHistoryModel>> fetchGeoHistory() async {
    var value = await LocationApiSerivces().fetchHistory();

    if (value.statusCode == 200) {
      _jsonResponse =
          LocationHistoryPayloadModel.fromJson(json.decode(value.body));
      return _jsonResponse.locationHistory;
      //     .map<LocationModel>((item) => LocationModel.fromJson(item))
      //     .toList();
    } else {
      throw Exception('Unable to fetch data');
    }
  }

//format date to y-m-d
  String formatDate(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("yyyy-MM-dd").format(dt);
  }

//format time from date and add 10 min
  String formatEndTime(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("Hm").format(dt);
  }

//format time from date
  String formatStartTime(String date) {
    var dt = DateTime.parse(date).subtract(const Duration(minutes: 30));
    return DateFormat("Hm").format(dt);
  }
}

//format date for display in geolist
String formatReadeableDate(String date) {
  var dt = DateTime.parse(date);
  return DateFormat("MMMMd").format(dt);
}

//format time for display in geolist
String formatReadeableTime(String date) {
  var dt = DateTime.parse(date);
  return DateFormat("h:mm a").format(dt);
}
