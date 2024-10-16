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

  // 이메일 형식 확인을 위한 정규식
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> loginUser() async {
    String email = controller.text.trim();
    String password = controller2.text.trim();

    // 1. 사용자 입력 오류 처리
    // 이메일 형식 오류 확인
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
        '로그인 실패',
        '올바른 이메일 형식을 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // 잘못된 이메일 형식일 경우 로그인 시도 중단
    }

    // 비밀번호 누락 확인
    if (password.isEmpty) {
      Get.snackbar(
        '로그인 실패',
        '비밀번호를 입력하세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // 비밀번호가 없을 경우 로그인 시도 중단
    }

    String url = 'http://10.0.2.2:8000/api/user/token/';

    // 사용자 정보
    var userInfo = {
      "email": email,
      "password": password,
    };

    // POST 요청 보내기
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userInfo),
    );

    // 2. 서버 측 응답 처리
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];

      // 토큰을 SharedPreferences에 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      print('User token: $token');
      Get.to(() => HelloPage());  // 로그인 성공 시 HelloPage로 이동
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      // 잘못된 이메일 또는 비밀번호인 경우
      Get.snackbar(
        '로그인 실패',
        '이메일 또는 비밀번호가 잘못되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // 기타 서버 오류
      Get.snackbar(
        '로그인 실패',
        '서버에 문제가 발생했습니다. 나중에 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
                              fontSize: 15.0,
                            ),
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
                            Row(
                              children: [
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
                                SizedBox(width: 50,),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(()=> SignUpPage());
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade100),
                                  ),
                                  child: Text("회원가입", style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black
                                  ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
