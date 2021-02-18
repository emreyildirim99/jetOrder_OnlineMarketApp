import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emre_yildirim_jetorder/constants/Constants.dart' as Constants;

class RegisterService{

  //UserData
  String userName;
  String userPhone;
  String userEmail;
  String userPassword;
  String userProvince;
  String userDistrict;
  String userAddress;

  RegisterService({this.userName,this.userPhone,this.userEmail,this.userPassword,this.userProvince,this.userDistrict,this.userAddress});


  //Iller
  List<String> provinces = ["İstanbul"];

  //Ilçeler
  List<String> districs = ["Adalar", "Arnavutköy", "Ataşehir", "Avcılar", "Bağcılar","Bahçelievler", "Bakırköy", "Başakşehir", "Bayrampaşa", "Beşiktaş", "Beykoz", "Beylikdüzü", "Beyoğlu", "Büyükçekmece", "Çatalca", "Çekmeköy", "Esenler", "Esenyurt", "Eyüp", "Fatih", "Gaziosmanpaşa", "Güngören", "Kadıköy", "Kâğıthane", "Kartal", "Küçükçekmece", "Maltepe", "Pendik", "Sancaktepe", "Sarıyer", "Silivri", "Sultanbeyli", "Sultangazi", "Şile", "Şişli", "Tuzla", "Ümraniye", "Üsküdar", "Zeytinburnu"];

  List<String> getProvinces(){

    return provinces;
  }

  List<String> getDistricts(){

    return districs;
  }

  Future<String> registerUser() async{

    //Make POST Request to API
    final response = await http.post(Constants.API_URL, body:{
      "operation": "register",
      "userName": this.userName,
      "userPhone": this.userPhone,
      "userEmail": this.userEmail,
      "userPassword": this.userPassword,
      "userProvince": this.userProvince,
      "userDistrict": this.userDistrict,
      "userAddress": this.userAddress,
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether registration is successful
    return result['status'];
  }

}