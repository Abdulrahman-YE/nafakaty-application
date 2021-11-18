import 'package:flutter/material.dart';
import 'package:nafakaty_app/core/db/database_connection.dart';
import 'package:nafakaty_app/core/models/amount.dart';
import 'package:nafakaty_app/ui/add_edit_amount_screen.dart';
import 'package:nafakaty_app/ui/utils/widgets/amount_card_widget.dart';

class AmountDetailScreen extends StatefulWidget {
  final int amountId;
  const AmountDetailScreen({Key? key, required this.amountId})
      : super(key: key);

  @override
  _AmountDetailScreenState createState() => _AmountDetailScreenState();
}

class _AmountDetailScreenState extends State<AmountDetailScreen> {
  late Amount amount;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshAmount();
  }

  void refreshAmount() async {
    setState(() {
      this.isLoading = true;
    });
    amount = await AmountDatabase.readAmount(widget.amountId);
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            actions: [editButton(), deleteButton()],
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(12),
                  child: AmountCardWidget(amount: amount))),
    );
  }

  Widget editButton() => IconButton(
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditAmountScreen(amount: amount),
        ));
        refreshAmount();
      },
      icon: const Icon(Icons.edit_outlined));

  Widget deleteButton() => IconButton(
      onPressed: () async {
        await AmountDatabase.deleteAmount(widget.amountId);
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.delete_outline));
}
