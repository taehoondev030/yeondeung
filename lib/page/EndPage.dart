import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return WillPopScope(
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
                height: screenHeight * 0.2,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.01, screenWidth * 0.05, screenHeight * 0.04),
                child: Center(
                  child: Text(
                    "YEON\nDEUNG",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.15,
                      height: screenHeight * 0.0012,
                    ),
                  ),
                ),
              ),
              Text(
                "당신의 마음이 잘 전해졌습니다.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      try {
                        Get.offAll(HelloPage());
                      } catch (e) {
                        Get.snackbar(
                          '오류 발생',
                          '처음 화면으로 이동 중 오류가 발생했습니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/home.png",
                          width: screenWidth * 0.08,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "처음 화면으로",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      backgroundColor: Colors.yellow.shade100,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        Get.to(() => MyHopePage());
                      } catch (e) {
                        Get.snackbar(
                          '오류 발생',
                          '내가 띄운 등불 페이지로 이동 중 오류가 발생했습니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/menu.png",
                          width: screenWidth * 0.08,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "내가 띄운 등불",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05),
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
