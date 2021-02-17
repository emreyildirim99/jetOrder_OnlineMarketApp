import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteProductService{

  //Favorite Product Data
  int userID;
  int productID;

  FavoriteProductService({this.userID,this.productID});


  Future addFavorite () async{



     //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
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

  Future IsFavorite () async{


    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "isFavorite",
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