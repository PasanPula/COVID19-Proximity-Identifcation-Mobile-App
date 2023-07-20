//model used to send recoded loactions to server

class LocationModel {
  late double _latitude;
  late double _longitude;
  late String _trackingTime;
  late String _address;
  late int _deviceId;

  LocationModel(
      {required double latitude,
      required double longitude,
      required String trackingTime,
      required String address,
      required int deviceId}) {
    _latitude = latitude;
    _longitude = longitude;
    _trackingTime = trackingTime;
    _address = address;
    _deviceId = deviceId;
  }

  double get latitude => _latitude;
  set latitude(double latitude) => _latitude = latitude;
  double get longitude => _longitude;
  set longitude(double longitude) => _longitude = longitude;
  String get trackingTime => _trackingTime;
  set trackingTime(String trackingTime) => _trackingTime = trackingTime;
  String get address => _address;
  set address(String address) => _address = address;
  int get deviceId => _deviceId;
  set deviceId(int deviceId) => _deviceId = deviceId;

  // LocationModel.fromJson(Map<String, dynamic> json) {
  //   _latitude = json['latitude'];
  //   _longitude = json['longitude'];
  //   _trackingTime = json['trackingTime'];
  //   _address = json['address'];
  //   _id = json['id'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    data['trackingTime'] = _trackingTime;
    data['address'] = _address;
    data['deviceId'] = _deviceId;
    return data;
  }
}
