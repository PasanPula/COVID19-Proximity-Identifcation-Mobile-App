import 'dart:convert';
import '/config/api.dart';
import '/models/Expose.Models/expose_model.dart';
import '/models/user.Models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiServices {

  Future<http.Response> saveUser(UserModel data) async {
    // print("Register request*******${data.toJson()}");

    // await Future<void>.delayed(Duration(seconds: 3));

    final http.Response response = await http.post(
      Uri.parse(Apis.usersignUpApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         "Connection": "Keep-Alive"
      },
      body: jsonEncode(data),
    );

    return response; //retrun response to register provider
  }


   Future<http.Response> markAffected(ExposedModel data) async {

    print("MarkAffected request*******${data.toJson()}");

    final http.Response response = await http.post(
      Uri.parse(Apis.markAffectApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );

    print("MarkAffected response*******${response.body}");


    return response; //retrun response to start provider
  }


}
