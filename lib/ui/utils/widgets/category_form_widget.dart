import 'package:flutter/material.dart';

class CategoryFormWidget extends StatelessWidget {
  final String? title;
  final ValueChanged<String> onChangedTitle;

  const CategoryFormWidget({
    Key? key,
    this.title = '',
    required this.onChangedTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );
}
