class RegisterService{

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

}