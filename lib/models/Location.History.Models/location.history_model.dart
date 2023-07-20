//data model used to location history

class LocationHistoryModel {
  late int _id;
  late double _latitude;
  late double _longitude;
  late String _address;
  late String _trackingTime;
  late int _deviceId;

  LocationHistoryModel(
      {required int id,
      required double latitude,
      required double longitude,
      required String address,
      required String trackingTime,
      required int deviceId}) {
    _id = id;
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    _trackingTime = trackingTime;
    _deviceId = deviceId;
  }

  int get id => _id;
  set id(int id) => _id = id;
  double get latitude => _latitude;
  set latitude(double latitude) => _latitude = latitude;
  double get longitude => _longitude;
  set longitude(double longitude) => _longitude = longitude;
  String get address => _address;
  set address(String address) => _address = address;
  String get trackingTime => _trackingTime;
  set trackingTime(String trackingTime) => _trackingTime = trackingTime;
  int get deviceId => _deviceId;
  set deviceId(int deviceId) => _deviceId = deviceId;

  LocationHistoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _address = json['address'];
    _trackingTime = json['trackingTime'];
    _deviceId = json['deviceId'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this._id;
  //   data['latitude'] = this._latitude;
  //   data['longitude'] = this._longitude;
  //   data['address'] = this._address;
  //   data['trackingTime'] = this._trackingTime;
  //   data['deviceId'] = this._deviceId;
  //   return data;
  // }
}






// //data model used to location history

// class LocationHistoryModel {
//   late int _id;
//   late double _latitude;
//   late double _longitude;
//   late String _address;
//   late String _trackingTime;
//   late String _deviceId;

//   LocationHistoryModel(
//       {required int id,
//       required double latitude,
//       required double longitude,
//       required String address,
//       required String trackingTime,
//       required String deviceId}) {
//     _id = id;
//     _latitude = latitude;
//     _longitude = longitude;
//     _address = address;
//     _trackingTime = trackingTime;
//     _deviceId = deviceId;
//   }

//   int get id => _id;
//   set id(int id) => _id = id;
//   double get latitude => _latitude;
//   set latitude(double latitude) => _latitude = latitude;
//   double get longitude => _longitude;
//   set longitude(double longitude) => _longitude = longitude;
//   String get address => _address;
//   set address(String address) => _address = address;
//   String get trackingTime => _trackingTime;
//   set trackingTime(String trackingTime) => _trackingTime = trackingTime;
//   String get deviceId => _deviceId;
//   set deviceId(String deviceId) => _deviceId = deviceId;

//   LocationHistoryModel.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _latitude = json['latitude'];
//     _longitude = json['longitude'];
//     _address = json['address'];
//     _trackingTime = json['trackingTime'];
//     _deviceId = json['deviceId'];
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['id'] = this._id;
//   //   data['latitude'] = this._latitude;
//   //   data['longitude'] = this._longitude;
//   //   data['address'] = this._address;
//   //   data['trackingTime'] = this._trackingTime;
//   //   data['deviceId'] = this._deviceId;
//   //   return data;
//   // }
// }
