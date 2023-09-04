import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import 'dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeal;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((element) => element.id  == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(dummyMeal.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((element) => element.id == id);
  }

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeal.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(

        colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.pink,
          secondary: Colors.amber, // Accent color
        ),
        canvasColor: Color.fromRGBO(225, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
          headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
          headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
          headline4: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
          headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Raleway', color: Colors.white ),
          headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'RobontoCondensed'),
          subtitle1: TextStyle(fontSize: 16),
          subtitle2: TextStyle(fontSize: 14),
          caption: TextStyle(fontSize: 12),
          button: TextStyle(fontSize: 14),
          overline: TextStyle(fontSize: 10),
        ),
      ),
      //home: TabsScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
    );
  }
}


/*import 'package:flutter/material.dart';
import './categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: Colors.amber, // Accent color
        ),
        canvasColor: Color.fromRGBO(225, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleLarge: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
          titleMedium: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
          titleSmall: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
        ),
      ),
      home: CategoriesScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}*/
