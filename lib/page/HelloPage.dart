import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HopePage.dart';
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
            ]
          )
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Image.asset('assets/images/light.png', width: 200,),
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade100)
                ),
                onPressed: () {
                  print("페이지를 이동합니다.");
                  Get.to(()=>SendHopePage());
                },
                child: Text("🙏 마음 전하러 가기 🙏")
            ),
            // Text("한줄 더 쓰기.", style: TextStyle(fontSize: 20, color: Colors.brown),),
            GestureDetector(
                    onTap: () {
            print("지나갑니다");

            Get.to(()=>HopePage());
            },
                child: Text("다음 페이지로 넘어가기", style: TextStyle(fontSize: 20, color: Colors.red),)),
          ],
        ),
      ),
    );
  }
}