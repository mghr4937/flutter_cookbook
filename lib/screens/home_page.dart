import 'package:cookbook/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  final ServerController serverController;

  const HomePage(this.serverController, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cookbook'),
      ),
      drawer: MyDrawer(
        serverController: widget.serverController),
      body: FutureBuilder<List<Recipe>>(
          future: widget.serverController.getRecipesList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = snapshot.data;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Recipe recipe = list[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(recipe.photo),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            color: Colors.black.withOpacity(0.50),
                            child: ListTile(
                              title: Text(
                                recipe.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                recipe.user.nickname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.red,
                                onPressed: () {
                                  //widget.serverController.addFavorite(recipe);
                                },
                                iconSize: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_recipe');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
