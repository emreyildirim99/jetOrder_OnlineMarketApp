import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class ShoppingCartService{

  int userID;
  int productID;
  int quantity;


  ShoppingCartService({this.userID,this.productID,this.quantity});


  Future addShoppingCart () async{


    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "addShoppingCart",
      "userID": this.userID.toString(),
      "productID" : this.productID.toString(),
      "quantity" : this.quantity.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result["status"];

  }

  Future getShoppingCart () async{


    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "getShoppingCart",
      "userID": userID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return response
    return result;

  }

  Future getTotalPrice () async{


    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "getTotalPrice",
      "userID": userID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return response
    return result;

  }

  Future updateShoppingCart (String operation) async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": operation == 'add' ? "addProductShoppingCart" : "removeProductShoppingCart",
      "userID": userID.toString(),
      "productID" : this.productID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
   return result['status'];

  }

  Future emptyShoppingCart () async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "emptyShoppingCart",
      "userID": userID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result['status'];

  }

  Future deleteProduct () async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "deleteProductShoppingCart",
      "userID": userID.toString(),
      "productID" : this.productID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result['status'];

  }

}