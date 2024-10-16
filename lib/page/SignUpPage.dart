import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '';

import '../model/user.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> addUserToServer(User user) async {
    // 토큰 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // 저장된 토큰 가져오기

    if (token == null) {
      print("No token found. Please log in again.");
      return;
    }

    final response = await http.post(
      Uri.http('10.0.2.2:8000', 'api/user/create/'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(user),
    );

    // 서버 응답 처리
    if (response.statusCode == 201) { // 성공적으로 회원가입 완료
      print("User created successfully: ${response.body}");
      Get.snackbar(
        '회원가입 성공',
        '입력하신 정보로 로그인 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      Get.to(() => LoginPage()); // 로그인 페이지로 이동
    } else if (response.statusCode == 400) { // 이메일 중복 오류 처리
      final errorResponse = jsonDecode(response.body);
      print(errorResponse);

      if (errorResponse['email'] != null &&
          errorResponse['email'][0] == "Enter a valid email address.") {
          Get.snackbar(
          '회원가입 실패',
          '유효하지 않은 이메일 형식입니다.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (errorResponse['email'] != null &&
          errorResponse['email'][0] == "user with this email already exists.") {
        Get.snackbar(
          '회원가입 실패',
          '이미 존재하는 이메일입니다. 다른 이메일을 사용해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (errorResponse['password'] != null &&
          errorResponse['password'][0] == "Ensure this field has at least 5 characters."){
        Get.snackbar(
          '회원가입 실패',
          '비밀번호가 너무 짧습니다. 5글자 이상의 비밀번호를 설정해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty) {
        Get.snackbar(
          '회원가입 실패',
          '공백인 필드가 있습니다. 모든 필드를 채워주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          '회원가입 실패',
          '입력한 정보에 오류가 있습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {  // 기타 오류 처리
      print("Error: ${response.statusCode}");
      Get.snackbar(
        '회원가입 실패',
        '회원가입에 실패했습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
                Text(
                  "연등",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 80,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
                Padding(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '이름',
                      hintText: '이름을 입력하세요.',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                ),
                Padding(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: '이메일',
                      hintText: '이메일을 입력하세요.',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                ),
                Padding(
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintText: '비밀번호를 입력하세요.',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Text("로그인",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          var user = User(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                          );
                          addUserToServer(user);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Text("회원가입",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}