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

  Future<bool> editUser(User user) async {
    loggedUser = user;
    return await server.updateUser(user);
  }

  Future<List<Recipe>> getRecipesList() async {
    return await server.getRecipes();
  }

  Future<List<Recipe>> getMyFavorites() async {
    return await server.getFavorites();
  }

  Future<Recipe> addFavorite(Recipe nFavorite) async {
    return await server.addFavorite(nFavorite);
  }

  Future<bool> deleteFavorite(Recipe favoriteRecipe) async {
    return await server.deleteFavorite(favoriteRecipe);
  }

  Future<bool> getIsFavorite(Recipe recipeToCheck) async {
    return await server.isFavorite(recipeToCheck);
  }

  Future<List<Recipe>> getMyRecipes() async {
    return await server.getUserRecipes(loggedUser);
  }

  Future<Recipe> addRecipe(Recipe nRecipe) async {
    return await server.addRecipe(nRecipe);
  }

  Future<bool> updateRecipe(Recipe recipe) async {
    return await server.updateRecipe(recipe);
  }

}
