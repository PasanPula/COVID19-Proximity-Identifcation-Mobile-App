import 'dart:convert';
import '/models/Nearby.device.Models/nearby.device.payload.dart';
import '/models/Nearby.device.Models/nearby.device_model.dart';
import '/services/api%20services/device_api_services.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../models/nearby.filter_model.dart';
import 'package:intl/intl.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';

//provider for nearby device filter  and nearbydevice screeen  and geolist screeen

class NearByDeviceprovider with ChangeNotifier {
  // filterDevice() {}

  late String _selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String _startTime = "00:00";
  String _endTime = "23:59";
  late int _deviceId;
  late double _distance = 0.005; //in KMs
  String distanceLabel = "5 Meters";
  // int deviceCount = 0;

  int toggleindex = 0; //for distance toggle

  String get selectedDate => _selectedDate;
  String get startTime => _startTime;
  String get endTime => _endTime;

  setToggleindex(int tgl) {
    toggleindex = tgl;
    notifyListeners();
  }

//set device count nearby
  // setDeviceCount(int tgl) {
  //   deviceCount = tgl;
  // //  notifyListeners();
  // }

//set distsnce -not using
  setDistanceLabel(String val) {
    distanceLabel = val;
    notifyListeners();
  }

  //format date in home page - checked in
  ReadeableDate() {
    var dt = DateTime.parse(_selectedDate);
    return DateFormat("MMMMd").format(dt);
  }

  //used for data selection widget in  nearbydevice screeen
  setselectedDate(date) {
    // DateFormat inputFormat = DateFormat("yyyy-MM-dd");
    // var dt = inputFormat.parse(date);
    _selectedDate = date;
    notifyListeners();
  }

  //used for time selection widget in  nearbydevice screeen
  setStartTime(time) {
    _startTime = time;
    notifyListeners();
  }

  //used for time selection widget in  nearbydevice screeen
  setDistance(dist) {
    _distance = dist;
    // notifyListeners();
  }

  //used for data time widget in  nearbydevice screeen
  setEndTime(time) {
    _endTime = time;
    notifyListeners();
  }

  //for nearby device model in geolist screeen
  Future<int> getDeviceId() async {
    int deviceId = 0;
    if (await StrorageService().checkID()) {
      deviceId = await StrorageService().getID();
      return deviceId;
    }
    return deviceId;
  }

//for nearbydevice screen device list -- fetch nearby devices
  Future<List<NearbyDeviceModel>> fetchNearbyDeivces() async {
    try {
      _deviceId = await getDeviceId();

      NearbyFilterModel model = NearbyFilterModel(
        date: _selectedDate,
        deviceId: _deviceId,
        endTime: _endTime,
        startTime: _startTime,
        // distance: _distance
      );

      var value = await DeviceApiService().fetchNearbyDevice(model);

      // print("Nearby device response body :${value.body}");

      if (value.statusCode == 200) {
        var _jsonResponse =
            NearDevicePayloadModel.fromJson(json.decode(value.body));

        print("\n\n ${json.decode(value.body)} \n\n");
        return _jsonResponse.nearbyDeviceModelList;
      } else {
        throw Exception('Unable to fetch data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  updateDistance(int index) {
    setToggleindex(index);
    if (index == 0) {
      setDiastanceValue(0.005);
      setDistanceLabel("5 Meters");
    } else if (index == 1) {
      setDiastanceValue(0.010);
      setDistanceLabel("10 Meters");
    } else if (index == 2) {
      setDiastanceValue(0.020);
      setDistanceLabel("20 Meters");
    } else if (index == 3) {
      setDiastanceValue(0.030);
      setDistanceLabel("30 Meters");
    } else {
      setDiastanceValue(0.005);
      setDistanceLabel("5 Meters");
    }
    notifyListeners();
  }

//set distance value
  setDiastanceValue(double val) {
    _distance = val;
    notifyListeners();
  }

  void datePop(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Select Date",
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DatePicker(
                      DateTime.now().subtract(const Duration(days: 20)),
                      initialSelectedDate: DateTime.now(),
                      daysCount: 21,
                      selectionColor: Colors.deepPurpleAccent,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setselectedDate(DateFormat("yyyy-MM-dd").format(date));
                      },
                    ),
                  ),
                  const Icon(Icons.arrow_right_rounded,
                      color: Colors.black87, size: 30),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Done",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void DistancePop(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            backgroundColor: Colors.white,
            title: Text(
              "Select Distance radius",
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    initialLabelIndex: toggleindex,
                    totalSwitches: 4,
                    labels: const ['5m', '10m', '20m', '30m'],
                    activeBgColor: const [Colors.deepPurpleAccent],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey.shade200,
                    inactiveFgColor: Colors.grey[900],
                    onToggle: (index) {
                      updateDistance(index!);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Done",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//format time nearby device history page
  String formatReadeableDate(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("MMMMd").format(dt);
  }

//format time nearby device history page
  String formatReadeableTime(String date) {
    var dt = DateTime.parse(date);
    return DateFormat("h:mm a").format(dt);
  }
}

//helper code
// return _jsonResponse
//     .map<NearbyDeviceModel>((item) => NearbyDeviceModel.fromJson(item))
//     .toList();

//        Map<String, dynamic> result = json.decode(data.body),
// setMessage(result['message']),
