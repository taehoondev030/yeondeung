import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';
import '../model/user.dart';

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
    } else {
      handleErrorResponse(response);
    }
  }

  void handleErrorResponse(http.Response response) {
    final errorResponse = jsonDecode(response.body);
    if (response.statusCode == 400) {
      if (errorResponse['email'] != null && errorResponse['email'][0] == "Enter a valid email address.") {
        showErrorSnackBar('유효하지 않은 이메일 형식입니다.');
      } else if (errorResponse['email'] != null && errorResponse['email'][0] == "user with this email already exists.") {
        showErrorSnackBar('이미 존재하는 이메일입니다.');
      } else if (errorResponse['password'] != null && errorResponse['password'][0] == "Ensure this field has at least 5 characters.") {
        showErrorSnackBar('비밀번호가 너무 짧습니다.');
      } else if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty) {
        showErrorSnackBar('공백인 필드가 있습니다.');
      } else {
        showErrorSnackBar('입력한 정보에 오류가 있습니다.');
      }
    } else {
      showErrorSnackBar('회원가입에 실패했습니다.');
    }
  }

  void showErrorSnackBar(String message) {
    Get.snackbar(
      '회원가입 실패',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1), // 상단 여백
                Text(
                  "연 등",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: screenWidth * 0.15, // 텍스트 크기를 화면 너비에 맞춤
                  ),
                ),
                SizedBox(height: screenHeight * 0.1), // 텍스트 아래 여백
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '이름',
                      hintText: '이름을 입력하세요.',
                      labelStyle: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 필드 간 여백
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: '이메일',
                      hintText: '이메일을 입력하세요.',
                      labelStyle: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      hintText: '비밀번호를 입력하세요.',
                      labelStyle: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.yellow),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // 입력 필드와 버튼 사이 여백
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.07,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.1), // 버튼 간 여백
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.015,
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
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
