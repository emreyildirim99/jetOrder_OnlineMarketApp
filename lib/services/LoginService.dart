import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService{

  String email;
  String password;

  LoginService({this.email,this.password});

  Future loginUser() async{

    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "login",
      "email": this.email,
      "password": this.password,
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return response
    return result;
  }

}