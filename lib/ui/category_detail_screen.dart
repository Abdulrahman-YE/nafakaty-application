import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nafakaty_app/core/db/categories_database.dart';
import 'package:nafakaty_app/core/models/category.dart';
import 'dart:ui' as ui;

import 'add_edit_category_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  final int categoryId;
  const CategoryDetailScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Category category;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshCategory();
  }

  Future refreshCategory() async {
    setState(() {
      this.isLoading = true;
    });
    this.category =
        await CategoriesDatabase.instance.readCategory(widget.categoryId);
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              actions: [editButton(), deleteButton()],
            ),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        Text(category.title),
                        SizedBox(
                          height: 8,
                        ),
                        Text(DateFormat.yMMMd().format(category.createdAt))
                      ],
                    ),
                  )));
  }

  Widget deleteButton() => IconButton(
      icon: Icon(Icons.delete_outline_outlined),
      onPressed: () async {
        await CategoriesDatabase.instance.deleteCatagory(widget.categoryId);
        Navigator.of(context).pop();
      });

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditCategoryScreen(category: category)));
        refreshCategory();
      });
}
