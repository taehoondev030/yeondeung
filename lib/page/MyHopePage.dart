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
    // SharedPreferences에서 저장된 토큰을 불러옴
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');  // 저장된 토큰 가져오기

    if (token == null) {
      throw Exception("No token found");
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

      // JSON 리스트를 Wish 객체 리스트로 변환
      List<Hope> wishes = body.map((dynamic item) => Hope.fromJson(item)).toList();
      return wishes;

    } else {
      throw Exception('Failed to load wishes');
    }
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
                  return CircularProgressIndicator(color: Colors.yellow,);  // 데이터 로딩 중일 때 로딩 표시
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');  // 에러 발생 시
                } else if (snapshot.hasData) {
                  // 데이터가 있을 때 리스트로 표시
                  List<Hope> wishes = snapshot.data!;
                  return ListView.builder(
                    itemCount: wishes.length,
                    itemBuilder: (context, index) {
                      Hope wish = wishes[index];

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${wish.id}번째 등불",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              wish.message ?? "No message",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Date: ${formatDateTime(wish.date)}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No data found');
                }
              },
            ),
          ),
        ),
    );
  }
}
