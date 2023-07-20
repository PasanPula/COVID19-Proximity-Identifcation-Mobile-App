import '/models/Device.Models/device_model.dart';

//Model used to nearby device result
//also used Device model

class NearbyDeviceModel {
  late String _id;
  late String _latitude;
  late String _longitude;
  late String _address;
  late String _trackingTime;
  late DeviceModel _device;

  NearbyDeviceModel(
      {required String id,
      required String latitude,
      required String longitude,
      required String address,
      required String trackingTime,
      required DeviceModel device}) {
    this._id = id;
    this._latitude = latitude;
    this._longitude = longitude;
    this._address = address;
    this._trackingTime = trackingTime;
    this._device = device;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get latitude => _latitude;
  set latitude(String latitude) => _latitude = latitude;
  String get longitude => _longitude;
  set longitude(String longitude) => _longitude = longitude;
  String get address => _address;
  set address(String address) => _address = address;
  String get trackingTime => _trackingTime;
  set trackingTime(String trackingTime) => _trackingTime = trackingTime;
  DeviceModel get device => _device;
  set device(DeviceModel device) => _device = device;

  NearbyDeviceModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _latitude = json['latitude'].toString();
    _longitude = json['longitude'].toString();
    _address = json['address'];
    _trackingTime = json['trackingTime'];
    _device =
        (json['device'] != null ? DeviceModel.fromJson(json['device']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['address'] = this._address;
    data['trackingTime'] = this._trackingTime;
    if (this._device != null) {
      data['device'] = this._device.toJson();
    }
    return data;
  }
}
