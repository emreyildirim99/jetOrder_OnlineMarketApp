import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class ProductService{

  String productID;
  String categoryID;
  double productPoint;

  ProductService({this.productPoint,this.productID,this.categoryID});


  Future<List> getProducts(String id, String productName) async{

    //Find Searched Products
   if(id == '0'){

     //Make POST Request to API
     final response = await http.post(Constants.API_URL, body:{
       "operation": "getSearchedProducts",
       "productName": productName
     });

     var result;
     if(response.body.isNotEmpty) {
       result = json.decode(response.body);
     }

     //Return response
     return result;

   }else if(id == '-1'){

     var userID = await FlutterSession().get('userID');

     //Make POST Request to API
     final response = await http.post(Constants.API_URL, body:{
       "operation": "getFavoriteProducts",
       "userID": userID.toString(),
     });

     var result;
     if(response.body.isNotEmpty) {
       result = json.decode(response.body);
     }

     //Return response
     return result;

   }
   else{
     //Make POST Request to API
     final response = await http.post(Constants.API_URL, body:{
       "operation": "getProducts",
       "categoryID": id,
     });

     var result;
     if(response.body.isNotEmpty) {
       result = json.decode(response.body);
     }

     //Return response
     return result;
   }
  }

  Future giveStar () async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "giveStar",
      "userID": userID.toString(),
      "productID" : this.productID.toString(),
      "categoryID" : this.categoryID.toString(),
      "point" : this.productPoint.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }


    //Return whether request is successful
    return result["status"];

  }

}