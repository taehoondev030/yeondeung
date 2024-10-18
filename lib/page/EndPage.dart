import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/HelloPage.dart';

import 'MyHopePage.dart';

class EndPage extends StatelessWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return WillPopScope( // PopScope 대신 WillPopScope 사용
      onWillPop: () async => false, // 뒤로가기 방지
      child: Scaffold(
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
              // 상단 여백
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.35, // 화면 높이의 35%만큼 여백
              ),
              // 텍스트
              Text(
                "여기에 무슨 글을 넣어야하나.",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08, // 화면 너비의 8%로 폰트 크기 설정
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenHeight * 0.05, // 화면 높이의 5%만큼 여백
              ),
              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(HelloPage());
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/home.png",
                          width: screenWidth * 0.08, // 화면 너비의 8%로 이미지 크기 설정
                        ),
                        SizedBox(height: screenHeight * 0.01), // 이미지와 텍스트 사이 여백
                        Text(
                          "처음 화면으로\n돌아가기",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045, // 화면 너비의 4.5%로 폰트 크기 설정
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05), // 화면 너비에 비례한 패딩 설정
                      backgroundColor: Colors.yellow.shade100,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1), // 버튼 사이에 여백
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => MyHopePage());
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/menu.png",
                          width: screenWidth * 0.08, // 화면 너비의 8%로 이미지 크기 설정
                        ),
                        SizedBox(height: screenHeight * 0.01), // 이미지와 텍스트 사이 여백
                        Text(
                          "내가 띄운 등불\n보러가기",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045, // 화면 너비의 4.5%로 폰트 크기 설정
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05), // 화면 너비에 비례한 패딩 설정
                      backgroundColor: Colors.yellow.shade100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
