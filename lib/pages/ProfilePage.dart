import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:emre_yildirim_jetorder/services/ProfileService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //Selected Province & District Variable
  String selectedProvince;
  String selectedDistrict;

  ProfileService profile = new ProfileService();

  //Input Controllers
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();


  //Update User Profile
  Future<void> updateProfileFunction () async {

    ProfileService profileData = new ProfileService(userAddress: address.text,userDistrict: selectedDistrict,userPassword: pass.text,userProvince: selectedProvince);

    var registerStatus = await profileData.updateProfileData();

    if(registerStatus == 'success'){

      SweetAlert.show(context,
          title: "Successful!",
          subtitle: "Successfully updated.",
          style: SweetAlertStyle.success);

    }else{

      SweetAlert.show(context,
          title: "Oopps!",
          subtitle: "There is something wrong. Try again!",
          style: SweetAlertStyle.error);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Center(child: Text("jetOrder - Profile Update")),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      body: FutureBuilder(
        future: profile.getProfileData(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
              selectedDistrict = snapshot.data[0]['userDistrict'];
              selectedProvince = snapshot.data[0]['userProvince'];
              address.text = snapshot.data[0]['userAddress'];
              email.text = snapshot.data[0]['userEmail'];
              name.text = snapshot.data[0]['userName'];
              phone.text  = snapshot.data[0]['userPhone'];
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                              ),
                            ),
                            TextField(
                              controller: name,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "Name and Surname",
                                icon: Icon(Icons.account_box, color: Colors.blueAccent,),
                              ),
                            ),
                            TextField(
                              controller: phone,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                icon: Icon(Icons.phone, color: Colors.blueAccent,),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              controller: email,
                              enabled:false,
                              decoration: InputDecoration(
                                labelText: "Email",
                                icon: Icon(Icons.mail_outline, color: Colors.blueAccent,),
                              ),
                            ),
                            TextField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "******",
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
                                      print(newValue);
                                      setState(() {
                                        selectedProvince = newValue;
                                      });
                                    },
                                    items: profile.getProvinces().map((valueItem){
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
                                      print(newValue);
                                      setState(() {
                                        selectedDistrict = newValue;
                                      });
                                    },
                                    items: profile.getDistricts().map((valueItem){
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
                              controller: address,
                              decoration: InputDecoration(
                                labelText: snapshot.data[0]['userAddress'],
                                icon: Icon(Icons.home, color: Colors.blueAccent,),
                              ),
                            ),
                            SizedBox(height: 30,),
                            InkWell(
                              onTap: updateProfileFunction,
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
                                  child: Text("Save", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
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
}
