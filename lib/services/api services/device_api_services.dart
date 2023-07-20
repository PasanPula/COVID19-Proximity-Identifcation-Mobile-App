import 'dart:convert';

import '../storage_service.dart';
import '/models/Device.Models/device_model.dart';
import '/models/nearby.filter_model.dart';
import '/config/api.dart';
import 'package:http/http.dart' as http;

class DeviceApiService {
  Future<http.Response> saveDevice(DeviceModel data) async {
    final http.Response response = await http.post(
      Uri.parse(Apis.deviceSignUpApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );

    return response; //retrun response to device provider
  }

  Future<http.Response> fetchNearbyDevice(NearbyFilterModel data) async {

  // print("*****************************$data");

    var response = null;
    Uri uri = Uri.parse(Apis.nearByDeviceApi);
    uri = uri.replace(queryParameters: data.toQueryParams());
    print("uri ${uri}");
    response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(data.toJson()),
    );
    print("*****************************${response.body}");
    return response; //return to nearby.device.history.provider
  }


   Future<http.Response> checkStatus() async {
    var response = null;
    if (await StrorageService().checkID()) {
      response = await http.get(Uri.parse(
          Apis.checkStatusApi + (await StrorageService().getID()).toString()));
    }

    print("***Status check ${response.body}");


    return response; //return response to start provider
  }




}
