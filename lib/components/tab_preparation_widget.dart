import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

class TabPreparationWidget extends StatelessWidget {
  final Recipe recipe;

  const TabPreparationWidget({this.recipe, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      children: <Widget>[
        const Text(
          "Preparación",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: List.generate(recipe.steps.length, (int index) {
            final step = recipe.steps[index];
            return ListTile(
              leading: Text("${index+1}",
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              title: Text(
                step,
                style: TextStyle(
                  fontSize: 16,
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
