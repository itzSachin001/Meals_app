import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../Models/meals.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName='/category-meals';

  final List<Meal> availablemeals;

  CategoryMealsScreen({required this.availablemeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  late String categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs=ModalRoute.of(context)?.settings.arguments as Map<String,String>;
    final categoryId=routeArgs['id'];
    categoryTitle=routeArgs['title']!;
    categoryMeals=widget.availablemeals.where((meal) {
      return meal.categoryIds.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId){
  //   setState(() {
  //     categoryMeals.removeWhere((meal) =>
  //       meal.id == mealId
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title:Text(categoryTitle),),
      body: ListView.builder(itemBuilder: (context, index) {
        return MealItem(
          id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
        );
      },
      itemCount: categoryMeals.length,),
    );
  }
}
