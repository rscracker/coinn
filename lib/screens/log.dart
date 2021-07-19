import 'package:coin/models/log_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/dbhelper.dart';
import 'package:intl/intl.dart';

class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  String numberWithComma(int param) {
    return new NumberFormat('###,###,###,###')
        .format(param)
        .replaceAll(' ', '');
  }

  DbHelper helper = DbHelper();
  var logList;
  var sum1 = 0;
  var sum2 = 0;
  var sum3 = 0;
  var sum4 = 0;
  var bl1;
  var bl2;
  Future showData() async {
    await helper.openDb();
    logList = await helper.getLists();
    setState(() {
      logList = new List.from(logList.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData();
    return Scaffold(
        body: SafeArea(
          child: Column(
          children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: (logList != null) ? logList.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  sum1 = int.parse(logList[logList.length-1].won);
                  sum3 = int.parse(logList[logList.length-1].dollar);
                  if (index == logList.length-1) {
                    bl1 = sum1;
                    bl2 = sum3;
                  } else {
                    bl1 = int.parse(logList[index].won) - int.parse(logList[index+1].won) - int.parse(logList[index].depWon) + int.parse(logList[index].withWon);
                    bl2 = int.parse(logList[index].dollar) - int.parse(logList[index+1].dollar) - int.parse(logList[index].depDol) + int.parse(logList[index].depDol);
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0, color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${logList[index].date}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "현재 자산(원) : ${numberWithComma(int.parse(logList[index].won))}(원)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold ,

                            ),
                          ),
                          Text(
                            "현재 자산(\$) : ${numberWithComma(int.parse(logList[index].dollar))}(\$)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text("손익(원) :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              Text(
                                " ${numberWithComma(bl1)}(원)",
                                style: TextStyle(
                                  color: (bl1 > 0) ? Colors.red : (bl1 == 0) ? Colors.black : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("손익(\$) :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)
                              ,
                              Text(
                                " ${numberWithComma(bl2)}(\$)",
                                style: TextStyle(
                                  color: (bl2 > 0) ? Colors.red : (bl2 == 0) ? Colors.black : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          (logList[index].depWon == "0") ? Container() : Row(
                            children: <Widget>[
                              Text("입금(원) :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)
                              ,
                              Text(
                                " ${numberWithComma(int.parse(logList[index].depWon))}(원)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                ),
                            ],
                          ),
                          (logList[index].depDol == "0") ? Container() : Row(
                            children: <Widget>[
                              Text("입금(\$) :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)
                              ,
                              Text(
                                " ${numberWithComma(int.parse(logList[index].depDol))}(원)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          (logList[index].withWon == "0") ? Container() : Row(
                            children: <Widget>[
                              Text("출금(원) :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)
                              ,
                              Text(
                                " ${numberWithComma(int.parse(logList[index].withWon))}(원)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          (logList[index].withDol == "0") ? Container() : Row(
                            children: <Widget>[
                              Text("출금(\$) :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)
                              ,
                              Text(
                                " ${numberWithComma(int.parse(logList[index].depDol))}(\$)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
      ],
    ),
        ));
  }
}
