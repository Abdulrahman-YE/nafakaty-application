import 'package:flutter/material.dart';
import 'package:nafakaty_app/core/db/database_connection.dart';
import 'package:nafakaty_app/core/models/amount.dart';
import 'package:nafakaty_app/ui/utils/widgets/amount_form_widget.dart';

class AddEditAmountScreen extends StatefulWidget {
  final Amount? amount;
  final int? categoryId;
  const AddEditAmountScreen({Key? key, this.amount, this.categoryId})
      : super(key: key);

  @override
  _AddEditAmountScreenState createState() => _AddEditAmountScreenState();
}

class _AddEditAmountScreenState extends State<AddEditAmountScreen> {
  final _formKey = GlobalKey<FormState>();
  late double value;
  late processTypes processType;
  late String target;
  String? note;
  int? categoryId;

  @override
  void initState() {
    super.initState();

    value = widget.amount?.value ?? 0.0;
    processType = widget.amount?.processType ?? processTypes.income;
    target = widget.amount?.target ?? '';
    categoryId = widget.amount?.categoryId ?? widget.categoryId;
    note = widget.amount?.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AmountFormWidget(
            value: value,
            processType: processType,
            target: target,
            note: note,
            categoryId: categoryId!,
            onChangedValue: (value) => setState(() {
              if (double.tryParse(value) != null) {
                this.value = double.tryParse(value) ?? 0.0;
              } else {
                this.value = 0.0;
              }
            }),
            onChangedProcessType: (processType) =>
                setState(() => this.processType = processType),
            onChangedTarget: (target) => setState(() => this.target = target),
            onChangedNote: (note) => setState(() => this.note = note),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = (value != 0) && target.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: () {
          if (isFormValid) {
            addOrUpdateAmount();
          } else {
            _formKey.currentState!.validate();
            return;
          }
        },
        child: const Text('حفظ'),
      ),
    );
  }

  void addOrUpdateAmount() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.amount != null;

      if (isUpdating) {
        await updateAmount();
      } else {
        await addAmount();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateAmount() async {
    final amount = widget.amount!.copy(
      value: value,
      processType: processType,
      target: target,
      categoryId: categoryId,
      note: note,
    );

    await AmountDatabase.updateAmount(amount);
  }

  Future addAmount() async {
    final amount = Amount(
        value: value,
        processType: processType,
        target: target,
        categoryId: categoryId!,
        note: note,
        createdAt: DateTime.now());

    await AmountDatabase.insertAmount(amount);
  }
}
