import 'package:coin/models/log_list.dart';
import 'package:flutter/material.dart';
import '../util/dbhelper.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper helper = DbHelper();
  var logList;
  var lineCol = Colors.black45;

  Future showData() async {
    await helper.openDb();
    logList = await helper.getLists();
    setState(() {
      logList = logList;
    });
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text("총 자산"),
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
            child: Text("${logList[logList.length-1].won}원"),
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
            child: Text("0\$"),
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
            child: Text("총 손익"),
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
            child: Text("0원"),
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
            child: Text("0\$"),
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
            child: Text("1일 손익"),
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
            child: Text("0원"),
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
            child: Text("0\$"),
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
            child: Text("총 수익률"),
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
                child: Text("0%(원)"),
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
                child: Text("0%(\$)"),
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
            child: Text("1일 수익률"),
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
                child: Text("0%(원)"),
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
                child: Text("0%(\$)"),
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
    );
  }
}

