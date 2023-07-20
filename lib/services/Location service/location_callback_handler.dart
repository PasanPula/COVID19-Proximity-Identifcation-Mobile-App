import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/location_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import '../../providers/location_provider.dart';
import '../storage_service.dart';
import 'locations_service.dart';

class LocationCallbackHandler {

  static Future<void> disposeCallback() async {
    final SendPort? send =
        IsolateNameServer.lookupPortByName(LocationServices.isolateName);
    send?.send(null);
  }

  static Future<void> callback(LocationDto locationDto) async {

    if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();

    final SendPort? send =
        IsolateNameServer.lookupPortByName(LocationServices.isolateName);
    send?.send(locationDto);


    LocationProvider().postLocationToServer(locationDto);
  }

  
}