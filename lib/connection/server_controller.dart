import 'package:flutter/widgets.dart';
import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart'
    as server;
import 'package:flutter_modulo1_fake_backend/models.dart';

class ServerController {
  User loggedUser;

  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User> login(String username, String password) async {
    return await server.backendLogin(username, password);
  }

  Future<bool> register(User user) async {
    return await server.addUser(user);
  }

  Future<List<Recipe>> getRecipesList() async {
    return await server.getRecipes();
  }
}
