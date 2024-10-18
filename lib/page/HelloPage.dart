import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SendHopePage.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기를 가져오기 위한 MediaQuery
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
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.33, // 전체 화면의 30%만큼 여백
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Image.asset(
                'assets/images/lantern.png',
                width: screenWidth * 0.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.06), // 이미지와 버튼 사이 여백
            Container(
              height: screenHeight * 0.055,
              width: screenWidth * 0.6,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  print("페이지를 이동합니다.");
                  Get.to(() => SendHopePage());
                },
                child: Text(
                  "🙏 마음 전하러 가기 🙏",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.05, // 버튼 글자 크기를 화면 너비에 맞춤
                    fontWeight: FontWeight.bold,
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
