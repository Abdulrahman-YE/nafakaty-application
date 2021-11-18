import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nafakaty_app/core/models/amount.dart';

class AmountCardWidget extends StatelessWidget {
  final Amount amount;
  const AmountCardWidget({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('القيمة : ${amount.value.toStringAsFixed(2)}'),
                  Text('النوع : ${processTypeToString(amount.processType)}')
                ],
              ),
              Text('السبب : ${amount.target}'),
              Text('الملاحظة : ${amount.note}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'بتاريخ : ${DateFormat.yMMMd().format(amount.createdAt)}'),
                  Text('الساعة : ${DateFormat.Hm().format(amount.createdAt)}'),
                ],
              ),
            ],
          ),
        )),
      ),
    );
    ;
  }
}
