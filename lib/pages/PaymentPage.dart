import 'package:flutter/material.dart';
import 'package:emre_yildirim_jetorder/helpers/Style.dart';
import 'package:emre_yildirim_jetorder/services/PaymentService.dart';
import 'package:sweetalert/sweetalert.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  PaymentService payment = new PaymentService();
  List orderData = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("jetOrder - Payment")),
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
              Icons.home,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: payment.getOrderData(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            orderData = snapshot.data;
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Icon(Icons.credit_card,size: 60,)),
                  Center(
                    child: Container(
                      child: Column(children: [
                        Text("Total Price: ${orderData[0]["cartPrice"]}₺", style: headingStyle.copyWith(
                            fontSize: 20
                        )),
                        SizedBox(height: 20,),
                        Text("${orderData[0]["userAddress"]} ${orderData[0]["userProvince"]} / ${orderData[0]["userDistrict"]}", style: headingStyle.copyWith(
                            fontSize: 17
                        )),
                      ],),
                    ),
                  ),
                  divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Card Number",
                              icon: Icon(Icons.credit_card, color: Colors.blueAccent,),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Name on Card",
                              icon: Icon(Icons.person, color: Colors.blueAccent,),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Expiry Date (e.g. 06/2024)",
                              icon: Icon(Icons.date_range, color: Colors.blueAccent,),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Security Code (CVC)",
                              icon: Icon(Icons.security, color: Colors.blueAccent,),
                            ),
                          ),
                          SizedBox(height: 25,),
                          InkWell(
                            onTap: () async{
                              var result = await payment.placeOrder(orderData[0]["cartPrice"]);
                              if(result=='success'){

                                Navigator.pushNamed(context, '/HomePage');

                                SweetAlert.show(context,
                                    title: "Successful!",
                                    subtitle: "Successfully ordered",
                                    style: SweetAlertStyle.success);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  gradient: gradientStyle
                              ),
                              child: Center(
                                child: Text("Pay Now!", style: contentStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 22
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),
                    ),
                  ),
                Container(child: Image.network("https://storage.j0.hn/credit-card-logos.png",),width: 200,),
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
  Container divider()
  {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 1,
      color: Colors.grey,
    );
  }

}
