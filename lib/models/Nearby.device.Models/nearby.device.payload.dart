import 'nearby.device_model.dart';

//data model used to nearby device models payload list

class NearDevicePayloadModel {
  late List<NearbyDeviceModel> _nearbyDeviceModel;
  late List<Null> _errorMessages;
  late bool _status;

  NearDevicePayloadModel(
      {required List<NearbyDeviceModel> nearbyDeviceModel,
      required List<Null> errorMessages,
      required bool status}) {
    _nearbyDeviceModel = nearbyDeviceModel;
    _errorMessages = errorMessages;
    _status = status;
  }

  List<NearbyDeviceModel> get nearbyDeviceModelList => _nearbyDeviceModel;
  set nearbyDeviceModelList(List<NearbyDeviceModel> payload) =>
      _nearbyDeviceModel = payload;
  List<Null> get errorMessages => _errorMessages;
  set errorMessages(List<Null> errorMessages) => _errorMessages = errorMessages;
  bool get status => _status;
  set status(bool status) => _status = status;

  NearDevicePayloadModel.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _nearbyDeviceModel = <NearbyDeviceModel>[];
      json['payload'].forEach((v) {
        _nearbyDeviceModel.add(NearbyDeviceModel.fromJson(v));
      });
    }
    if (json['errorMessages'] != null) {
      _errorMessages = <Null>[];
      json['errorMessages'].forEach((v) {
        _errorMessages.add(v);
      });
    }
    _status = json['status'];
  }
}
