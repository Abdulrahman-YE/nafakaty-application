import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nafakaty_app/core/models/amount.dart';
import 'package:nafakaty_app/ui/utils/ui_helpers.dart';

class AmountFormWidget extends StatelessWidget {
  final double? value;
  final processTypes processType;
  final String? target;
  final String? note;
  final int categoryId;
  final ValueChanged<String> onChangedValue;
  final ValueChanged<processTypes> onChangedProcessType;
  final ValueChanged<String> onChangedTarget;
  final ValueChanged<String> onChangedNote;

  const AmountFormWidget({
    Key? key,
    this.value = 0.0,
    this.processType = processTypes.income,
    this.target = '',
    this.note,
    required this.categoryId,
    required this.onChangedValue,
    required this.onChangedProcessType,
    required this.onChangedTarget,
    required this.onChangedNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizeConfig.verticalSpaceRegular,
              Text(
                'المبلغ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizeConfig.verticalSpaceSmall,
              Divider(),
              SizeConfig.verticalSpaceSmall,
              DropdownButtonFormField(
                  value: processType.index,
                  items: processTypesToList().asMap().entries.map((entry) {
                    return DropdownMenuItem(
                        value: entry.key, child: Text(entry.value));
                  }).toList(),
                  onChanged: (type) {
                    if (type == 0) {
                      onChangedProcessType(processTypes.income);
                    }

                    if (type == 1) {
                      onChangedProcessType(processTypes.expanse);
                    }

                    if (type == 2) {
                      onChangedProcessType(processTypes.loan);
                    }
                  }),
              SizeConfig.verticalSpaceSmall,
              buildValue(),
              SizeConfig.verticalSpaceSmall,
              buildTarget(),
              SizeConfig.verticalSpaceSmall,
              buildNote(),
              SizeConfig.verticalSpaceSmall,
            ],
          ),
        ),
      );

  bool isNumeric(String? s) {
    debugPrint('isNumeric : ${s}');
    if (s != null && s.isNotEmpty) {
      debugPrint(s);
      return double.tryParse(s) != null;
    }
    return false;
  }

  Widget buildValue() {
    return TextFormField(
      maxLines: 1,
      initialValue: value.toString(),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        label: Text('القيمة'),
      ),
      validator: (value) {
        if (isNumeric(value)) {
          debugPrint('isNumeric result : ${value}');

          final _v = double.tryParse(value!);
          if (_v! > 0) {
            debugPrint('value > 0 : ${value}');

            return null;
          } else {
            return 'الرجاء اضافة قيمة اكبر من صفر';
          }
        }
        debugPrint(value);
        return 'الرجاء اضافة قيمة المبلغ ';
      },
      onChanged: (value) => onChangedValue(value),
    );
  }

  Widget buildTarget() => TextFormField(
        maxLines: 1,
        initialValue: target,
        decoration: const InputDecoration(label: Text('السبب')),
        validator: (target) => target != null && target.isEmpty
            ? 'الرجاء اضافة سبب. السبب يمكن ان يكون شخص, صنف, او  ماشابه ذالك.'
            : null,
        onChanged: onChangedTarget,
      );

  Widget buildNote() => TextFormField(
        maxLines: 5,
        initialValue: note,
        decoration: const InputDecoration(label: Text('ملاحظة')),
        validator: (title) {
          if (title != null && title.isEmpty) {
            return null;
          } else {
            return null;
          }
        },
        onChanged: onChangedNote,
      );
}
