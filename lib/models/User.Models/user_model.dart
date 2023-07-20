class UserModel {
  int? _id;
  late String _firstName;
  late String _lastName;
  late String _userType;
  late String _nic;
  late String _phoneNumber;
  String? _devices;

  UserModel(
      {int? id,
      required String firstName,
      required String lastName,
      required String userType,
      required String nic,
      required String phoneNumber,
      String? devices}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _userType = userType;
    _nic = nic;
    _phoneNumber = phoneNumber;
    _devices = devices;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get userType => _userType;
  set userType(String userType) => _userType = userType;
  String get nic => _nic;
  set nic(String nic) => _nic = nic;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  String? get devices => _devices;
  set devices(String? devices) => _devices = devices;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _userType = json['userType'];
    _nic = json['nic'];
    _phoneNumber =json['phoneNumber'].toString();
    // _devices = json['devices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = _firstName;
    data['lastName'] = _lastName;
    data['userType'] = _userType;
    data['nic'] = _nic;
    data['phoneNumber'] = _phoneNumber;
    return data;
  }
}
