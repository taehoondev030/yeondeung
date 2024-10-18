import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/EndPage.dart';

class RisingHopePage extends StatefulWidget {
  const RisingHopePage({Key? key}) : super(key: key);

  @override
  State<RisingHopePage> createState() => _RisingHopePageState();
}

class _RisingHopePageState extends State<RisingHopePage> {
  bool  _rise = false;

  @override
  void initState() {
    super.initState();
    // 0.5초 후 애니메이션 시작
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _rise = true;
      });
    });

    // 애니메이션 실행 후 화면 전환
    Future.delayed(Duration(milliseconds: 6000), () {
      Get.to(()=> EndPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          AnimatedPositioned(
            duration: Duration(seconds: 5),
            curve: Curves.easeInOut,
            bottom: _rise ? MediaQuery.of(context).size.height : -200, // 화면 위로 이동
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/lantern.png",
              width: 200,
              height: 200,
          ),
        ),
      ],
    ),
    );
  }
}
