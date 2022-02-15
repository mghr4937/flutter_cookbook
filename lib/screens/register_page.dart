import 'dart:io';
import 'package:cookbook/components/image_picker_widget.dart';
import 'package:cookbook/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class RegisterPage extends StatefulWidget {
  final ServerController serverController;
  final User userToEdit;
  final BuildContext context;

  const RegisterPage(this.serverController, this.context,
      {Key key, this.userToEdit})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String username = "";
  String password = "";
  String errorMessage = "";
  Genrer genrer = Genrer.MALE;
  bool _showPassword = false;
  bool editinguser = false;

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            ImagePickerWidget(
              imageFile: imageFile,
              onImageSelected: (File file) {
                setState(() {
                  imageFile = file;
                });
              },
            ),
            SizedBox(
              height: kToolbarHeight + 25,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text((editinguser) ? "Editar Perfil" : "Registrarse"),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          initialValue: widget.userToEdit != null
                              ? widget.userToEdit.nickname
                              : "",
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
                          initialValue: widget.userToEdit != null
                              ? widget.userToEdit.password
                              : "",
                          decoration: InputDecoration(
                              labelText: "Contraseña:",
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              )),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Genero",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile(
                                    title: const Text(
                                      "Masculino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: Genrer.MALE,
                                    groupValue: genrer,
                                    onChanged: (value) {
                                      setState(() {
                                        genrer = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text(
                                      "Femenino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: Genrer.FEMALE,
                                    groupValue: genrer,
                                    onChanged: (value) {
                                      setState(() {
                                        genrer = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _doProcess(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text((editinguser) ? "Editar" : "Registrar"),
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

  void _doProcess(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (imageFile == null) {
        showSnackBar(context, "Seleccione una imagen", Colors.deepOrange);
        return;
      }
      User user = User(
          genrer: genrer,
          nickname: username,
          password: password,
          photo: imageFile);
      bool state;
      if (editinguser) {
        user.id = widget.serverController.loggedUser.id;
        state = await widget.serverController.editUser(user);
      } else {
        state = await widget.serverController.register(user);
      }
      final action = editinguser ? "actualizar" : "guardar";
      final action2 = editinguser ? "Actualizado" : "Guardado";
      if (!state) {
        showSnackBar(context, "No se pudo $action el usuario, intente de nuevo",
            Colors.deepOrange);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("$action2 correctamente"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
      }
    }
  }

  void showSnackBar(BuildContext context, String title, Color backColor) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: backColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editinguser = (widget.userToEdit != null);

    if (editinguser) {
      username = widget.userToEdit.nickname;
      password = widget.userToEdit.password;
      imageFile = widget.userToEdit.photo;
      genrer = widget.userToEdit.genrer;
    }
  }
}
