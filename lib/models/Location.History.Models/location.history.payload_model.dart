import 'location.history_model.dart';

//data model used to locationHistory model payload list
class LocationHistoryPayloadModel {
  late List<LocationHistoryModel> _locationHistory;
  late List<Null> _errorMessages;
  late bool _status;

  LocationHistoryPayloadModel(
      {required List<LocationHistoryModel> locationHistory,
      required List<Null> errorMessages,
      required bool status}) {
    _locationHistory = locationHistory;
    _errorMessages = errorMessages;
    _status = status;
  }

  List<LocationHistoryModel> get locationHistory => _locationHistory;
  set locationHistory(List<LocationHistoryModel> locationHistory) =>
      _locationHistory = locationHistory;
  List<Null> get errorMessages => _errorMessages;
  set errorMessages(List<Null> errorMessages) => _errorMessages = errorMessages;
  bool get status => _status;
  set status(bool status) => _status = status;

  LocationHistoryPayloadModel.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _locationHistory = <LocationHistoryModel>[];
      json['payload'].forEach((v) {
        _locationHistory.add(LocationHistoryModel.fromJson(v));
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
