import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/wish.dart';

class MyHopePage extends StatefulWidget {
  const MyHopePage({Key? key}) : super(key: key);

  @override
  State<MyHopePage> createState() => _MyHopePageState();
}

class _MyHopePageState extends State<MyHopePage> {
  late Future<List<Hope>> futureWishes;

  @override
  void initState() {
    super.initState();
    futureWishes = fetchWishes(); // 데이터 가져오기
  }

  String formatDateTime(DateTime? datetime) {
    if (datetime == null) {
      return "Unknown date";
    }
    return DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(datetime);
  }

  Future<List<Hope>> fetchWishes() async {
    try {
      // SharedPreferences에서 저장된 토큰을 불러옴
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');  // 저장된 토큰 가져오기

      if (token == null) {
        throw Exception("No token found. Please login.");
      }

      // GET 요청에 토큰을 Authorization 헤더에 추가
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/wish/wishes/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',  // 토큰을 Authorization 헤더에 추가
        },
      );

      if (response.statusCode == 200) {
        // 서버로부터 받은 JSON 데이터를 리스트로 디코딩
        List<dynamic> body = jsonDecode(response.body);

        // JSON 리스트를 Hope 객체 리스트로 변환
        List<Hope> wishes = body.map((dynamic item) => Hope.fromJson(item)).toList();
        return wishes;
      } else {
        throw Exception('Failed to load wishes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // 예외가 발생하면 오류를 출력하고 다시 던짐
      print('Error fetching wishes: $e');
      throw Exception('Error fetching wishes. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      // AppBar 추가
      appBar: AppBar(
        title: Text(
          "내가 띄운 등불",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05, // 반응형 텍스트 크기
          ),
        ),
        backgroundColor: Color(0xff07182C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();  // 뒤로가기 기능
          },
        ),
      ),
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
        child: Center(
          child: FutureBuilder<List<Hope>>(
            future: futureWishes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(color: Colors.yellow);  // 데이터 로딩 중일 때 로딩 표시
              } else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: screenWidth * 0.2),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );  // 에러 발생 시 사용자 친화적인 메시지
              } else if (snapshot.hasData) {
                // 데이터가 있을 때 리스트로 표시
                List<Hope> wishes = snapshot.data!;
                return ListView.builder(
                  itemCount: wishes.length,
                  itemBuilder: (context, index) {
                    Hope wish = wishes[index];

                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,  // 반응형 세로 간격
                        horizontal: screenWidth * 0.05,  // 반응형 가로 간격
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05),  // 반응형 패딩
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.yellow.shade100, width: 2.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🏮 ${formatDateTime(wish.date)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: screenWidth * 0.045,  // 반응형 텍스트 크기
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),  // 반응형 간격
                          Text(
                            wish.message ?? "No message",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.06,  // 반응형 텍스트 크기
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),  // 반응형 간격
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Text(
                  'No data found',
                  style: TextStyle(color: Colors.white), // 데이터가 없을 때 메시지
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
