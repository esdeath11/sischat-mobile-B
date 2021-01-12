import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sischat_mobile/View/homePage.dart';
import 'package:sischat_mobile/View/register.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isloading = false;

  signIn(String username, String password) async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Map body = {
        "username" : username,
        "password" : password,
      };
      String url = "https://api-sischat.reach.my.id/auth/login";
      var jsonResponse;
      var res = await http.post(url, body: body);
      // check status
      if(res.statusCode == 200){
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
                    'login',
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
                        height: 200,
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
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(hintText: 'Password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      onPressed: _usernameController.text == ""|| _passwordController.text == "" ? null: (){
                        setState(() {
                          _isloading = true;
                        });

                        signIn(_usernameController.text, _passwordController.text);

                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text(
                      'Forgot Password'
                    ),
                    onPressed: (){},
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: Text('or'),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => RegisterPage()), (Route<dynamic>route) => false);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
