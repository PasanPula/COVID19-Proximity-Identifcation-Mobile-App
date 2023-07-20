import '/models/user.Models/user_model.dart';

class UserPayloadModel {
  late List<UserModel> _userModelList;
  late List<Null> _errorMessages;
  late bool _status;

  UserPayloadModel(
      {required List<UserModel> userModelList,
      required List<Null> errorMessages,
      required bool status}) {
    _userModelList = userModelList;
    _errorMessages = errorMessages;
    _status = status;
  }

  List<UserModel> get userModelList => _userModelList;
  set userModelList(List<UserModel> userModelList) =>
      _userModelList = userModelList;
  List<Null> get errorMessages => _errorMessages;
  set errorMessages(List<Null> errorMessages) => _errorMessages = errorMessages;
  bool get status => _status;
  set status(bool status) => _status = status;

  UserPayloadModel.fromJson(Map<String, dynamic> json) {
    if (json['payload'] != null) {
      _userModelList = <UserModel>[];
      json['payload'].forEach((v) {
        _userModelList.add(UserModel.fromJson(v));
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
