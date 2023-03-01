import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favourite_screen.dart';
import '../widgets/main_drawer.dart';
import '../Models/meals.dart';

class TabsScreen extends StatefulWidget {

  List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  late List<Map<String,Object>> _pages;

  int _selectedPageIndex=0;
  void _selectedScreen(int index){
    _selectedPageIndex=index;
    setState(() {

    });
  }

  @override
  void initState() {
    _pages=[
      {'page':CategoriesScreen(),'title': 'Categories'},
      {'page':FavouriteScreen(widget.favouriteMeals), 'title': 'Your Favourite'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(_pages[_selectedPageIndex]['title'] as String),),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.category),label: 'Category',backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(icon: const Icon(Icons.star),label: 'Favourite',backgroundColor: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}
// DefaultTabController(length: 2, child: Scaffold(
// appBar: AppBar(title: Text("Meals"),bottom:const TabBar(
// tabs: [
// Tab(icon: Icon(Icons.category),text: 'Category'),
// Tab(icon: Icon(Icons.star), text: 'Favourite',),
// ],
// ),),
// body: TabBarView(
// children: [
// CategoriesScreen(),
// FavouriteScreen()
// ],
// ),
// ));