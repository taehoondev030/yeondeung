import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SendHopePage.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.33,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: FutureBuilder(
                future: precacheImage(AssetImage('assets/images/lantern.png'), context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image.asset(
                      'assets/images/lantern.png',
                      width: screenWidth * 0.5,
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error, color: Colors.red, size: screenWidth * 0.5);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Container(
              height: screenHeight * 0.06,
              width: screenWidth * 0.6,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  try {
                    Get.to(() => SendHopePage());
                  } catch (e) {
                    Get.snackbar(
                      '페이지 이동 실패',
                      '페이지 이동 중 문제가 발생했습니다.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(
                  "마음을 전해보세요 🙏",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.055,
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
