import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class ProfileService{

  //UserData
  String userPassword;
  String userProvince;
  String userDistrict;
  String userAddress;

  ProfileService({this.userPassword,this.userProvince,this.userDistrict,this.userAddress});


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

  Future getProfileData() async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "getProfileData",
      "userID": userID.toString(),
    });

    var result;
    if(response.body.isNotEmpty) {
      result = json.decode(response.body);
    }

    //Return whether registration is successful
    return result;
  }

  Future updateProfileData() async{

    var userID = await FlutterSession().get('userID');

    //Make POST Request to API
    final response = await http.post("http://10.0.2.2/jetorder/index.php", body:{
      "operation": "updateProfileData",
      "userID": userID.toString(),
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