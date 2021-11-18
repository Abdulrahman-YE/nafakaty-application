import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nafakaty_app/core/db/database_connection.dart';
import 'package:nafakaty_app/core/models/category.dart' as category_model;
import 'package:nafakaty_app/ui/amounts_screen.dart';
import 'package:nafakaty_app/ui/utils/ui_helpers.dart';

import 'dart:ui' as ui;

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({Key? key}) : super(key: key);

  @override
  _CatagoriesScreenState createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> {
  late List<category_model.Category> categories;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    refreshCategories();
  }

  @override
  void dispose() {
    DatabaseConnection.close();

    super.dispose();
  }

  Future _showForm(category_model.Category? category) async {
    if (category != null) {
      _titleController.text = category.title;
    }

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        //To make it scrollable
        isScrollControlled: true,
        builder: (context) => Directionality(
              textDirection: ui.TextDirection.rtl,
              child: SingleChildScrollView(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _titleController,
                          validator: (title) => title != null && title.isEmpty
                              ? 'لا يمكن للعنوان ان يكون فارغ'
                              : null,
                          decoration:
                              const InputDecoration(label: Text('العنوان')),
                        ),
                      ),
                      SizeConfig.verticalSpaceSmall,
                      ElevatedButton(
                        onPressed: () async {
                          final isValid = _formKey.currentState!.validate();

                          if (isValid) {
                            final isUpdating = category != null;

                            if (isUpdating) {
                              await _updateCategory(
                                  category!.copy(title: _titleController.text));
                            } else {
                              await _addCategory(category_model.Category(
                                  title: _titleController.text,
                                  createdAt: DateTime.now()));
                            }

                            //Clear The text fields
                            Navigator.of(context).pop();
                          }
                          _titleController.text = '';
                        },
                        child: category == null
                            ? const Text('اضافة فئة')
                            : const Text('تحديث'),
                      ),
                      SizeConfig.verticalSpaceTiny
                    ],
                  ),
                ),
              )),
            ));
  }

  Future<void> _addCategory(category_model.Category category) async {
    await CategoriesDatabase.insertCategory(category);
    refreshCategories();
  }

  Future<void> _updateCategory(category_model.Category category) async {
    await CategoriesDatabase.updateCatagory(category);
    refreshCategories();
  }

  void _deleteCategory(category_model.Category category) async {
    await CategoriesDatabase.deleteCatagory(category.id!);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('تم حذف الفئة بنجاح!'),
    ));
    refreshCategories();
  }

  Future refreshCategories() async {
    //To show the circular progress bar
    setState(() {
      isLoading = true;
    });

    categories = await CategoriesDatabase.readCatagories();

    //To hide the circular progress bar
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الفئات'),
          ),
          body: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : categories.isEmpty
                      ? const Text('لا توجد اي فئات حاليا')
                      : buildCategories()),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _showForm(null);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ));
  }

  Widget buildCategories() => ListView.separated(
      itemCount: categories.length,
      padding: const EdgeInsets.all(8),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
            onTap: () async {
              debugPrint('id: ${category.id!.toString()}');
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AmountsScreen(categoryId: category.id!)));
            },
            child: ListTile(
              leading: Icon(Icons.receipt_outlined),
              contentPadding: EdgeInsets.all(8),
              title: Text(category.title),
              subtitle:
                  Text(DateFormat().add_yMMMd().format(category.createdAt)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async => await _showForm(category),
                        icon: const Icon(Icons.edit_outlined)),
                    IconButton(
                        onPressed: () => showDeleteAlert(category),
                        icon: const Icon(Icons.delete_forever_outlined))
                  ],
                ),
              ),
            ));
      });

  void showDeleteAlert(category_model.Category category) {
    showDialog(
        context: context,
        builder: (_) {
          return Directionality(
            textDirection: ui.TextDirection.rtl,
            child: AlertDialog(
              elevation: 5,
              title: const Text('تأكيد العملية'),
              content: const Text(
                  'هذه العملية سيتبعها حذف للمبالغ المرتبطة بهذه الفئة !'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _deleteCategory(category);
                    Navigator.of(context).pop();
                  },
                  child: const Text('تأكيد'),
                ),
                SizeConfig.horizontalSpaceSmall,
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('الغاء'),
                ),
              ],
            ),
          );
        });
  }
}
