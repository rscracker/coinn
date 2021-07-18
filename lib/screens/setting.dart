import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/dbhelper.dart';
import '../models/log_list.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());


  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("현재 자산",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "현재 자산(원)",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller2,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "현재 자산(\$)",
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("입금",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller3,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "입금(원)",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller4,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "입금(\$)",
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("출금",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller5,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "출금(원)",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller6,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "출금(\$)",
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: saveDB,
              child: Text("Enter")),
        )
      ],
    );
  }



  Future<void> saveDB() async{
    DbHelper sd = DbHelper();

    var fido = LogList(
      0,
      formattedDate,
      (controller1.text == '') ? 0 : controller1.text,
      (controller2.text == '') ? 0 : controller2.text,
      (controller3.text == '') ? 0 : controller3.text,
      (controller4.text == '') ? 0 : controller4.text,
      (controller5.text == '') ? 0 : controller5.text,
      (controller6.text == '') ? 0 : controller6.text,
    );

    await sd.insertList(fido);
  }
}
