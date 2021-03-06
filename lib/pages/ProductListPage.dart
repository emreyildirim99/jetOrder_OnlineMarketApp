import 'package:flutter/material.dart';
import 'package:emre_yildirim_jetorder/services/ProductService.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:emre_yildirim_jetorder/services/ShoppingCartService.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          Navigator.pop(context);
          },
        color: Colors.white,
        tooltip: 'Menu',
      ),
      title: Center(child: Text("jetOrder - Product List")),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  _ProductListPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        hintText: "Name of the product",
        onSubmitted: getSearchedProduct,
        buildDefaultAppBar: buildAppBar
    );
  }

  void getSearchedProduct(String productName){
    Navigator.pop(context);
    Navigator.pushNamed(context, '/ProductListPage', arguments: {'categoryID': 0,'productName': productName});
  }

  void openProductInfo(int id, String photoUrl, String price, String name, String quantity,String desc)
  {
    Navigator.pushNamed(context, '/ProductInfoPage', arguments: {'id': id, 'photoUrl':photoUrl, 'name':name, 'desc':desc, 'quantity':quantity, 'price':price}).then((value) => setState(() {}));

  }

  ProductService productHelper = new ProductService();

  List products;

  var categoryID;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> categoryData = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: searchBar.build(context),
      body: FutureBuilder(
        future: productHelper.getProducts(categoryData["categoryID"].toString(),categoryData["productName"].toString()),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            products = snapshot.data;
            categoryID = categoryData["categoryID"].toString();
            return Container(
              padding: EdgeInsets.all(20),
              child: GridView.count(crossAxisCount: 2,
                children: List.generate(snapshot.data.length , listProducts),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
  Container listProducts(int id)
  {
    var rating = double.parse(products[id]["productPoint"]);
    var productID = int.parse(products[id]["productID"]);

    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: InkWell(
        onTap: (){openProductInfo(productID, products[id]["productPhoto"].toString(), products[id]["productPrice"].toString(), products[id]["productName"].toString(), products[id]["productQuantity"].toString(), products[id]["productDesc"].toString());},
        child: Column(
          children: <Widget>[
            Hero(
              tag:'$productID',
              child: Container(
                height: 125,
                child: Image.network(products[id]["productPhoto"]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(products[id]["productPrice"] + '₺' + ' / ' + products[id]["productQuantity"], style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Text(products[id]["productName"], style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),),
            ),
          SmoothStarRating(
            rating: rating,
            isReadOnly: false,
            size: 25,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: false,
            spacing: 2.0,
            onRated: (value) async{
              ProductService point = new ProductService(productID: products[id]["productID"], productPoint: value, categoryID: categoryID);
              var status = await point.giveStar();
              if(status == 'success'){

                SweetAlert.show(context,
                    title: "Rated!",
                    subtitle: "You give $value point !",
                    style: SweetAlertStyle.success);
              }
            },
          ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 0.5,
              color: Colors.grey,
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async{
                    ShoppingCartService addProduct = new ShoppingCartService(userID: await FlutterSession().get('userID'), productID: int.parse(products[id]["productID"]), quantity: 1);
                    var result = await addProduct.addShoppingCart();
                    if(result=='success'){
                      SweetAlert.show(context,
                          title: "Successful!",
                          subtitle: "Successfully added product to your cart.",
                          style: SweetAlertStyle.success);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        gradient: LinearGradient(
                            colors: [HexColor("#CB356B"), HexColor("#EF476F")],
                            stops: [0,1],
                            begin: Alignment.topCenter
                        )
                    ),
                    child: Center(
                      child: Wrap(children: [Icon(Icons.add_shopping_cart,color: Colors.white,),Text("Add to cart", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                      ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
