import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/EndPage.dart';

class RisingHopePage extends StatefulWidget {
  const RisingHopePage({Key? key}) : super(key: key);

  @override
  State<RisingHopePage> createState() => _RisingHopePageState();
}

class _RisingHopePageState extends State<RisingHopePage> {
  bool _rise = false;
  bool _imageLoaded = true; // 이미지 로딩 성공 여부

  @override
  void initState() {
    super.initState();
    try {
      // 0.2초 후 애니메이션 시작
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _rise = true;
        });
      });

      // 6초 후 EndPage로 이동
      Future.delayed(Duration(milliseconds: 6000), () {
        Get.to(() => EndPage());
      });
    } catch (e) {
      // 예외 처리: 화면 전환 중 문제가 발생했을 때
      Get.snackbar(
        '에러',
        '애니메이션 또는 화면 전환 중 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error during animation or navigation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        children: [
          // 배경 그라데이션
          Container(
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
          ),

          // 등불 이미지 애니메이션
          _imageLoaded
              ? AnimatedPositioned(
            duration: Duration(seconds: 5),
            curve: Curves.easeInOut,
            bottom: _rise ? screenHeight : -screenHeight * 0.3,  // 등불이 올라갈 위치
            left: screenWidth * 0.25,  // 화면의 25%에 맞추어 중앙에 배치
            right: screenWidth * 0.25,
            child: Image.asset(
              "assets/images/lantern.png",
              width: screenWidth * 0.5,  // 화면 너비의 50%에 맞추어 크기 조정
              height: screenHeight * 0.3,  // 화면 높이의 30%에 맞추어 크기 조정
              errorBuilder: (context, error, stackTrace) {
                // 이미지 로딩 실패 시 예외 처리
                _imageLoaded = false;
                return Center(
                  child: Text(
                    '이미지를 불러오지 못했습니다.',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              },
            ),
          )
              : Center(
            child: Text(
              '이미지를 불러오지 못했습니다.',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
