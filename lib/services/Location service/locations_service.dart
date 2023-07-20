import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';


import 'package:location/location.dart' as navperm;

import 'location_callback_handler.dart';



class LocationServices 
{
  static const String isolateName = 'LocatorIsolate';
  // static final LocationServices  _instance = LocationServices._();
  //For bg operate
  // late ReceivePort port;
    //for location pemission check
  late bool _serviceEnabled;
  late navperm.PermissionStatus _permissionGranted;

  // LocationServices._();
  // factory LocationServices() {
  //   return _instance;
  // }
  static var intervals = 5;
  void init(ReceivePort port) {
    // port = ReceivePort();

    if (IsolateNameServer.lookupPortByName(isolateName) != null) {
      IsolateNameServer.removePortNameMapping(isolateName);
    }

    IsolateNameServer.registerPortWithName(port.sendPort,isolateName);
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    print('Running ${_isRunning.toString()}');
  }

   Future<bool> _checkLocationPermission() async {
    navperm.Location location = navperm.Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted ==navperm.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

     if (_serviceEnabled && _permissionGranted == navperm.PermissionStatus.granted ) {
        return true;
      } else {
        return false;
      }
  }

   

   Future<void> _startLocator() async {
    // Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        // initCallback: LocationCallbackHandler.initCallback,
        // initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: const IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        autoStop: false,
        androidSettings: const AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 11,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'CovTrack Location Tracing',
                notificationMsg: 'Background location tracing is running',
                notificationBigMsg:
                    'This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                // notificationTapCallback:LocationCallbackHandler.notificationCallback
                    )));
  }



 Future<bool> onStart() async {
    if (await _checkLocationPermission()) {
      print("***********started ");
      await _startLocator();

       print("***********run:${BackgroundLocator.isServiceRunning()} ");
      return await BackgroundLocator.isServiceRunning();
    } else {
      print("*******not started");
      return false;
    }
  }

  Future<bool> onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    return !(await BackgroundLocator.isServiceRunning());
  }





  // Future<void> disposed() async {
  //   print("***********Dispose callback handler");
  //   // print("$_count");
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(null);
  // }

  // Future<void> callbacked(LocationDto locationDto) async {
  //   print('location in dart: ${locationDto.toString()}');
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(locationDto);
  // }


  // Future<void> dispose() async {
  //   print("***********Dispose callback handler");
  //   // print("$_count");
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(null);
  // }

  // Future<void> callback(LocationDto locationDto) async {
  //   print('location in dart: ${locationDto.toString()}');
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(locationDto);
  // }
  
}