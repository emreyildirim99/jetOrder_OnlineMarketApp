import 'package:emre_yildirim_jetorder/services/OrderDetailsService.dart';
import 'package:flutter/material.dart';
import 'package:emre_yildirim_jetorder/helpers/Style.dart';


class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  List orderData = [];

  @override
  Widget build(BuildContext context) {

    Map<String, Object> orderCodeData = ModalRoute.of(context).settings.arguments;

    var orderCode = orderCodeData['orderCode'];

    OrderDetailsService orderDetail = new OrderDetailsService(orderCode: orderCode);


    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Center(child: Text("jetOrder - Order Details")),
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
      body: Container(
        height: MediaQuery.of(context).size.height*0.87,
        child: FutureBuilder(
          future: orderDetail.getOrderDetails(),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);
            if(snapshot.hasData){
              orderData = snapshot.data;
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(snapshot.data.length, listOrderData)
                        ),
                      ),
                    ),
                    SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Paid Price:", style: headingStyle,),
                          ],
                        ),
                        Text("${orderData[0]['orderTotalPrice'] == null ? 0 : orderData[0]['orderTotalPrice'] }₺", style: headingStyle,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Order Code:", style: headingStyle,),
                          ],
                        ),
                        Text("${orderData[0]['orderCode'] }", style: headingStyle,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Order Date:", style: headingStyle,),
                          ],
                        ),
                        Text("${orderData[0]['orderDate'] }", style: headingStyle,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Delivery Address:", style: headingStyle,),
                          ],
                        ),
                        Text("${orderData[0]['userAddress']} \n ${orderData[0]['userProvince'] }/${orderData[0]['userDistrict'] }", style: headingStyle,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ Icon(orderData[0]['orderStatus'] == "0" ? Icons.delivery_dining : Icons.check_box,size: 100,
                      color: orderData[0]['orderStatus'] == "0" ? Colors.orange : Colors.green
                      ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ Text(orderData[0]['orderStatus'] == "0" ? "On the way" : "Delivered",style: TextStyle(color:orderData[0]['orderStatus'] == "0" ? Colors.orange : Colors.green,fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
  Container listOrderData(int id)
  {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${orderData[id]["productPhoto"]}"),
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${orderData[id]["productName"]}", style: headingStyle,),
                      Text("${orderData[id]["productPrice"]}₺\n/${orderData[id]["productQuantity"]}", style: headingStyle.copyWith(color: Colors.grey),),

                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(23),
                    child: Text("${orderData[id]["orderQuantity"]} ${orderData[id]["productQuantity"]}", style: headingStyle,)
                ),
                Padding(
                    padding: const EdgeInsets.all(23),
                    child: Text("${int.parse(orderData[id]["orderQuantity"]) * double.parse(orderData[id]["productPrice"])}₺", style: headingStyle,)
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
