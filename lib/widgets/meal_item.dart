import 'package:flutter/material.dart';
import '../Models/meals.dart';
import '../screens/meals_details_screen.dart';

class MealItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get ComplexityText{
    switch(complexity){
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get AffordabilityText{
    switch(affordability){
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Expensive';
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
        MealsDetailsScreen.routeName,
        arguments: id
    ).then((result) {
      if(result!=null){
        // removeItem(result);
        //...
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl,height: 250,width: double.infinity,fit: BoxFit.cover,),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    width: 200,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Text(title,
                      style: const TextStyle(fontSize: 25,color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),

                      const SizedBox(width: 5,),

                      Text('$duration min'),
                    ],),
                  Row(
                    children: [
                      const Icon(Icons.work),

                      const SizedBox(width: 5,),

                      Text(ComplexityText),
                    ],),
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee_sharp),

                      const SizedBox(width: 5,),

                      Text(AffordabilityText),
                    ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
