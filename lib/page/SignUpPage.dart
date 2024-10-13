import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginPage.dart';
import 'SendHopePage.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
                Padding(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                ),
                Padding(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                ),

                Row(
                  children: [
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
                        print("회원가입 완료");
                        Get.to(() => LoginPage());
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