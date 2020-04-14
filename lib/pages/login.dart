import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser() {
    StoreProvider.of<AppState>(context).dispatch(
      loginUser(
        "local",
        {
          "username": _usernameController.text,
          "password": _passwordController.text,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: StoreConnector<AppState, KuzzleState>(
                    converter: (store) => store.state.kuzzleauth.loginState,
                    builder: (context, loginState) => RaisedButton(
                      child: Text("Login"),
                      onPressed:
                          loginState == KuzzleState.LOADING ? null : _loginUser,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
