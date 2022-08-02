import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/database/transaction_db.dart';
import 'package:flutter_application_1/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];
  //ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) async {
    // var db = await TransactionDB(dbName: "transaction.db");
    // print(db);
    var db = TransactionDB(dbName: "transactions.db");
    await db.InsertData(statement);
    transactions = await db.loadAllData();

    notifyListeners();
  }
}
