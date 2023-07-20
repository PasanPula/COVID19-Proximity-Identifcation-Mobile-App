import 'dart:convert';
import '/models/Device.Models/device.payload_model.dart';
import '/models/Device.Models/device_model.dart';
import 'package:flutter/cupertino.dart';
import '/services/dialog.builder_service.dart';
import '/services/api%20services/device_api_services.dart';
import '/services/deviceinfo_service.dart';
import '/services/storage_service.dart';
import '/models/User.Models/user.payload_model.dart';
import '/models/user.Models/user_model.dart';
import '/services/api%20services/user_api_services.dart';
import 'package:flutter/material.dart';

//********************* Prvider works with register page
//have  error in showing popup dialog box loader

class Registerprovider with ChangeNotifier {
  //text controllers in form
  late final TextEditingController _firstNameController =
      TextEditingController();
  late final TextEditingController _nicNumberController =
      TextEditingController();
  late final TextEditingController _lastnameController =
      TextEditingController();
  late final TextEditingController _mobilenumberController =
      TextEditingController();

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get nicNumberController => _nicNumberController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get mobilenumberController => _mobilenumberController;



//Dropdown list
  final List<String> _TypeList = [
    'Student',
    'Lecturer',
    'Non Academic Staff',
    'Minor Staff'
  ];
  String _dropDownValue = 'Student';
  List<String> get TypeList => _TypeList;
  String get dropDownValue => _dropDownValue;

  String _BackendDropDownValue = 'STUDENT';

  void setDropDownValue(String val) {

    if(val=='Non Academic Staff')
    {
      _BackendDropDownValue ='NON_ACADEMIC_STAFF';
    }
    else if (val =='Minor Staff')
    {
      _BackendDropDownValue ='MINOR_STAFF';
    }
    else
    {
      _BackendDropDownValue = val.toUpperCase();
    }
    _dropDownValue = val;
    notifyListeners();
  }

//form utitlities
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formKey;

//check is number and return bool
  bool isNumeric(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

//check is a letter and return bool
  bool isAplph(String string) {
    final alphabatRegex = RegExp(r'^[A-Za-z]+$');
    return alphabatRegex.hasMatch(string);
  }


  late BuildContext _context;
//run on when submit clicks
  onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // setLoadingDialog(true); //show loading
      _context = context;
      showloadingIndicate(_context);
      UserModel user = UserModel(
          firstName: _firstNameController.text,
          lastName: _lastnameController.text,
          nic: _nicNumberController.text,
          userType: _BackendDropDownValue,   // _dropDownValue.toUpperCase(),
          phoneNumber: _mobilenumberController.text);

        // UserApiServices().saveuser2(user);
      await registerUser(user); //save user on backend
    }
  }

//save user on backend
  var _jsonResponse;
  late UserPayloadModel userpayload;
  registerUser(user) async {
    try {
      var response = await UserApiServices().saveUser(user);
      print("Register reesponse*******${response.body}");
      if (response.statusCode == 200) {
        _jsonResponse = json.decode(response.body);
        userpayload = UserPayloadModel.fromJson(_jsonResponse);
        if (userpayload.userModelList.isNotEmpty) {
          await saveDevice(userpayload.userModelList[0].id!);
        }
      } else {
        hideloadingIndicate(_context);
        registerFailDialog(_context);
      }
    } catch (e,s) {
      
      hideloadingIndicate(_context);
      registerFailDialog(_context);
      print(e);
      // throw Exception(e);
    }
  }

//save device on backend
  DeviceModel? _device;
  late DevicePayload _devicePayload;
  saveDevice(int userid) async {
    _device = await DeviceInfoService()
        .getDeviceInfo(); //get device androidid and name
    if (_device != null) {
      _device = DeviceModel(
          deviceName: _device!.deviceName,
          deviceId: _device!.deviceId,
          userId: userid);
      try {
        var response = await DeviceApiService().saveDevice(_device!);
        if (response.statusCode == 200) {
          _jsonResponse = json.decode(response.body);
          _devicePayload = DevicePayload.fromJson(_jsonResponse);
          await StrorageService().addDevice(_devicePayload);
          hideloadingIndicate(_context);
          registerSucessDialog(_context);
        } else {
          hideloadingIndicate(_context);
          registerFailDialog(_context);
        }
      } catch (e) {
        hideloadingIndicate(_context);
        registerFailDialog(_context);
        throw Exception(e);
      }
    } else {
      hideloadingIndicate(_context);
      registerFailDialog(_context);
    }
  }

//sucess popup
  void registerSucessDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.done_rounded,
                      color: Colors.green,
                    ),
                    Text("Sucess"),
                  ],
                ),
              ],
            ),
            content: const Text(
                "Sucessfully registered the device. \n Continue to use Application.."),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Continue"),
                onPressed: () {
                  Navigator.of(context).pop();
                  print("done");
                  Navigator.pushNamed(context, '/starttrace');
                },
              ),
            ],
          );
        });
  }

//register fail popup
  void registerFailDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    Text("Error"),
                  ],
                ),
              ],
            ),
            content: const Text("Register Failed.Try after sometime"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }

  // show loading dialog popup
  void showloadingIndicate(BuildContext context) {
    DialogBuilder(context).showLoadingIndicator("Creating profile");
  }

//hide loading popup
  void hideloadingIndicate(BuildContext context) {
    DialogBuilder(context).hideOpenDialog();
  }
}
