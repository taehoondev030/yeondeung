import 'dart:convert';
import 'dart:io'; // 추가: 네트워크 오류 처리를 위해

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/wish.dart';
import 'HelloPage.dart';
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

  Future<void> addHopeToServer(Hope hope) async {
    print("${hope.message}");

    try {
      // 토큰 불러오기
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token'); // 저장된 토큰 가져오기

      if (token == null) {
        Get.snackbar(
          '에러',
          '토큰이 없습니다. 다시 로그인 해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final response = await http.post(
        Uri.http('10.0.2.2:8000', 'api/wish/wishes/'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(hope),
      );

      if (response.statusCode == 201) {
        print("Wish added successfully: ${response.body}");
      } else if (response.statusCode == 400) {
        // 400번대 클라이언트 오류
        Get.snackbar(
          '에러',
          '잘못된 요청입니다. 입력을 다시 확인해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Client error: ${response.body}');
      } else if (response.statusCode == 401) {
        // 인증 오류
        Get.snackbar(
          '에러',
          '인증에 실패했습니다. 다시 로그인 해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Unauthorized error: ${response.body}');
      } else {
        // 그 외 상태 코드 처리
        Get.snackbar(
          '에러',
          '서버 오류가 발생했습니다. 나중에 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Server error: ${response.body}');
      }
    } on SocketException {
      // 네트워크 오류 처리
      Get.snackbar(
        '네트워크 오류',
        '인터넷 연결을 확인해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Network error');
    } catch (e) {
      // 기타 예외 처리
      Get.snackbar(
        '에러',
        '예기치 못한 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

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
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,

        // 노트 윗부분
        child: Column(
          children: [
            // 여백 (화면 높이에 맞게 조정)
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.17,
            ),

            // 뒤로가기 버튼
            AnimatedOpacity(
              opacity: sending ? 0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: IconButton(
                onPressed: () {
                  Get.offAll(HelloPage());
                },
                icon: const Icon(Icons.close),
                color: Colors.grey.shade300,
              ),
            ),

            // 노트 부분
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              child: AnimatedSlide(
                offset: sending ? Offset(0, 2) : Offset(0, 0), // 컨테이너와 텍스트 필드를 함께 아래로 이동
                duration: Duration(milliseconds: 1800),
                curve: Curves.fastOutSlowIn,
                child: AnimatedContainer(
                  width: screenWidth * 0.77,
                  height: screenHeight * 0.45,
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.yellow.shade200,
                  ),
                  curve: Curves.fastOutSlowIn,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: TextField(
                      controller: _textController,
                      maxLines: 12,
                      decoration: InputDecoration(
                        hintText: '내용을 입력하세요.',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: screenWidth * 0.045, // 글자 크기를 화면 너비에 맞춤
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // 노트 아랫부분
            SizedBox(height: screenHeight * 0.02), // 여백 (화면 높이에 비례)
            AnimatedOpacity(
              opacity: sending ? 0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenWidth * 0.025, screenWidth * 0.025, screenWidth * 0.03),
                  backgroundColor: Colors.yellow.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  if (_textController.text.isEmpty) {
                    Get.snackbar(
                      '경고',
                      '내용을 입력해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  setState(() {
                    sending = true; // 컨테이너와 텍스트 필드를 함께 아래로 이동
                    var hope = Hope(
                      message: _textController.text,
                    );
                    addHopeToServer(hope);
                    _textController.clear();
                  });

                  // 애니메이션이 끝나면 페이지 이동
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Get.to(() => RisingHopePage());
                  });
                },
                child: Text(
                  "✨ 하늘로 날려 띄워 보내기 ✨",
                  style: TextStyle(
                    fontSize: screenWidth * 0.047, // 텍스트 크기를 화면 너비에 맞춤
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
