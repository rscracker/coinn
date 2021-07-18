import 'package:coin/screens/log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/log_list.dart';

class DbHelper {
 final int version = 1;
 var db;

 static final DbHelper _dbHelper = DbHelper._internal();
 DbHelper._internal();
 factory DbHelper(){
   return _dbHelper;
 }

 Future<Database> openDb() async {
   if (db==null) {
     db = await openDatabase(join(await getDatabasesPath(), 'loglist3.db'),
     onCreate: (database, version) {
       database.execute(
           'CREATE TABLE lists(id INTEGER PRIMARY KEY, date TEXT, won TEXT, dollar TEXT, depWon TEXT, depDol TEXT, withWon TEXT, withDol TEXT)');
     }, version: version);
   }
   return db;
 }

 Future<int> insertList(LogList list) async{
   int id = await this.db.insert(
     'lists',
     list.toMap(),
     conflictAlgorithm : ConflictAlgorithm.replace,
   );
   return id;
 }

 Future<List<LogList>> getLists() async{
   final List<Map<String,dynamic>> maps = await db.query('lists');

   return List.generate(maps.length, (i) {
     return LogList(
       maps[i]['id'],
       maps[i]['date'],
       maps[i]['won'],
       maps[i]['dollar'],
       maps[i]['depWon'],
       maps[i]['depDol'],
       maps[i]['withWon'],
       maps[i]['withDol'],
     );
   });
 }

}