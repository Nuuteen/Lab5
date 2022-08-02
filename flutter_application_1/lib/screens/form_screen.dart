import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Transaction.dart';
import 'package:flutter_application_1/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร์มบันทึกข้อมูล"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: true,
                  controller: titleController,
                  validator: (str) {
                    var c_str = str!.isEmpty;
                    if (str == null) {
                      return "กรุณาป้อนชื่อรายการ";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (str) {
                    var c_str = str!.isEmpty;
                    if (str == null) {
                      return "กรุณาป้อนจำนวนเงิน";
                    }
                    if (double.parse(str) <= 0) {
                      return "ระบุ มากกว่า 0";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("เพิ่มข้อมูล"),
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      Transaction statement = Transaction(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      //เรียก provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);

                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
