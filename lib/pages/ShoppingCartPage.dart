import 'package:flutter/material.dart';
import 'package:emre_yildirim_jetorder/helpers/Style.dart';
import 'package:emre_yildirim_jetorder/services/ShoppingCartService.dart';
import 'package:sweetalert/sweetalert.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  ShoppingCartService cart = new ShoppingCartService();
  List products;
  List totalPrice;


  void emptyCart() async{

      var status = await cart.emptyShoppingCart();

      SweetAlert.show(context,subtitle: "Deleting...", style: SweetAlertStyle.loading);

      if(status == 'success'){

         Navigator.pop(context);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));

      }


  }

  void deleteProduct(int productID) async{

    ShoppingCartService deleteProduct = new ShoppingCartService(productID: productID);

    var status = await deleteProduct.deleteProduct();

    SweetAlert.show(context,subtitle: "Deleting...", style: SweetAlertStyle.loading);

    if(status == 'success'){

      Navigator.pop(context);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget));

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("jetOrder - Shopping Cart")),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {

              SweetAlert.show(context,
                  subtitle: "Do you want to empty your Shopping Cart?",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: true,
                  onPress: (bool isConfirm) {

                    if(isConfirm) {

                      emptyCart();

                    }else{
                      SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
                    }
                    // return false to keep dialog
                    return false;
                  });


            },
          )
        ],
      ),
      body: FutureBuilder(
      future: Future.wait([cart.getShoppingCart(), cart.getTotalPrice()]),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            products = snapshot.data[0];
            totalPrice = snapshot.data[1];
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(snapshot.data[0].length, listProducts)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Total Price:", style: headingStyle,),
                        ],
                      ),
                      Text("${totalPrice[0]['cartPrice'] == null ? 0 : totalPrice[0]['cartPrice'] }₺", style: headingStyle,)
                    ],
                  ),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      totalPrice[0]['cartPrice'] != null ? Navigator.pushNamed(context, '/PaymentPage') : null;
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: gradientStyle,
                        ),
                        child: Center(
                          child: Text("Order Now!", style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700
                          ),),
                        )
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
  Container listProducts(int id)
  {
    ShoppingCartService cartHelper = new ShoppingCartService(productID: int.parse(products[id]["productID"]));

    var quantity = int.parse(products[id]["cartQuantity"]);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    child: Icon(Icons.clear, color: Colors.red, size: 22,),
                    onTap: (){

                      SweetAlert.show(context,
                          subtitle: "Do you want to delete?",
                          style: SweetAlertStyle.confirm,
                          showCancelButton: true,
                          onPress: (bool isConfirm) {

                            if(isConfirm) {

                              deleteProduct(int.parse(products[id]["productID"]));

                            }else{
                              SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
                            }
                            // return false to keep dialog
                            return false;
                          });

                    },

                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${products[id]["productPhoto"]}"),
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${products[id]["productName"]}", style: headingStyle,),
                      Text("${products[id]["productPrice"]}₺\n/${products[id]["productQuantity"]}", style: headingStyle.copyWith(color: Colors.grey),),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(23),
                  child: Text("${products[id]["totalPrice"]}₺", style: headingStyle,)
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          gradient: gradientStyle,
                          shape: BoxShape.circle
                      ),
                      child: InkWell(
                        onTap: () async{
                         if(quantity > 1){
                           var status = await cartHelper.updateShoppingCart("remove");

                           if(status == 'success'){

                             setState(() {
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (BuildContext context) => super.widget));
                             });
                           }
                         }
                        },
                        child: Center(
                          child: Text("-", style: headingStyle.copyWith(
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: Center(
                        child: Text("$quantity", style: headingStyle.copyWith(
                            fontSize: 20
                        )),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          gradient: gradientStyle,
                          shape: BoxShape.circle
                      ),
                      child: InkWell(
                        onTap: () async{

                          var status = await cartHelper.updateShoppingCart("add");

                          if(status == 'success'){

                            setState(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => super.widget));
                            });
                          }

                        },
                        child: Center(
                          child: Text("+", style: headingStyle.copyWith(
                              color: Colors.white
                          ),),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width*0.75,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
