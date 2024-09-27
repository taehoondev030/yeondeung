import 'package:flutter/material.dart';

    class HopeDetailPage extends StatelessWidget {
      String hopeTitle;
      String hopeImagePath;
      String? detail;

      HopeDetailPage({Key? key, required this.hopeTitle, required this.hopeImagePath, this.detail}) : super(key: key);

      @override
      Widget build(BuildContext) {
        return Scaffold(
          appBar: AppBar(title: Text("${hopeTitle}페이지"),),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 56),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(38.5),
                  border: Border.all(color: Colors.black, width: 3)
                ),
                child: Image.asset(hopeImagePath)
              ),
              Text(detail??"", style: TextStyle(fontSize: 30, color: Colors.green),)
            ],
          ),
        );
      }
      }
