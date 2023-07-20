import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'dart:io';

import 'package:background_locator/location_dto.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Nearby.device.Models/nearby.device.payload.dart';
import '../models/Nearby.device.Models/nearby.device_model.dart';
import '../models/location_model.dart';
import '../models/nearby.filter_model.dart';
import '../services/Location service/location_callback_handler.dart';
import '../services/Location service/locations_service.dart';
import '../services/api services/device_api_services.dart';
import '../services/api services/location_api_services.dart';
import '../services/geocoder_service.dart';
import '../services/storage_service.dart';


class LocationProvider extends ChangeNotifier {
  static final LocationProvider _instance = LocationProvider._();

  LocationProvider._();

  factory LocationProvider() {
    return _instance;
  }


  //create empty location model
  LocationModel _currentlocationModel = LocationModel(
      latitude: 0.0,
      longitude: 0.0,
      trackingTime: "No data",
      address: "No data",
      deviceId: 0);

//for nearby device
  String distanceLabel = "5m";
  double distance = 0.005;
  int toggleindex = 0;

//for button loading indictor and color change
  bool _loader = false;
  bool _clicks = false;

  LocationModel get currentlocation => _currentlocationModel;
  bool get loader => _loader;
  bool get clicks => _clicks;

  String _dateTime = "0";
  int locationUpdateInterval = 2000;
  String _address = "No data";
  int _deviceId = 0; //set dummy id

  String get address => _address;
  String get date => _dateTime;

  double _oldLatitude = 1.0;
  double _oldLongitude = 1.0;
  double _newLatitude = 0.0;
  double _newLongitude = 0.0;

//for gmaps
  Marker? _marker;
  GoogleMapController? _controller;
  late LatLng latlng;
  Marker? get marker => _marker;

  final _geoservice =
      GeocoderService(); //instance of address generating service
  final _apiservice =
      LocationApiSerivces(); //instacnce of api backend communication
  final _locationService = LocationServices();

//for timer
  bool isStopped = true;

  late ReceivePort gloabalPort;
  late StreamSubscription sub;

  void inizialize(ReceivePort port) {
    _locationService.init(port);
  }

  Future<void> startTrace(ReceivePort port) async {
    gloabalPort = port;

    setsClicks(true);
    setsLoader(true);
    _deviceId = await getDeviceId();
    if (await _locationService.onStart()) {
      StrorageService().setServiceRuning();
      portListen(port);
    }
  }

  Future<void> portListen(ReceivePort port) async
  {
      port.listen(
        (dynamic data) async {
          updateUI(data);
        },
      );
  }

  // Future<void> locationUpdate(LocationDto locationDto) async {
  //   print(" \n \n \n data: $locationDto \n \n \n ");
  //   await updateUI(locationDto);
  //    _loader = false;
  //    notifyListeners();
  // }

  void stopTrace() {
    _locationService.onStop();
    setsClicks(false);
    setsLoader(false);
    StrorageService().removeService();
    if(timwera != null)
        {
           print(" Timer cancelled \n \n \n ");
           print(timwera.isActive);
           timwera.cancel();
        }
  }

  Future<bool> initcheck(ReceivePort port) async {
    if (await StrorageService().checkServiceRuning()) {
      setsClicks(true);
      if (await StrorageService().checkLastLocation()) {
        updateUI2(double.parse(await StrorageService().getLastlatitude()),
            double.parse(await StrorageService().getLastlongitude()));
      }
      portListen(port);
      return true;
    } else {
      return false;
    }
  }

  dynamic timwera;

  timerServerUpdateServer() {
    timwera = Timer.periodic(const Duration(seconds: 60), (timer) async {
      DateTime now = DateTime.now();
      _dateTime = now.toIso8601String();
      _currentlocationModel.trackingTime = _dateTime;

      // if (isStopped) {
      //   print("\n\n\n **** Location Timer Stopped****");
      //   timer.cancel(); 
      // }
      // else
      // {
        print(" Timer location update triggered \n \n \n ");
        await _apiservice.sendLocation(_currentlocationModel);
      // }

        
    });
  }

  Future<void> postLocationToServer(LocationDto locationDto) async {

    _newLatitude = truncateDecimal(locationDto.latitude);
    _newLongitude = truncateDecimal(locationDto.longitude);


    if (await StrorageService().checkLastLocation()) {
      await StrorageService().renoveLastLocation();
    }

    await StrorageService().saveLastLocation(locationDto);
   
    _deviceId = await StrorageService().getID();

    if (locationDto.accuracy <= 20) {
      print(" \n \n \n location below 20m  ");
      if (!(_newLatitude == _oldLatitude) &&
          !(_newLongitude == _oldLongitude)) {
        print(" Unique location \n \n \n ");

        if(timwera != null)
        {
           print(" Timer cancelled \n \n \n ");
           print(timwera.isActive);
           timwera.cancel();
        }
        else
        {
        print(" NO Timer ************\n \n \n ");
        }
    

      

        _oldLatitude = _newLatitude;
        _oldLongitude = _newLongitude;

        

        //optional address retrive - if updateUI respond slow
        _address = await _geoservice.getAddressFromLatLng(
            locationDto.latitude, locationDto.longitude);
        //get time
        DateTime now = DateTime.now();
        _dateTime = now.toIso8601String();

        _currentlocationModel = LocationModel(
            latitude: truncateDecimal(locationDto.latitude),
            longitude: truncateDecimal(locationDto.longitude),
            trackingTime: _dateTime,
            address: _address,
            deviceId: _deviceId);

        await _apiservice
            .sendLocation(_currentlocationModel); //send date to backend

        //send old data every mintue
        // isStopped = false;
        timerServerUpdateServer();
      }
    }
  }



  //update UI
  updateUI(LocationDto position) async {
    // print(" \n \n \n UI Update \n \n \n ");
    //get adress of currrent location
    _address = await _geoservice.getAddressFromLatLng(
        position.latitude, position.longitude);
    //get time
    DateTime now = DateTime.now();
    _dateTime = now.toIso8601String();
    //locaion parametters for gmaps
    latlng = LatLng(position.latitude, position.longitude);

    // google maps marker
    _marker = Marker(
      markerId: const MarkerId("1"),
      position: latlng,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.defaultMarker,
    );

    //animate gmaps loation marker changed
    _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 0.0, target: latlng, tilt: 0, zoom: 18.00)));
    _loader = false;
    notifyListeners();
    _controller!
        .dispose(); //dispose gmaps controller //dispose gmaps controller
  }

  //update UI
  updateUI2(double lat, double long) async {
    print(" \n \n \n ReLaunch UI Update \n \n \n ");

    //get adress of currrent location
    _address = await _geoservice.getAddressFromLatLng(lat, long);
    //get time
    DateTime now = DateTime.now();
    _dateTime = now.toIso8601String();
    //locaion parametters for gmaps
    latlng = LatLng(lat, long);

    // google maps marker
    _marker = Marker(
      markerId: const MarkerId("1"),
      position: latlng,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.defaultMarker,
    );

    //animate gmaps loation marker changed
    _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 0.0, target: latlng, tilt: 0, zoom: 18.00)));
    _loader = false;
    notifyListeners();
    _controller!
        .dispose(); //dispose gmaps controller //dispose gmaps controller
  }

  // Get gmaps controller directly form home screen
  onMapCreated(GoogleMapController ctlr) {
    _controller = ctlr;
    notifyListeners();
  }

  //truncate lat and long decimal places
  double truncateDecimal(double input, {int precision = 4}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  //update loading indicator
  setsLoader(bool condition) {
    _loader = condition;
    notifyListeners();
  }

//check user click the button
  setsClicks(bool condition) {
    _clicks = condition;
    notifyListeners();
  }

//format date in home page - checked in
  String formatReadeableDate(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("MMMMd").format(dt);
  }

//format time home page - checked in
  String formatReadeableTime(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("h:mm a").format(dt);
  }

// ==================================== Nearby device fetch ===============================

  late int _deviceId2;
  late String _selectedDate2 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String _startTime2 = "00:00";
  String _endTime2 = "23:59";
  int deviceCount = 0;

  setDeviceCount2(int tgl) {
    deviceCount = tgl;
    notifyListeners();
  }

  Future<int> getDeviceId() async {
    int deviceId = 0;
    if (await StrorageService().checkID()) {
      deviceId = await StrorageService().getID();
      return deviceId;
    }
    return deviceId;
  }

  //format time from date
  formatTime() async {
    _startTime2 = DateFormat("Hm")
        .format(DateTime.now().subtract(const Duration(minutes: 30)));
    _endTime2 = DateFormat("Hm").format(DateTime.now());
  }

//for nearbydevice screen device list -- fetch nearby devices
  Future<List<NearbyDeviceModel>> fetchRealtimeNearbyDeivces() async {
    try {
      _deviceId2 = await getDeviceId();
      await formatTime();

      NearbyFilterModel model = NearbyFilterModel(
        date: _selectedDate2,
        deviceId: _deviceId2,
        endTime: _endTime2,
        startTime: _startTime2,
        // distance: _distance
      );
      var value = await DeviceApiService().fetchNearbyDevice(model);

      // print("Nearby device response body :${value.body}");

      if (value.statusCode == 200) {
        var _jsonResponse =
            NearDevicePayloadModel.fromJson(json.decode(value.body));

        // print("\n\n ${json.decode(value.body)} \n\n");
        // print(
            // "\n\n Length: ${_jsonResponse.nearbyDeviceModelList.length} \n\n");

        deviceCount = _jsonResponse.nearbyDeviceModelList.length;

        return _jsonResponse.nearbyDeviceModelList;
      } else {
        throw Exception('Unable to fetch data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

