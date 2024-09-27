import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeondeung/page/HelloPage.dart';

class SendHopePage extends StatefulWidget {
  const SendHopePage({Key? key}) : super(key: key);

  @override
  _SendHopePageState createState() => _SendHopePageState();
}

class _SendHopePageState extends State<SendHopePage> {
  // TextEditingController로 입력된 텍스트 관리
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // 메모리 누수를 방지하기 위해 dispose에서 컨트롤러 해제
    _textController.dispose();
    super.dispose();
  }

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
              height: 170,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/letter.png',
                    width: 300,
                  ),
                  Positioned( // 이미지 내 텍스트 필드 위치 설정
                    top: 30,
                    left: 20,
                    right: 20,
                    child: TextField(
                      controller: _textController, // 컨트롤러 추가
                      maxLines: 8, // 여러 줄 입력 가능
                      decoration: InputDecoration(
                        hintText: '내용을 입력하세요...',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => HelloPage());
              },
              icon: const Icon(Icons.close),
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 20),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade100)),
                onPressed: () {
                  print("화면 이동");
                  print(_textController.text); // 입력된 텍스트 출력
                },
                child: Text("🙏 등불 띄워올려 보내기 🙏")),
          ],
        ),
      ),
    );
  }
}
