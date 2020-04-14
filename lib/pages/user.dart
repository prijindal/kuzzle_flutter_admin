import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class UserPage extends StatefulWidget {
  final KuzzleSecurityUser user;
  UserPage(this.user);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  KuzzleSecurityUser get _user => StoreProvider.of<AppState>(context)
      .state
      .kuzzlesecurity
      .users
      .users
      .firstWhere((element) => element.uid == widget.user.uid);

  void _refreshData() {
    if (_user.loadingState != KuzzleState.LOADING) {
      StoreProvider.of<AppState>(context)
          .dispatch(getKuzzleUser(widget.user.uid));
    }
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, KuzzleSecurityUser>(
        converter: (store) => store.state.kuzzlesecurity.users.users
            .firstWhere((element) => element.uid == widget.user.uid),
        builder: (context, user) => ResponsiveScaffold(
          subtitle: 'User Management: ${user.name}',
          body: Column(
            children: [
              ListTile(
                title: Text("UID"),
                subtitle: Text(user.uid),
              ),
              ListTile(
                title: Text("Profiles"),
                subtitle: Row(
                  children: user.profileIds.map((e) => Text(e + ",")).toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
