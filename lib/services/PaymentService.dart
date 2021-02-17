import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class PaymentService{

  Future getOrderData() async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "getOrderData",
      "userID": userID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result;
  }

  Future placeOrder(String totalPrice) async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "placeOrder",
      "userID": userID.toString(),
      "totalPrice": totalPrice,
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result['status'];
  }

}