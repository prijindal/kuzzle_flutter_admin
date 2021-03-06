import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class UserPage extends StatelessWidget {
  const UserPage(this.user);
  final KuzzleSecurityUser user;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, KuzzleSecurityUser>(
        onInit: (store) {
          if (store.state.kuzzlesecurity.users.users
                  .firstWhere((element) => element.uid == user.uid)
                  .loadingState !=
              KuzzleState.LOADING) {
            store.dispatch(getKuzzleUser(user.uid));
          }
        },
        converter: (store) => store.state.kuzzlesecurity.users.users
            .firstWhere((element) => element.uid == user.uid),
        builder: (context, user) => ResponsiveScaffold(
          subtitle: 'User Management: ${user.name}',
          body: AnimatedColumn(
            children: [
              ListTile(
                title: const Text('UID'),
                subtitle: Text(user.uid),
              ),
              ListTile(
                title: const Text('Profiles'),
                subtitle: Row(
                  children: user.profileIds.map((e) => Text('$e,')).toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
