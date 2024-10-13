import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/HelloPage.dart';

import 'MyHopePage.dart';

class EndPage extends StatelessWidget {
  const EndPage({Key? key}) : super(key: key);

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
              height: 300,
            ),
            Text(
                "당신의 마음이\n잘 전해졌습니다.",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  ),
                textAlign: TextAlign.center,
                ),
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => HelloPage());
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/home.png",
                            width: 30,
                          ),
                          Text(
                            "처음 화면으로\n돌아가기",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        padding: EdgeInsets.all(15.0),
                        backgroundColor: Colors.yellow.shade100
                      ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(

                    onPressed: () {
                      Get.to(() => MyHopePage());
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/lanternicon.png",
                        width: 30,
                        ),
                        Text(
                          "내가 띄운 등불\n보러가기",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(15.0),
                        backgroundColor: Colors.yellow.shade100,
                    )
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
