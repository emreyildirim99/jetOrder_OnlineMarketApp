import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class OrderDetailsService{

  String orderCode;

  OrderDetailsService({this.orderCode});

  Future getOrderDetails () async{


    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "getOrderDetails",
      "orderCode": this.orderCode,
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return response
    return result;

  }



}