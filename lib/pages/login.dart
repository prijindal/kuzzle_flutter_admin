import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleauth/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _remember = false;

  void _loginUser() {
    StoreProvider.of<AppState>(context).dispatch(
      loginUser(
        'local',
        {
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
        remember: _remember,
        environment: StoreProvider.of<AppState>(context)
            .state
            .environments
            .getDefaultEnvironment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const KuzzleAppBar(
          subtitle: "Login",
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                CheckboxListTile(
                  title: const Text('Remember on this device'),
                  value: _remember,
                  onChanged: (newvalue) {
                    setState(() {
                      _remember = newvalue;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: StoreConnector<AppState, KuzzleState>(
                    converter: (store) => store.state.kuzzleauth.loginState,
                    builder: (context, loginState) => RaisedButton(
                      child: const Text('Login'),
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
