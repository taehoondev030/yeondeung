import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeondeung/page/HelloPage.dart';
import 'package:http/http.dart' as http;

import '../model/wish.dart';
import 'RisingHopePage.dart';

class SendHopePage extends StatefulWidget {
  const SendHopePage({Key? key}) : super(key: key);

  @override
  _SendHopePageState createState() => _SendHopePageState();
}

class _SendHopePageState extends State<SendHopePage> {
  bool sending = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> addHopeToServer(Hope hope) async{
    print("${hope.message}");

    // 토큰 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // 저장된 토큰 가져오기

    if (token == null) {
      print("No token found. Please log in again.");
      return;
    }

    final response = await http.post(
      Uri.http('10.0.2.2:8000','api/wish/wishes/'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(hope));
    print("response is = ${response.body}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 배경
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff07182C),
                Color(0xff110B69),
              ]
          ),
        ),
        width: double.infinity,
        height: double.infinity,

        // 노트 윗부분
        child: Column(
          children: [
            // 여백
            SizedBox(
              width: double.infinity,
              height: 170,
            ),
            // 뒤로가기 버튼
            AnimatedOpacity(
              opacity: sending ? 0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: IconButton(
                onPressed: () {
                  Get.to(() => HelloPage());
                },
                icon: const Icon(Icons.close),
                color: Colors.grey.shade300,
              ),
            ),

            // 노트 부분
            Container(
              margin: EdgeInsets.all(5),
              child: AnimatedSlide(
                offset: sending ? Offset(0, 2) : Offset(0, 0), // 컨테이너와 텍스트 필드를 함께 아래로 이동
                duration: Duration(milliseconds: 1800),
                curve: Curves.fastOutSlowIn,
                child: AnimatedContainer(
                  width: 300,
                  height: 400,
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.yellow.shade200,
                  ),
                  curve: Curves.fastOutSlowIn,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // 텍스트 필드에 여백 추가
                    child: TextField(
                      controller: _textController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: '내용을 입력하세요...',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // 노트 아랫부분
            SizedBox(height: 20), // 여백
            AnimatedOpacity(
              opacity: sending ? 0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    sending = true; // 컨테이너와 텍스트 필드를 함께 아래로 이동
                    var hope = Hope(
                      message: _textController.text,
                    );
                    addHopeToServer(hope);
                    _textController.clear();
                    },
                  );

                  // 애니메이션이 끝나면 페이지 이동
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Get.to(() => RisingHopePage());
                  });

                  //print(_textController.text); // 입력된 텍스트 출력
                },
                child: Text(
                  "🙏 등불 띄워 올려 보내기 🙏",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
