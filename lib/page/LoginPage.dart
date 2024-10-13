import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:yeondeung/page/SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'HelloPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Future<void> loginUser() async {
    String url = 'http://10.0.2.2:8000/api/user/token/';

    // 사용자 정보
    var userInfo = {
      "email": controller.text,
      "password": controller2.text
    };

    // POST 요청 보내기
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userInfo),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];

      // 토큰을 SharedPreferences에 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      print('User token: $token');
      Get.to(() => HelloPage());  // 로그인 성공 시 HelloPage로 이동
    } else {
      print('Failed to login: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff07182C),
              Color(0xff110B69),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Builder(
          builder:(context) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget> [
                  Padding(padding: EdgeInsets.only(top: 150)),
                  Center(
                    child: Image(image: AssetImage('assets/images/logo.webp'),
                      width: 300.0,
                    ),
                  ),
                  Form(
                      child: Theme(
                          data: ThemeData(
                              primaryColor: Colors.yellow.shade200,
                              inputDecorationTheme: InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      color: Colors.yellow.shade200,
                                      fontSize: 15.0
                                  )
                              )
                          ),
                          child: Container(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      labelText: 'Email'
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                TextField(
                                  controller: controller2,
                                  decoration: InputDecoration(
                                      labelText: 'PassWord'
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  obscureText: true,
                                ),
                                SizedBox(height: 40.0,),
                                ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade100),
                                      ),
                                      child: Text(
                                          "로그인",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black
                                        ),
                                      ),
                                      onPressed: () {
                                        loginUser();
                                      }
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.to(()=> SignUpPage());
                                    },
                                    child: Text("회원가입",
                                    )
                                )
                              ],
                            ),

                          ))
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void sendAuthenticatedRequest(String token) async {
  String url = 'http://10.0.2.2:8000/api/protected-endpoint/';

  // 토큰을 Authorization 헤더에 포함시켜 요청 보내기
  var response = await http.get(
    Uri.parse(url),
    headers: {
      "Authorization": "Token $token",
      "Content-Type": "application/json"
    },
  );

  // 응답 처리
  if (response.statusCode == 200) {
    print('Success: ${response.body}');
  } else {
    print('Failed: ${response.statusCode}');
  }
}