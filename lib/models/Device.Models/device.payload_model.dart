import 'device_model.dart';

//data model used to DeviceModel payload list

class DevicePayload {
  late List<DeviceModel> _payload;
  late List<Null> _errorMessages;
  late bool _status;

  DevicePayload(
      {required List<DeviceModel> payload,
      required List<Null> errorMessages,
      required bool status}) {
    this._payload = payload;
    this._errorMessages = errorMessages;
    this._status = status;
  }

  List<DeviceModel> get payload => _payload;
  set payload(List<DeviceModel> payload) => _payload = payload;
  List<Null> get errorMessages => _errorMessages;
  set errorMessages(List<Null> errorMessages) => _errorMessages = errorMessages;
  bool get status => _status;
  set status(bool status) => _status = status;

  DevicePayload.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload.add(DeviceModel.fromJson(v));
      });
    }
    if (json['errorMessages'] != null) {
      _errorMessages = [];
      json['errorMessages'].forEach((v) {
        _errorMessages.add(v);
      });
    }
    _status = json['status'];
  }
}
