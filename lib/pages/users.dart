import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/user.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage();

  void _goToAddUserPage(BuildContext context) {
    Navigator.of(context).pushNamed('newuser');
  }

  void _goToUserPage(BuildContext context, KuzzleSecurityUser user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserPage(user)));
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: 'User Management',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _goToAddUserPage(context),
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
                  : AnimatedListView(
                      itemCount: users.users.length,
                      itemBuilder: (context, i) => ListTile(
                        title: Text(users.users[i].uid),
                        onTap: () => _goToUserPage(context, users.users[i]),
                        subtitle: Row(
                          children: users.users[i].profileIds
                              .map((e) => Text('$e,'))
                              .toList(),
                        ),
                      ),
                    ),
        ),
      );
}
