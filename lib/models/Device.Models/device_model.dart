//data model used to device register and recorde response

class DeviceModel {
  late String _deviceName;
  late String _deviceId;
  String? _id;
  late int _userId;

  DeviceModel(
      {required String deviceName,
      required String deviceId,
      String? id,
      required int userId}) {
    _deviceName = deviceName;
    _deviceId = deviceId;
    _id = id;
    _userId = userId;
  }

  String get deviceName => _deviceName;
  set deviceName(String deviceName) => _deviceName = deviceName;
  String get deviceId => _deviceId;
  set deviceId(String deviceId) => _deviceId = deviceId;
  String? get id => _id;
  set id(String? id) => _id = id;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;

  DeviceModel.fromJson(Map<String, dynamic> json) {
    _deviceName = json['name'];
    _deviceId = json['deviceId'];
    _id = json['id'];
    _userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceName'] = _deviceName;
    data['deviceId'] = _deviceId;
    data['userId'] = _userId;
    return data;
  }
}
