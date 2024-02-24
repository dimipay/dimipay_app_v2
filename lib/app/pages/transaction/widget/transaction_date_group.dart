import 'package:dimipay_app_v2/app/pages/transaction/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/transaction/model.dart';

class TransactionDateGroup extends StatelessWidget {
  final DateFormat headerFormat;
  final DateTime date;
  final List<Transaction> transactions;
  TransactionDateGroup({
    super.key,
    required this.date,
    required this.transactions,
    final DateFormat? headerFormat,
  }) : headerFormat = headerFormat ?? DateFormat('d일 E요일', 'ko_KR');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
          child: Text(
            headerFormat.format(date),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: transactions.map((e) => TransactionItem(transaction: e)).toList(),
        ),
      ],
    );
  }
}
