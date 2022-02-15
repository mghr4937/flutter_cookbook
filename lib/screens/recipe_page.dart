import 'package:cookbook/components/tab_ingredients_widget.dart';
import 'package:cookbook/connection/server_controller.dart';
import "package:flutter/material.dart";
import 'package:flutter_modulo1_fake_backend/models.dart';

import '../components/tab_preparation_widget.dart';

class RecipePage extends StatefulWidget {
  Recipe recipe;

  final ServerController serverController;

  RecipePage({this.recipe, this.serverController, Key key})
      : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool favorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.recipe.name),
                expandedHeight: 320,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget.recipe.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                pinned: true,
                bottom: const TabBar(
                  indicatorWeight: 4,
                  indicatorColor: Colors.deepPurple,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "Ingredientes",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Preparación",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  if(widget.recipe.user.id == widget.serverController.loggedUser.id)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final nRecipe = await
                        Navigator.pushNamed(context, '/edit_recipe',
                            arguments: widget.recipe);
                        setState(() {
                          widget.recipe = nRecipe;
                        });
                      },
                    ),
                  getFavoriteWidget(),
                  IconButton(
                    icon: const Icon(Icons.help),
                    onPressed: () {
                       //widget.serverController.deleteFavorite(widget.recipe);
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ];
          },
          body: TabBarView(
            children: <Widget>[
              TabIngredientsWidget(
                recipe: widget.recipe,
              ),
              TabPreparationWidget(
                recipe: widget.recipe,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFavoriteWidget() {
    if (favorite != null) {
      if (favorite) {
        return IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () async {
            await widget.serverController.deleteFavorite(widget.recipe);
            setState(() {
              favorite = false;
            });
          },
        );
      } else {
        return IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () async {
            await widget.serverController.addFavorite(widget.recipe);
            setState(() {
              favorite = true;
            });
          },
        );
      }
    } else {
      return Container(
          margin: const EdgeInsets.all(15),
          width: 20,
          child: const CircularProgressIndicator());
    }
  }

  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    final state = await widget.serverController.getIsFavorite(widget.recipe);
    setState(() {
      favorite = state;
    });
  }
  
}
