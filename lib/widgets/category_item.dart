import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';
class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id,this.title, this.color);
  
  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // another way to go to the other screen through routes section 7 video 9 and 10
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,),
        decoration: BoxDecoration(gradient: LinearGradient(
            colors: [color.withOpacity(0.7),
              color
            ],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft
        ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
