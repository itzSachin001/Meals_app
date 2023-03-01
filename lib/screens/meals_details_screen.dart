import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealsDetailsScreen extends StatefulWidget {
  static const routeName='/meals-detail';

  final Function toggleFavourite;
  final Function isFavouriteMeal;

  MealsDetailsScreen(this.toggleFavourite,this.isFavouriteMeal);

  @override
  State<MealsDetailsScreen> createState() => _MealsDetailsScreenState();
}

class _MealsDetailsScreenState extends State<MealsDetailsScreen> {
  Widget buildSectionTitle(BuildContext context,String text){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child:Text(text,style: Theme.of(context).textTheme.titleMedium),
  );
  }

  Widget buildContainer(Widget child){
    return Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Colors.grey),
    borderRadius: BorderRadius.circular(20)
    ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context)?.settings.arguments as String;
    final mealsId=routeArgs;
    final selectedMeal=DUMMY_MEALS.firstWhere((meal) => meal.id == mealsId);

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title),),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(selectedMeal.imageUrl),
              ),

              buildSectionTitle(context, "Ingredients"),

              buildContainer(
                ListView.builder(
                    itemBuilder: (context, index) => Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(selectedMeal.ingredients[index]),
                      ),
                    ),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),

              buildSectionTitle(context, 'Steps'),

              buildContainer(ListView.builder(
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index+1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      const Divider(thickness: 2),
                    ],
                  ),
                itemCount: selectedMeal.steps.length,
              ),)
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(onPressed:() => widget.toggleFavourite(mealsId),
        child: Icon(widget.isFavouriteMeal(mealsId) ? Icons.star : Icons.star_border)),
    );
  }
}
