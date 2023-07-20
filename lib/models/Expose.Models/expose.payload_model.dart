

import '/models/Expose.Models/expose_model.dart';

class ExposedPayloadModel {
  late List<ExposedModel> _exposedModelList;
  late List<Null> _errorMessages;
  late bool _status;

  ExposedPayloadModel({required List<ExposedModel> payload,required List<Null> errorMessages,required bool status}) {
    _exposedModelList = payload;
    _errorMessages = errorMessages;
    _status = status;
  }

  List<ExposedModel> get exposedModelList => _exposedModelList;
  set exposedModelList(List<ExposedModel> exposedModelList) => _exposedModelList = exposedModelList;
  List<Null> get errorMessages => _errorMessages;
  set errorMessages(List<Null> errorMessages) => _errorMessages = errorMessages;
  bool get status => _status;
  set status(bool status) => _status = status;

   ExposedPayloadModel.fromJsonExpose(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _exposedModelList = <ExposedModel>[];
      json['payload'].forEach((v) {
        _exposedModelList.add(ExposedModel.fromJsonExpose(v));
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

   ExposedPayloadModel.fromJsonStatus(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _exposedModelList = <ExposedModel>[];
      json['payload'].forEach((v) {
        _exposedModelList.add(ExposedModel.fromJsonStatus(v));
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