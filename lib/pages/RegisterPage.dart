import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'LoginPage.dart';
import 'package:emre_yildirim_jetorder/services/RegisterService.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Selected Province & District Variable
  String selectedProvince;
  String selectedDistrict;

  RegisterService register = new RegisterService();

  //Redirect Login Page
  void openLoginPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text("Register ", style: TextStyle(
                              color: HexColor("#83CC98"),
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),),
                            Icon(Icons.shopping_cart_rounded,color: Colors.black, size: 30,),
                            Text(" jetOrder", style: TextStyle(
                              color: HexColor("#83CC98"),
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Name and Surname",
                          icon: Icon(Icons.account_box, color: Colors.blueAccent,),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Phone Number (e.g. 5xx xxx xx xx)",
                          icon: Icon(Icons.phone, color: Colors.blueAccent,),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.mail_outline, color: Colors.blueAccent,),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: Icon(Icons.vpn_key, color: Colors.blueAccent,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: EdgeInsets.only(left:16,right:16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                    colors: [Colors.blueAccent,Colors.blueAccent],
                                    stops: [0,1],
                                    begin: Alignment.topCenter
                                )
                            ),
                            child: DropdownButton(
                              hint: Center(
                                child: Text('Select Your Province',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              dropdownColor: Colors.blue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 35,
                              iconEnabledColor: Colors.white,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              value: selectedProvince,
                              onChanged: (newValue){
                                setState(() {
                                 selectedProvince = newValue;
                                });
                              },
                              items: register.getProvinces().map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Center(child: Text(valueItem, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: EdgeInsets.only(left:16,right:16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white ,width: 2),
                              borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                    colors: [Colors.blueAccent,Colors.blueAccent],
                                    stops: [0,1],
                                    begin: Alignment.topCenter
                                )
                            ),
                            child: DropdownButton(
                              hint: Center(
                                child: Text('Select Your District',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              dropdownColor: Colors.blue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 35,
                              iconEnabledColor: Colors.white,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              value: selectedDistrict,
                              onChanged: (newValue){
                                setState(() {
                                  selectedDistrict = newValue;
                                });
                              },
                              items: register.getDistricts().map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Center(child: Text(valueItem, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Home Address",
                          icon: Icon(Icons.home, color: Colors.blueAccent,),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(
                                colors: [HexColor("#CB356B"), HexColor("#EF476F")],
                                stops: [0,1],
                                begin: Alignment.topCenter
                            )
                        ),
                        child: Center(
                          child: Text("Register", style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: TextStyle(
                    fontSize: 16,
                ),),
                InkWell(
                  onTap: openLoginPage,
                  child: Text(" LOGIN!", style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),),
                )
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
