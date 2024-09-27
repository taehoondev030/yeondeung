import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/HopeDetailPage.dart';

class HopePage extends StatelessWidget {
  const HopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("나의 소망 페이지"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () {
                Get.to(()=>HopeDetailPage(
                    hopeTitle: "건강",
                    hopeImagePath: "assets/images/healthy.jpg")
                );
              },
              child: Text("건강")),
          Image.asset('assets/images/healthy.jpg', width: 200,),

          GestureDetector(
              onTap: () {
                Get.to(()=>HopeDetailPage(
                    hopeTitle: "재물",
                    hopeImagePath: 'assets/images/money.png',
                    detail: "돈이 많이 들어왔으면",
                ));
              },
              child: Text("재물")),
          Image.asset('assets/images/money.png', width: 200),
          Row(
            children: [
              Expanded(flex: 1, child: Image.asset('assets/images/luck.jpg', width: 100,)),
              SizedBox(width: 30,),
              Expanded(flex: 2, child: Image.asset('assets/images/cheerup.jpg', width: 100,)),
            ],
          )
        ],
      ),
    );
  }
}
