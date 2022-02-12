import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage(this.user, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome ${widget.user.nickname}'),
      ),
    );
  }
}
