import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3/2,
        ),
      children: DUMMY_CATEGORIES.map((catData) => CategoryItem(catData.id,catData.title, catData.color)).toList(),
    );
  }
}
