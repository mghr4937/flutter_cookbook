import 'package:cookbook/connection/server_controller.dart';
import 'package:cookbook/screens/add_recipe_page.dart';
import 'package:cookbook/screens/home_page.dart';
import 'package:cookbook/screens/login_page.dart';
import 'package:cookbook/screens/my_favorites_page.dart';
import 'package:cookbook/screens/my_recipes.dart';
import 'package:cookbook/screens/recipe_page.dart';
import 'package:cookbook/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo - Cookbook',
      initialRoute: '/',
      theme: ThemeData(
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.deepPurple,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        textTheme:
            const TextTheme(bodyText2: TextStyle(color: Colors.deepPurple)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return LoginPage(_serverController, context);
              case '/home':
                User user = settings.arguments;
                _serverController.loggedUser = user;
                return HomePage(_serverController);
              case '/register':
                User loggedUser = settings.arguments;
                return RegisterPage(
                  _serverController,
                  context,
                  userToEdit: loggedUser,
                );
              case '/favorites':
                return MyFavoritePage(_serverController);
              case '/my-recipes':
                return MyRecipesPage(_serverController);
              case '/recipe':
                Recipe recipe = settings.arguments;
                return RecipePage(
                    recipe: recipe, serverController: _serverController);
              case "/add_recipe":
                return AddRecipePage(_serverController);
              case "/edit_recipe":
                return AddRecipePage(
                  _serverController,
                  recipe: settings.arguments,
                );
              default:
                return LoginPage(_serverController, context);
            }
          },
        );
      },
    );
  }
}
