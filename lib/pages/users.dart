import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/user.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  void _goToAddUserPage() {
    Navigator.of(context).pushNamed('newuser');
  }

  void _goToUserPage(KuzzleSecurityUser user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserPage(user)));
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: 'User Management',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _goToAddUserPage,
        ),
        body: StoreConnector<AppState, KuzzleSecurityUsers>(
          onInit: (store) {
            if (store.state.kuzzlesecurity.users.loadingState ==
                    KuzzleState.INIT ||
                store.state.kuzzlesecurity.users.loadingState ==
                    KuzzleState.LOADED) {
              store.dispatch(getKuzzleUsers);
            }
          },
          converter: (store) => store.state.kuzzlesecurity.users,
          builder: (context, users) =>
              (users.loadingState != KuzzleState.LOADED && users.users.isEmpty)
                  ? const LoadingAnimation()
                  : ListView(
                      children: users.users
                          .map<Widget>(
                            (user) => ListTile(
                              title: Text(user.uid),
                              onTap: () => _goToUserPage(user),
                              subtitle: Row(
                                children: user.profileIds
                                    .map((e) => Text('$e,'))
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
      );
}
