import 'package:coin/models/log_list.dart';
import 'package:coin/screens/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/dbhelper.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String numberWithComma(int param) {
    return new NumberFormat('###,###,###,###')
        .format(param)
        .replaceAll(' ', '');
  }
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DbHelper helper = DbHelper();
  var logList = [];
  var lineCol = Colors.black45;
  Future showData() async {
    await helper.openDb();
    logList = await helper.getLists();
    setState(() {
      logList = logList;
    });
  }

  Future<String> getting = Future<String>.delayed(
    Duration(seconds: 1),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData();
    var totalWonBL = 0;
    var totalDolBL = 0;

    var totalDepWon = 0;
    var totalDepDol = 0;
    var totalWithWon = 0;
    var totalWithDol = 0;

    var _todayBF = 0;
    var temptodayBF = [];
    var _todayBF2 = 0;
    var toWonPer = 0.0;
    var toDolPer = 0.0;

    var todayDepWon = 0;
    var todayDepDol = 0;
    var todayWithWon = 0;
    var todayWithDol = 0;

    int lastDateWon = 0;
    int lastDateDol = 0;
    var revlogList = new List.from(logList.reversed);
    if (revlogList.length != 0) {
      if (revlogList[0].date.substring(0,10) == formattedDate && revlogList[revlogList.length-1].date.substring(0,10) == formattedDate){
        setState(() {
          lastDateWon = int.parse(revlogList[revlogList.length-1].won);
          lastDateDol = int.parse(revlogList[revlogList.length-1].dollar);
        });
      } else {
        for ( var i = 0; i < revlogList.length-1; i++) {
          if (revlogList[0].date.substring(0,10) == formattedDate && revlogList[i].date.substring(0,10) != formattedDate) {
            setState(() {
              lastDateWon = int.parse(revlogList[i].won);
              lastDateDol = int.parse(revlogList[i].dollar);
            });
          }
        }
      }
    }
    if (logList.length != 0) {
      logList.forEach((list) {
        if (list.date.substring(0,10) == formattedDate){
          temptodayBF.add(list);
          setState(() {
            todayDepWon += int.parse(list.depWon);
            todayDepDol += int.parse(list.depDol);
            todayWithWon += int.parse(list.withWon);
            todayWithDol += int.parse(list.withDol);
          });
        }
        if (list.depWon != 0 || list.depDol != 0) {
          totalDepWon += int.parse(list.depWon);
          totalDepDol += int.parse(list.depDol);
        }
        if (list.withWon != 0 || list.withDol != 0) {
          totalWithWon += int.parse(list.withWon);
          totalWithDol += int.parse(list.withDol);
        }
      });
      setState(() {
        totalWonBL = int.parse(logList[logList.length-1].won) - totalDepWon + totalWithWon;
        totalDolBL = int.parse(logList[logList.length-1].dollar) - totalDepDol + totalWithDol;
      });
      if(temptodayBF.length != 0){
        setState(() {
          _todayBF = int.parse(temptodayBF[temptodayBF.length-1].won) - lastDateWon - todayDepWon + todayWithDol;
          _todayBF2 = int.parse(temptodayBF[temptodayBF.length-1].dollar) - lastDateDol - todayDepDol + todayWithDol;
          toWonPer = (_todayBF / int.parse(temptodayBF[0].won)) * 100;
          toDolPer = (_todayBF2 / int.parse(temptodayBF[0].dollar)) * 100;
        });
      } else {
        setState(() {
          _todayBF = 0;
          _todayBF2 = 0;
          toWonPer = 0;
          toDolPer = 0;
        });
      }
    }

    return FutureBuilder(
      future: getting,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData == false){
          return Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("총 자산",
                    style : TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lineCol,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(int.parse(logList[logList.length-1].won))}원",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width : 3,
                        )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(int.parse(logList[logList.length-1].dollar))}\$",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                        )),

                  ),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width: 3,
                        ),
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("총 손익",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lineCol,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(totalWonBL)}원",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (totalWonBL > 0) ? Colors.red : (totalWonBL == 0) ? Colors.black: Colors.blue,
                        )),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width : 3,
                        )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(totalDolBL)}\$",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (totalDolBL > 0) ? Colors.red : (totalDolBL == 0) ? Colors.black: Colors.blue,
                        ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width: 3,
                        ),
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("1일 손익",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lineCol,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(_todayBF)}원",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_todayBF > 0) ? Colors.red : (_todayBF == 0) ? Colors.black: Colors.blue,
                        )),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width : 3,
                        )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("${numberWithComma(_todayBF2)}\$",
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_todayBF2 > 0) ? Colors.red : (_todayBF2 == 0) ? Colors.black: Colors.blue,
                        )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: lineCol,
                          width: 3,
                        ),
                      )
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("총 수익률",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lineCol,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Text("${numberWithComma(((totalWonBL / totalDepWon) * 100).toInt())}%(원)",
                            style : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (totalWonBL > 0) ? Colors.red : (totalWonBL == 0) ? Colors.black: Colors.blue,
                            )),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                          right: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Text("${numberWithComma(((totalDolBL / totalDepDol) * 100).toInt())}%(\$)",
                            style : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (totalDolBL > 0) ? Colors.red : (totalDolBL == 0) ? Colors.black: Colors.blue,
                            )),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text("1일 수익률",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lineCol,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Text("${numberWithComma(toWonPer.toInt())}%(원)",
                            style : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (toWonPer > 0) ? Colors.red : (toWonPer == 0) ? Colors.black: Colors.blue,
                            )),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                          right: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Text("${numberWithComma(toDolPer.toInt())}%(\$)",
                            style : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (toDolPer> 0) ? Colors.red : (toDolPer == 0) ? Colors.black: Colors.blue,
                            )),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lineCol,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }
    );
  }
}

