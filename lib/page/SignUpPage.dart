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

  Future<void> addUserToServer(User user) async{
    // 토큰 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // 저장된 토큰 가져오기

    if (token == null) {
      print("No token found. Please log in again.");
      return;
    }

    final response = await http.post(
        Uri.http('10.0.2.2:8000','api/user/create/'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(user));
    print("response is = ${response.body}");
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
                        print("회원가입 완료");
                        Get.to(() => LoginPage());
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