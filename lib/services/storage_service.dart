import 'package:background_locator/location_dto.dart';

import '/models/Device.Models/device.payload_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// *************************   SERVICE USED TO STORE AND RETRIVE DATA FROM LOCAL STROEAGE *******************************

class StrorageService {
  //Save device from automatic device registraction
  addDevice(DevicePayload data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'deviceName', '${data.payload[0].deviceName}'); //save device name
    prefs.setString(
        'deviceID', '${data.payload[0].deviceId}'); //save device genarated id
    prefs.setInt(
        'id', int.parse(data.payload[0].id!)); // save server genarated id
    prefs.setInt(
        'userID', data.payload[0].userId); // save server genarated  user id

    setRegistered();
  }

//custom user id save
  addUserID(int userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userID', userid);
  }

//confirm userid saved
  Future<bool> checkUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userID');
    return checkValue;
  }

  //set device is reistered flag
  setRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await checkUserID() && await checkID()) {
      prefs.setBool('isRegistered', true);
    }
  }

//confirm device is registered from checking strorage
  Future<bool> checkRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('isRegistered');
    return checkValue;
  }

//check server genarated id
  Future<bool> checkID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('id');
    return checkValue;
  }

//check device genarated id
  Future<bool> checkDeviceID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('deviceID');
    return checkValue;
  }

//return server id
  Future<int> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('id')!;
    return value;
  }

//return device id **not using device info service to get device id only used this method to get id from storage
  Future<String> getDeviceID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    value = prefs.getString('deviceID')!;
    return value;
  }

//temp -- debug purpose
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove('id');
    prefs.remove('deviceName');
    prefs.remove('deviceID');
    prefs.remove('isRegistered');
  }

//exposed to positive person or not
  setIsExposed(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsExposed", value);
  }

//check contain isExposed exit
    Future<bool> checkIsExposed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey("IsExposed");
    return checkValue;
  }

  //exposed person qurentine end date
  setQurentineEndDate(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("QurentineEndDate", date);
  }

   Future<String> getQurentineEndDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    value = prefs.getString("QurentineEndDate")!;
    return value;
  }

  //check contain isExposed exit
    Future<bool> checkQurentineEndDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey("QurentineEndDate");
    return checkValue;
  }


  //save last location

  Future<void> saveLastLocation(LocationDto data)async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', '${data.latitude}');
    prefs.setString('longitude', '${data.longitude}');

  }

   Future<String> getLastlatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    value = prefs.getString("latitude")!;
    return value;
  }
   Future<String> getLastlongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    value = prefs.getString("longitude")!;
    return value;
  }

  Future<bool> checkLastLocation() 
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey("latitude");
    return checkValue;
  }

  Future<void> renoveLastLocation() async 
  {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove('latitude');
    prefs.remove('longitude');
  }

Future<void> setServiceRuning()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isServiceRuning', true);
  }

   //check contain isExposed exit
    Future<bool> checkServiceRuning() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey("isServiceRuning");
    return checkValue;
  }


//temp -- debug purpose
  removeService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove('isServiceRuning');
  }





}
