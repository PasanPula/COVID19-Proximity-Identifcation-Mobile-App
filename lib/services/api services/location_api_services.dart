import 'dart:convert';

import '/config/api.dart';
import '/services/storage_service.dart';
import '/models/location_model.dart';
import 'package:http/http.dart' as http;

class LocationApiSerivces {
  sendLocation(LocationModel data) async {
    final http.Response response = await http.post(
      Uri.parse(Apis.saveLocationApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );

    print(" \n \n \n***** location ${jsonEncode(data.toJson())} *** \n \n \n ");


    if (response.statusCode == 200) {
      // ******  nothing happend after sucessfull location update

       print(" \n \n \n***** location Send to server *** \n \n \n ");
     // return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Send data');
    }
  }

  Future<http.Response> fetchHistory() async {
    var response = null;
    if (await StrorageService().checkID()) {
      response = await http.get(Uri.parse(
          Apis.getLocationApi + (await StrorageService().getID()).toString()));
    }
    return response; //return response to geolist provider
  }
}
