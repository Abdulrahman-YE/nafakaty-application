import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nafakaty_app/core/db/categories_database.dart';
import 'package:nafakaty_app/core/models/category.dart';
import 'package:nafakaty_app/ui/category_detail_screen.dart';
import 'package:nafakaty_app/ui/utils/app_theme.dart';
import 'package:nafakaty_app/ui/utils/ui_helpers.dart';

import 'dart:ui' as ui;
import 'add_edit_category_screen.dart';

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({Key? key}) : super(key: key);

  @override
  _CatagoriesScreenState createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> {
  late List<Category> categories;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshCategories();
  }

  @override
  void dispose() {
    CategoriesDatabase.instance.close();

    super.dispose();
  }

  Future refreshCategories() async {
    //To show the circular progress bar
    setState(() {
      isLoading = true;
    });

    this.categories = await CategoriesDatabase.instance.readCatagories();

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
                      ? Text('No Categories')
                      : buildCategories()),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AddEditCategoryScreen()),
              );

              refreshCategories();
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ));
  }

  Widget buildCategories() => ListView.separated(
      itemCount: categories.length,
      padding: const EdgeInsets.all(8),
      separatorBuilder: (_, __) => const Divider(
            color: kcPrimaryColor,
            height: 1,
          ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CategoryDetailScreen(categoryId: category.id!)));
              refreshCategories();
            },
            child: ListTile(
              leading: Icon(Icons.receipt_outlined),
              contentPadding: EdgeInsets.all(8),
              title: Text(category.title),
              subtitle:
                  Text(DateFormat().add_yMMMd().format(category.createdAt)),
            ));
      });
}
