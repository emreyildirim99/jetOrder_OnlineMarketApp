import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ProductService{


  Future<List> getProducts(String id, String productName) async{

    //Find Searched Products
   if(id == '0'){

     //Make POST Request to API
     final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
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
     final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
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
     final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
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

}