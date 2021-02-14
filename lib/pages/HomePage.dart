import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emre_yildirim_jetorder/services/HomeService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {Navigator.of(context).pushNamed("/LoginPage");},
          color: Colors.white,
          tooltip: 'Menu',
        ),
        title: Center(child: Text("jetOrder")),
        actions: [searchBar.getSearchAction(context)],
    );
  }
  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        hintText: "Name of the product",
        onSubmitted: getSearchedProduct,
        buildDefaultAppBar: buildAppBar
    );
  }


  HomeService homeHelper = new HomeService();

  void goFruits(){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 1});
  }

  void goVegetables(){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 2});
  }

  void goSnacks(){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 3});
  }

  void goDrinks(){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 4});
  }

  void getSearchedProduct(String productName){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 0,'productName': productName});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Center(child: Image.asset('assets/images/banner.png',width: 250,height: 250,)),
              createCategories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget createCategories() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Categories',
                  style: GoogleFonts.varelaRound(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Column(
          children: <Widget>[
            InkWell(
              onTap: goFruits,
              child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Image.asset(
                "assets/images/fruits.png",
              ),
          ),
            ),
          SizedBox(height: 5),
          Text("Meyveler",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
        ],
      ),Column(
            children: <Widget>[
              InkWell(
                onTap: goVegetables,
                child: Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/vegetable.png",
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text("Sebzeler",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          ),Column(
            children: <Widget>[
              InkWell(
                onTap: goSnacks,
                child: Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/snacks2.png",
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text("Atıştırmalık",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          ),Column(
            children: <Widget>[
              InkWell(
                onTap: goDrinks,
                child: Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/drink.png",
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text("İçecekler",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          )],
         ),
        ],
      ),
    );
  }

}
