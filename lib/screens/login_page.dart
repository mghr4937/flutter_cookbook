import 'package:cookbook/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class LoginPage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;

  LoginPage(this.serverController, this.context, {Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.deepPurple[300],
                  Colors.purple[200],
                  Colors.white,
                ],
              )),
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Center(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                          ),
                          onSaved: (String value) {
                            username = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese un usuario';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                          ),
                          onSaved: (String value) {
                            password = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese la contraseña';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Iniciar Sesión'),
                              if (_isLoading)
                                Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: const CircularProgressIndicator()),
                            ],
                          ),
                        ),
                        if (errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('¿No tienes cuenta?'),
                            TextButton(
                              onPressed: () {
                                _signUp(context);
                              },
                              child: const Text('Registrate'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (!_isLoading) {
     if(_formKey.currentState.validate()) {
       _formKey.currentState.save();
       setState(() {
         _isLoading = true;
         errorMessage = "";
       });
       User user = await widget.serverController.login(username, password);
       if (user != null) {
         Navigator.of(context).pushReplacementNamed("/home", arguments: user);
       } else {
         setState(() {
           errorMessage = "Usuario o contraseña incorrectos";
           _isLoading = false;
         });
       }
     }
      }
  }

  void _signUp(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  @override
  void initState() {
    super.initState();
    widget.serverController.init(widget.context);
  }
}
