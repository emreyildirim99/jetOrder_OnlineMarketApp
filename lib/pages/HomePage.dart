import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emre_yildirim_jetorder/services/HomeService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            FlutterSession().set("userID", 0);
            Navigator.of(context).pushNamed("/LoginPage");
            },
          color: Colors.white,
          tooltip: 'Menu',
        ),
        title: Center(child: Text("jetOrder - Home Page")),
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

  void getFavoriteProducts(){
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': -1}).then((value) => setState(() {selectedIndex = 0;}));
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
      bottomNavigationBar: BottomNavigationBar(),
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
              height: 85,
              width: 85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.blue,
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
          Text("Fruits",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
        ],
      ),Column(
            children: <Widget>[
              InkWell(
                onTap: goVegetables,
                child: Container(
                  height: 85,
                  width: 85,
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
              Text("Vegetables",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          ),Column(
            children: <Widget>[
              InkWell(
                onTap: goSnacks,
                child: Container(
                  height: 85,
                  width: 85,
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
              Text("Snacks",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          ),Column(
            children: <Widget>[
              InkWell(
                onTap: goDrinks,
                child: Container(
                  height: 85,
                  width: 85,
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
              Text("Drinks",style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),)
            ],
          )],
         ),
        ],
      ),
    );
  }

  Widget BottomNavigationBar() {
    List<String> Options = [
      'Home',
      'Favorites',
      'Cart',
      'My Orders',
      'Profile'
    ];

    List<IconData> BarIcons = [
      Icons.home,
      Icons.favorite_border,
      Icons.shopping_cart_rounded,
      Icons.delivery_dining,
      Icons.person_outline
    ];

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xff84CC83),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        children: List.generate(Options.length, (index) {
          if (index == selectedIndex) {
            return Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          BarIcons[index],
                          color: Colors.green,
                        ),
                        Text(
                          Options[index],
                          style: GoogleFonts.varelaRound(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  if(selectedIndex == 1){
                    getFavoriteProducts();
                  }else if(selectedIndex == 2){
                    Navigator.pushNamed(context, '/ShoppingCartPage').then((value) => setState(() {selectedIndex = 0;}));
                  }else if(selectedIndex == 3){
                    Navigator.pushNamed(context, '/MyOrdersPage').then((value) => setState(() {selectedIndex = 0;}));
                  }else if(selectedIndex == 4){
                    Navigator.pushNamed(context, '/ProfilePage').then((value) => setState(() {selectedIndex = 0;}));
                  }
                });
              },
              child: Icon(
                BarIcons[index],
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
