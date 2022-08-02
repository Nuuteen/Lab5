import 'dart:io';

import 'package:flutter_application_1/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
//บริการเกี่ยวกับฐานข้อมูล

  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  InsertData(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date
    });
  }
}
