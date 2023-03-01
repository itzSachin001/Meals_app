import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meals_details_screen.dart';
import './screens/tabs_screen.dart';

import 'Models/meals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters={
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };

  final List<Meal> _favouriteMeals=[];
  List<Meal> _availableMeals=DUMMY_MEALS;

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters=filterData;
      
      _availableMeals=DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree){
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian){
          return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree){
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex>=0){
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavouriteMeal(String id){
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'CatFont',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleMedium: const TextStyle(
            fontSize: 20,
            fontFamily: 'CatFont',
              fontWeight: FontWeight.bold,
          )
        )
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(availablemeals:_availableMeals),
        MealsDetailsScreen.routeName: (context) => MealsDetailsScreen(_toggleFavourite,_isFavouriteMeal),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}
