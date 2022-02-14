import 'package:cookbook/connection/server_controller.dart';
import 'package:cookbook/screens/home_page.dart';
import 'package:cookbook/screens/login_page.dart';
import 'package:cookbook/screens/register_page.dart';
import 'package:flutter/material.dart';
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
                return RegisterPage(_serverController, context);
              default:
                return LoginPage(_serverController, context);
            }
          },
        );
      },
    );
  }
}
