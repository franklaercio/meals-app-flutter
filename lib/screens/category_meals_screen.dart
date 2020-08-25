import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> diplayedMeals;
  var _loadedInitDate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitDate) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categotyId = routeArgs['id'];
      diplayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categotyId);
      }).toList();

      _loadedInitDate = true;
    }

    super.didChangeDependencies();
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
