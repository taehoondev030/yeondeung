import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'EndPage.dart';
import 'SendHopePage.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: Image.asset('assets/images/lantern.png', width: 180,),
            ),
            TextButton(
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
              child: Text("🙏 마음 전하러 가기 🙏",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                print("페이지를 이동합니다.");
                Get.to(() => EndPage());
              },
              child: Text("🙏 마지막 페이지로 🙏",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
