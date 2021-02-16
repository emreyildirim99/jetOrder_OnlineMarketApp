import 'dart:convert';
import 'package:http/http.dart' as http;

class ShoppingCartService{

  int userID;
  int productID;
  int quantity;


  ShoppingCartService({this.userID,this.productID,this.quantity});


  Future addShoppingCart () async{


    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
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

}