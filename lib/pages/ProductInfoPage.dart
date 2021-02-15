import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class ProductInfo extends StatefulWidget {
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> productData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: (){Navigator.pop(context);},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.favorite_border
            ),
          )
        ],
      ),
      body: Container(
        color: HexColor("#83CC98"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(13),
                child: Text('${productData['name']}', style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Hero(
                tag: '${productData['id']}',
                child: Container(
                  height: MediaQuery.of(context).size.height*0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${productData['photoUrl']}"),
                          fit: BoxFit.contain,
                      )
                  ),
                ),
              ),
            ),
            Container(
              color: HexColor("#83CC98"),
              padding: EdgeInsets.only(left: 160, top: 10),
              
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('${productData['price']}₺', style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    child: Text(' /${productData['quantity']}', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    color: HexColor("#83CC98"),
                    padding: EdgeInsets.all(25),
                    child: Text("${productData['desc']}", style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 25, right: 25),
              alignment: Alignment.bottomCenter,
              color: HexColor("#83CC98"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text('1', style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700
                        ),),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 190,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),),],)
                          ,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}