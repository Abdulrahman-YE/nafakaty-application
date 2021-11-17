import 'package:flutter/material.dart';
import 'package:nafakaty_app/core/db/categories_database.dart';
import 'package:nafakaty_app/core/models/category.dart';
import 'package:nafakaty_app/ui/utils/widgets/category_form_widget.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final Category? category;
  const AddEditCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;

  @override
  void initState() {
    super.initState();

    title = widget.category?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: CategoryFormWidget(
          title: title,
          onChangedTitle: (title) => setState(() => this.title = title),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('حفظ'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.category != null;

      if (isUpdating) {
        await updateCategory();
      } else {
        await addCategory();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateCategory() async {
    final category = widget.category!.copy(title: title);

    await CategoriesDatabase.updateCatagory(category);
  }

  Future addCategory() async {
    final category = Category(title: title, createdAt: DateTime.now());

    await CategoriesDatabase.insertCategory(category);
  }
}
