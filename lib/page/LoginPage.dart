import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeondeung/page/HelloPage.dart';
import 'package:http/http.dart' as http;
import 'SignUpPage.dart';

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
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
        '로그인 실패',
        '올바른 이메일 형식을 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.isEmpty) {
      Get.snackbar(
        '로그인 실패',
        '비밀번호를 입력하세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];

      // 토큰을 SharedPreferences에 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      print('User token: $token');
      Get.to(() => HelloPage());
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      Get.snackbar(
        '로그인 실패',
        '이메일 또는 비밀번호가 잘못되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
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
    // 화면 크기 가져오기
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.2), // 화면 높이에 비례한 여백
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.webp'),
                  width: screenWidth * 0.6, // 화면 너비의 60%로 로고 크기 설정
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // 로고와 입력 필드 사이에 여백
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.yellow.shade200,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.yellow.shade200,
                        fontSize: screenWidth * 0.04, // 글자 크기를 화면 너비에 맞춤
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, // 좌우 패딩을 화면 너비의 10%로 설정
                      vertical: screenHeight * 0.02, // 위아래 패딩 설정
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045, // 글자 크기 조정
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // 입력 필드 사이 여백
                        TextField(
                          controller: controller2,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045, // 글자 크기 조정
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05), // 버튼과 입력 필드 사이에 여백
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow.shade100,
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.07, // 버튼 가로 크기
                                    vertical: screenHeight * 0.015, // 버튼 세로 크기
                                  ),
                                ),
                              ),
                              onPressed: () {
                                loginUser();
                              },
                              child: Text(
                                "로그인",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05, // 버튼 글자 크기
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.1), // 버튼 사이 여백
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => SignUpPage());
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow.shade100,
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.015,
                                  ),
                                ),
                              ),
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05, // 버튼 글자 크기
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
