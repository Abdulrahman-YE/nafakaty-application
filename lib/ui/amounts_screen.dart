import 'package:flutter/material.dart';
import 'package:nafakaty_app/core/db/database_connection.dart';
import 'package:nafakaty_app/core/models/amount.dart';
import 'package:nafakaty_app/ui/add_edit_amount_screen.dart';
import 'package:nafakaty_app/ui/amount_detail_screen.dart';
import 'package:nafakaty_app/ui/utils/widgets/amount_card_widget.dart';

class AmountsScreen extends StatefulWidget {
  final int categoryId;
  const AmountsScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _AmountsScreenState createState() => _AmountsScreenState();
}

class _AmountsScreenState extends State<AmountsScreen> {
  late List<Amount> amounts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshAmounts();
  }

  Future refreshAmounts() async {
    setState(() => isLoading = true);

    this.amounts = await AmountDatabase.readAmounts(widget.categoryId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'المبالغ',
          ),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : amounts.isEmpty
                  ? const Text(
                      'لا يوجد أي مبالغ حاليا',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildAmounts(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            debugPrint('id: ${widget.categoryId.toString()}');

            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddEditAmountScreen(
                        categoryId: widget.categoryId,
                      )),
            );
            refreshAmounts();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );

    ;
  }

  Widget buildAmounts() => ListView.separated(
      itemBuilder: (context, index) {
        final amount = amounts[index];
        return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AmountDetailScreen(amountId: amount.id!)));
              refreshAmounts();
            },
            child: AmountCardWidget(
              amount: amount,
            ));
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: amounts.length);
}
