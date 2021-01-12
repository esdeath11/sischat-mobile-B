import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sischat_mobile/View/homePage.dart';
import 'package:sischat_mobile/component/alert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _jenisKelaminController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  bool _isloading;

  String genderChoice;
  List gender = [
    'L', 'P'
  ];


  register(String username, String email, String password, String jenis_kelamin, String alamat) async{
    print('register berhasil');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "username" : username,
      "email" : email,
      "password" : password,
      "jenis_kelamin" : jenis_kelamin,
      "alamat" : alamat,
    };

    String url = "https://api-sischat.reach.my.id/auth/register";
    var jsonResponse;
    var res = await http.post(url, body: body);
    if(res.statusCode == 201){ //created
      showAlertDialogAccess(context);
      jsonResponse = json.decode(res.body);
      print("response status : ${res.statusCode}");
      print("response status : ${res.body}");
      if(jsonResponse != null){
        setState(() {
          _isloading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic>route) => false);


      } else{
        setState(() {
          _isloading = false;
        });
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    'Register',
                    style: TextStyle(fontSize: 32),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(

                              controller: _usernameController,
                              decoration: InputDecoration(hintText: 'Username'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(hintText: 'Email'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(hintText: 'Password'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownButton(
                              hint: Text('Select your Gender'),
                              value: genderChoice,
                              onChanged: (newValue){
                                setState(() {
                                  genderChoice = newValue;
                                  print(genderChoice);
                                });
                              },
                              items: gender.map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              },
                            ).toList(),
                          ),

                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(

                              controller: _alamatController,
                              decoration: InputDecoration(hintText: 'Alamat'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),



                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),

                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(

                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      onPressed: (){
                        if(_usernameController.text != "" &&_emailController.text != "" && _passwordController.text != "" && genderChoice != "" && _alamatController.text != ""){
                          print("terdaftar" + _usernameController.text);
                          print(_jenisKelaminController);
                          register(_usernameController.text, _emailController.text, _passwordController.text, genderChoice, _alamatController.text);
                        }
                        else{
                          showAlertDialog(context);
                          print("tidak lengkap");
                        }





                      }


                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
