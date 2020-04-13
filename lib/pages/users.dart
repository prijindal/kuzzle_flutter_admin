import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  void _goToAddUserPage() {
    Navigator.of(context).pushNamed("newuser");
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: "User Management",
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _goToAddUserPage,
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text("User"),
            )
          ],
        ),
      );
}
