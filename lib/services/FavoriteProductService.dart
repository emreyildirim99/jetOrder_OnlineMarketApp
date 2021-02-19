import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class FavoriteProductService{

  //Favorite Product Data
  int userID;
  int productID;

  FavoriteProductService({this.userID,this.productID});


  Future addFavorite () async{



     //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "addFavorite",
      "userID": this.userID.toString(),
      "productID" : this.productID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether request is successful
    return result["status"];

  }


}