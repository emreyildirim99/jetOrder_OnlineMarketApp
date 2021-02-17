import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'RegisterPage.dart';
import 'package:emre_yildirim_jetorder/services/LoginService.dart';
import 'package:sweetalert/sweetalert.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  //Input Controllers
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  void openRegisterPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
  }

  //Login User
  Future<void> loginFunction () async {

    if(email.text == "" || pass.text == ""){

      SweetAlert.show(context,
          title: "Oopps!",
          subtitle: "Please fill all the areas.",
          style: SweetAlertStyle.error);

    }else{

      LoginService loginHelper = new LoginService(email:email.text,password:pass.text);

      var loginStatus = await loginHelper.loginUser();

      if(loginStatus['status'] == 'success'){

        Navigator.of(context).pushNamed("/HomePage");

      }else{

        SweetAlert.show(context,
            title: "Oopps!",
            subtitle: "Incorrect email or password. Try again!",
            style: SweetAlertStyle.error);

      }


    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Welcome to ", style: TextStyle(
                  color: HexColor("#83CC98"),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),),
                Icon(Icons.shopping_cart_rounded,color: Colors.blueAccent, size: 30,),
                Text(" jetOrder", style: TextStyle(
                  color: HexColor("#83CC98"),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 165,
              width: 165,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/banner.png')
                  )
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.mail, color: HexColor("#83CC98")),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        controller: pass,
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: Icon(Icons.vpn_key, color: HexColor("#83CC98"),),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: loginFunction,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              gradient: LinearGradient(
                                  colors: [HexColor("#92e3a9"), HexColor("#06D6A0")],
                                  stops: [0,1],
                                  begin: Alignment.topCenter
                              )
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: openRegisterPage,
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}