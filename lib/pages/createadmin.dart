import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/appbar.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage();

  @override
  _CreateAdminPageState createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _createAdminAccount() {
    StoreProvider.of<AppState>(context).dispatch(
      createFirstAdmin(
        {
          'local': {
            'username': _usernameController.text,
            'password': _passwordController.text,
          },
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: KuzzleAppBar(
          subtitle: 'Login',
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
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: StoreConnector<AppState, KuzzleState>(
                    converter: (store) => store.state.kuzzleauth.loginState,
                    builder: (context, loginState) => RaisedButton(
                      child: const Text('Create Admin Account'),
                      onPressed: loginState == KuzzleState.LOADING
                          ? null
                          : _createAdminAccount,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
