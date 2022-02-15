import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

class TabIngredientsWidget extends StatelessWidget {
  final Recipe recipe;

  const TabIngredientsWidget({this.recipe, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      children: <Widget>[
        Text(
          recipe.name,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          recipe.description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Ingredientes",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: List.generate(recipe.ingredients.length, (int index) {
            final ingredient = recipe.ingredients[index];
            return ListTile(
              leading: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(
                ingredient,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
