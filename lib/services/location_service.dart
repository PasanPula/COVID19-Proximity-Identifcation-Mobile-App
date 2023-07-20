// import 'dart:async';
// import 'dart:convert';
// import '/models/Nearby.device.Models/nearby.device.payload.dart';
// import '/models/nearby.filter_model.dart';
// import '/models/Nearby.device.Models/nearby.device_model.dart';
// import '../models/location_model.dart';
// import '../services/geocoder_service.dart';
// import '../services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';

// import 'api services/device_api_services.dart';
// import 'api services/location_api_services.dart';

// // *************************   SERVICE USED BY HOME SCREEEN WITOUT PROVIDER DIRECTLY *******************************
// class LocationService with ChangeNotifier {
//   //create empty location model
//   LocationModel _currentlocationModel = LocationModel(
//       latitude: 0.0,
//       longitude: 0.0,
//       trackingTime: "No data",
//       address: "No data",
//       deviceId: 0);

// //for nearby device
//   String distanceLabel = "5m";
//   double distance = 0.005;
//   int toggleindex = 0;

// //for gmaps
//   Marker? _marker;
//   GoogleMapController? _controller;
//   late LatLng latlng;

// //for button loading indictor and color change
//   bool _loader = false;
//   bool _clicks = false;

//   LocationModel get currentlocation => _currentlocationModel;
//   Marker? get marker => _marker;
//   bool get loader => _loader;
//   bool get clicks => _clicks;

// //location service - location package
// //for location service permission check
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//   LocationData? _currentPosition;
//   String _dateTime = "0";
//   int locationUpdateInterval = 2000;
//   String _address = "No data";
//   int _deviceId = 0; //set dummy id

//   String get address => _address;
//   String get date => _dateTime;

//   double _oldLatitude = 1.0;
//   double _oldLongitude = 1.0;
//   double _newLatitude = 0.0;
//   double _newLongitude = 0.0;
//   final _geoservice =
//       GeocoderService(); //instance of address generating service
//   final _apiservice =
//       LocationApiSerivces(); //instacnce of api backend communication

// //for timer
//   bool isStopped = true;

// //Location Straem
//  StreamSubscription<LocationData>?  locationSubscription;


// startlocationService() async {

//   // NotificationService().showNotification(
//   //   id: 0,
//   //   channel: 'CovTrack',
//   //   channeldescription: 'CovTrack Location Tracing',
//   //   payloads: 'CovTrack background tracing is runnning..'
//   // );

//   if(locationSubscription != null && locationSubscription!.isPaused )
//   {
//     setsClicks(true);
//     setsLoader(true);
//     locationSubscription!.resume();
//     _loader = false;
//      notifyListeners();
//   }
//   else
//   {
//     await getlocation();
//   }
// }



// /////////// get location method ////////////////////
//   getlocation() async {
//     //set button color change and loading indicator show true
//     setsClicks(true);
//     setsLoader(true);

//     Location location = Location();

// //get server genarated id from storage
//     if (await StrorageService().checkID()) {
//       _deviceId = await StrorageService().getID();
//     }

// //serice check
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         // return; Not handled
//       }
//     }

// //permission check
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         // return; not handled
//       }
//     }

// //location updating frequncy parameters
//     location.changeSettings(
//         accuracy: LocationAccuracy.high,
//         interval: locationUpdateInterval, //update location every 2sec or 2min
//         distanceFilter: 11); // update if 11m change in location
//     location.enableBackgroundMode(enable: true); //start as foreground service

//     location.changeNotificationOptions(
//         //foreground service notification  **can't run as foreground without notification
//         onTapBringToFront: true,
//         title: 'CovTrack',
//         subtitle: 'Location enabled',
//         description: 'Location',
//         color: Colors.red.shade300,
//         iconName: "ic_stat_emoji_people");

//     _currentPosition = await location.getLocation(); //get last saved location

//     if (_currentPosition != null) {
//       _newLatitude = truncateDecimal(_currentPosition!.latitude!);
//       _newLongitude = truncateDecimal(_currentPosition!.longitude!);
//       updateUI(_currentPosition);
//     }

   

//     //run if location changed
//     locationSubscription =  location.onLocationChanged.listen((LocationData currentLocation) async {
//       _currentPosition =
//           currentLocation; //update old location with new location if location changed

//       updateUI(currentLocation);
//       if (currentLocation.accuracy! <= 20) {
//         locationUpdateInterval = 200000;

//         // const oneSec = Duration(seconds:60);
//         // Timer.periodic(oneSec, (Timer t) => print('****** hi! **********'));

//         //update new location
//         _newLatitude = truncateDecimal(currentLocation.latitude!);
//         _newLongitude = truncateDecimal(currentLocation.longitude!);

//         if (!(_newLatitude == _oldLatitude) &&
//             !(_newLongitude == _oldLongitude)) {
//           isStopped = true;
//           print("\n\n\n ****New  Location - Send  Stopped****\n\n\n");
//           //update old location with new location
//           _oldLatitude = _newLatitude;
//           _oldLongitude = _newLongitude;

//           //optional address retrive - if updateUI respond slow
//           _address = await _geoservice.getAddressFromLatLng(
//               currentLocation.latitude!, currentLocation.longitude!);
//           //get time
//           DateTime now = DateTime.now();
//           _dateTime = now.toIso8601String();

//           _currentlocationModel = LocationModel(
//               latitude: truncateDecimal(_currentPosition!.latitude!),
//               longitude: truncateDecimal(_currentPosition!.longitude!),
//               trackingTime: _dateTime,
//               address: _address,
//               deviceId: _deviceId);

//           await _apiservice
//               .sendLocation(_currentlocationModel); //send date to backend

//           //send old data every mintue
//           isStopped = false;
//           timerServerUpdateServer();
//         }
//       } else {
//         locationUpdateInterval = 2000;
//       }
//     });
//   }

// //stop subscription
//   pauseLocationSubscription() 
//   {
//     locationSubscription!.pause();
//     setsClicks(false);
//   }


// //update UI
//   updateUI(LocationData? position) async {
//     //get adress of currrent location
//     _address = await _geoservice.getAddressFromLatLng(
//         position!.latitude!, position.longitude!);
//     //get time
//     DateTime now = DateTime.now();
//     _dateTime = now.toIso8601String();
//     //locaion parametters for gmaps
//     latlng = LatLng(position.latitude!, position.longitude!);

//     // google maps marker
//     _marker = Marker(
//       markerId: const MarkerId("1"),
//       position: latlng,
//       draggable: false,
//       zIndex: 2,
//       flat: true,
//       anchor: const Offset(0.5, 0.5),
//       icon: BitmapDescriptor.defaultMarker,
//     );

//     //animate gmaps loation marker changed
//     _controller!.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(bearing: 0.0, target: latlng, tilt: 0, zoom: 18.00)));
//     _loader = false;
//     notifyListeners();
//     _controller!.dispose(); //dispose gmaps controller
//   }

//   timerServerUpdateServer() {
//     if (!isStopped) {
//       //if timer is on
//       Timer.periodic(const Duration(seconds: 60), (timer) async {

//         DateTime now = DateTime.now();
//           _dateTime = now.toIso8601String();
//         _currentlocationModel.trackingTime =  _dateTime;

//         if (isStopped) {
//           print("\n\n\n **** Location Stopped****\n\n\n");
//           timer.cancel();
//         }
//         print("**** Location Send  60 seconds****");
//         await _apiservice.sendLocation(_currentlocationModel);
//       });
//     }
//   }

// // Get gmaps controller directly form home screen
//   onMapCreated(GoogleMapController ctlr) {
//     _controller = ctlr;
//     notifyListeners();
//   }

// //update loading indicator
//   setsLoader(bool condition) {
//     _loader = condition;
//     notifyListeners();
//   }

// //check user click the button
//   setsClicks(bool condition) {
//     _clicks = condition;
//     notifyListeners();
//   }

// //format date in home page - checked in
//   String formatReadeableDate(String date) {
//     var dt = DateTime.parse(date);
//     return DateFormat("MMMMd").format(dt);
//   }

// //format time home page - checked in
//   String formatReadeableTime(String date) {
//     var dt = DateTime.parse(date);
//     return DateFormat("h:mm a").format(dt);
//   }

// //realtime nearby device distance update
//   updateDistance(int index) {
//     setToggleindex(index);
//     if (index == 0) {
//       setDistanceLabel("5m");
//       setDiastanceValue(0.005);
//     } else if (index == 1) {
//       setDistanceLabel("10m");
//       setDiastanceValue(0.010);
//     } else if (index == 2) {
//       setDistanceLabel("20m");
//       setDiastanceValue(0.020);
//     } else if (index == 3) {
//       setDistanceLabel("30m");
//       setDiastanceValue(0.030);
//     } else {
//       setDistanceLabel("5m");
//       setDiastanceValue(0.005);
//     }
//     notifyListeners();
//   }

// //set distance label
//   setDistanceLabel(String val) {
//     distanceLabel = val;
//     notifyListeners();
//   }

// //set distance value
//   setDiastanceValue(double val) {
//     distance = val;
//     notifyListeners();
//   }

// //distance toggle
//   setToggleindex(int tgl) {
//     toggleindex = tgl;
//     notifyListeners();
//   }

//   //truncate lat and long decimal places
//   double truncateDecimal(double input, {int precision = 4}) => double.parse(
//       '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

//   late int _deviceId2;
//   late String _selectedDate2 = DateFormat("yyyy-MM-dd").format(DateTime.now());
//   String _startTime2 = "00:00";
//   String _endTime2 = "23:59";
//   int deviceCount = 0;

//   setDeviceCount2(int tgl) {
//     deviceCount = tgl;
//     notifyListeners();
//   }

//   Future<int> getDeviceId() async {
//     int deviceId = 0;
//     if (await StrorageService().checkID()) {
//       deviceId = await StrorageService().getID();
//       return deviceId;
//     }
//     return deviceId;
//   }

//   //format time from date
//   formatTime() async {
//     _startTime2 = DateFormat("Hm")
//         .format(DateTime.now().subtract(const Duration(minutes: 30)));
//     _endTime2 = DateFormat("Hm").format(DateTime.now());
//   }

// //for nearbydevice screen device list -- fetch nearby devices
//   Future<List<NearbyDeviceModel>> fetchRealtimeNearbyDeivces() async {
//     try {
//       _deviceId2 = await getDeviceId();
//       await formatTime();

//       NearbyFilterModel model = NearbyFilterModel(
//         date: _selectedDate2,
//         deviceId: _deviceId2,
//         endTime: _endTime2,
//         startTime: _startTime2,
//         // distance: _distance
//       );
//       var value = await DeviceApiService().fetchNearbyDevice(model);

//       // print("Nearby device response body :${value.body}");

//       if (value.statusCode == 200) {
//         var _jsonResponse =
//             NearDevicePayloadModel.fromJson(json.decode(value.body));

//         print("\n\n ${json.decode(value.body)} \n\n");
//         print(
//             "\n\n Length: ${_jsonResponse.nearbyDeviceModelList.length} \n\n");

//         deviceCount = _jsonResponse.nearbyDeviceModelList.length;

//         return _jsonResponse.nearbyDeviceModelList;
//       } else {
//         throw Exception('Unable to fetch data');
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
