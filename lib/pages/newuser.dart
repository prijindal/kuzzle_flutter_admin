import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/profileschooser.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/profileaction.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  TextEditingController _uidController = TextEditingController();
  bool _autoGenerateUid = false;
  List<String> _profileIds = <String>[];

  void _selectProfiles() async {
    var profileIds = await showDialog<List<String>>(
      context: context,
      builder: (context) => ProfileChooserDialog(
        profileIds: _profileIds,
      ),
    );
    if (profileIds != null) {
      setState(() {
        _profileIds = profileIds;
      });
    }
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
        subtitle: "New User",
        body: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "KUID"),
                enabled: !_autoGenerateUid,
                controller: _uidController,
              ),
              CheckboxListTile(
                dense: true,
                value: _autoGenerateUid,
                title: Text("Auto Generate kuid"),
                onChanged: (newvalue) {
                  setState(() {
                    _autoGenerateUid = newvalue;
                  });
                },
              ),
              ListTile(
                title: Text("Profiles"),
                onTap: _selectProfiles,
                subtitle: _profileIds.isEmpty
                    ? Text("No Profile Selected")
                    : Row(
                        children:
                            _profileIds.map((e) => Text(e + ",")).toList(),
                      ),
              )
            ],
          ),
        ),
      );
}
