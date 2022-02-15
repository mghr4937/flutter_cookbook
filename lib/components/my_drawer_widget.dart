import 'package:cookbook/connection/server_controller.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final ServerController serverController;

  const MyDrawer({this.serverController, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.purple[700],
                Colors.deepPurple[800],
              ],
            )),
            accountName: Text(serverController.loggedUser.nickname),
            currentAccountPicture: CircleAvatar(
              backgroundImage: FileImage(serverController.loggedUser.photo),
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/register', arguments: serverController.loggedUser);
            }, accountEmail: null,
        ),
        ListTile(
          leading:  Icon(Icons.book, color: Colors.purple[700]),
          title: const Text('Mis Recetas'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/my-recipes');
          },
        ),
        ListTile(
          leading:  Icon(Icons.favorite, color: Colors.purple[700]),
          title: const Text('Mis Favoritos'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        ListTile(
          leading:  Icon(Icons.power_settings_new, color: Colors.purple[700]),
          title: const Text('Cerrar Sesion'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ]),
    );
  }
}
