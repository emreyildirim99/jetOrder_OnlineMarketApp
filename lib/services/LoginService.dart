import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class LoginService{

  String email;
  String password;

  LoginService({this.email,this.password});

  Future loginUser() async{

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "login",
      "email": this.email,
      "password": this.password,
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);


      var userID = result["userID"] != 0 ? result["userID"] : '';
      //Set Session to keep users logged in & auto login
      await FlutterSession().set('userID', userID);
    }

    //Return response
    return result;
  }

}