import 'dart:convert';
import 'package:emre_yildirim_jetorder/services/MyOrdersService.dart';
import 'package:flutter/material.dart';
import 'package:emre_yildirim_jetorder/helpers/Style.dart';
import 'package:emre_yildirim_jetorder/services/ShoppingCartService.dart';
import 'package:decimal/decimal.dart';
import 'package:sweetalert/sweetalert.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {

  MyOrdersService myOrders = new MyOrdersService();
  List orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Center(child: Text("jetOrder - My Orders")),
        ),
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
      ),
      body: FutureBuilder(
        future: myOrders.getOrders(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            orders = snapshot.data;
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(snapshot.data.length, listOrders)
                      ),
                    ),
                  ),
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
  Container listOrders(int id)
  {




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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    child: Icon(Icons.delivery_dining,size: 50, color: Colors.green,),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${orders[id]["orderCode"]}", style: headingStyle,),
                      Text("${orders[id]["orderDate"]}", style: TextStyle(color: Colors.grey,fontSize: 15),),

                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(23),
                    child: Text("${orders[id]["orderTotalPrice"]}₺", style: headingStyle,)
                ),
                Row(
                    children: [
                      Container(

                        child: Center(
                          child: Text("${orders[id]["orderStatus"] == "0" ? "On the way" : "Delivered"}", style: headingStyle.copyWith(
                              fontSize: 20
                          )),
                        ),
                      )
                    ],
                  ),
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
