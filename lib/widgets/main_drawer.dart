import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(IconData icon,String title,VoidCallback tapHandler){
    return ListTile(
      leading: Icon(icon,size: 25,),
      title: Text(title,style:const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            alignment: Alignment.center,
            child: Text('Cooking Up!',style: TextStyle(fontSize: 25,fontFamily: 'Font',fontWeight: FontWeight.bold),),
          ),

          const SizedBox(height: 20,),

          buildListTile(
            Icons.restaurant,
            'Meals',
              (){
              Navigator.of(context).pushReplacementNamed('/');
              }
          ),

          buildListTile(
              Icons.settings,
              'Filters',
                  (){
                Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
              }
          ),
        ],
      ),
    );
  }
}
