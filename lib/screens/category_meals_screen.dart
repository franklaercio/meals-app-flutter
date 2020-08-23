import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> diplayedMeals;

  @override
  void initState() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categotyId = routeArgs['id'];
    diplayedMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categotyId);
    }).toList();

    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      diplayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: diplayedMeals[index].id,
            title: diplayedMeals[index].title,
            imageUrl: diplayedMeals[index].imageUrl,
            duration: diplayedMeals[index].duration,
            affordability: diplayedMeals[index].affordability,
            complexity: diplayedMeals[index].complexity,
            removeItem: _removeMeal,
          );
        },
        itemCount: diplayedMeals.length,
      ),
    );
  }
}
