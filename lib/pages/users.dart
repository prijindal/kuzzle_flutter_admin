import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  void _refreshData() {
    if (StoreProvider.of<AppState>(context)
                .state
                .kuzzlesecurity
                .users
                .loadingState ==
            KuzzleState.INIT ||
        StoreProvider.of<AppState>(context)
                .state
                .kuzzlesecurity
                .users
                .loadingState ==
            KuzzleState.LOADED) {
      StoreProvider.of<AppState>(context).dispatch(getKuzzleUsers);
    }
  }

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
          child: Icon(Icons.add),
          onPressed: _goToAddUserPage,
        ),
        body: StoreConnector<AppState, KuzzleSecurityUsers>(
          converter: (store) => store.state.kuzzlesecurity.users,
          builder: (context, users) =>
              (users.loadingState != KuzzleState.LOADED &&
                      users.users.length == 0)
                  ? Center(
                      child: Text('Loading...'),
                    )
                  : ListView(
                      children: users.users
                          .map<Widget>(
                            (user) => ListTile(
                              title: Text(user.uid),
                              onTap: () => _goToUserPage(user),
                              subtitle: Row(
                                children: user.profileIds
                                    .map((e) => Text(e + ','))
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
        ),
      );
}
