import 'package:flutter/material.dart';
import 'package:kuzzleflutteradmin/components/profileschooser.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final _uidController = TextEditingController();
  bool _autoGenerateUid = false;
  List<String> _profileIds = <String>[];

  Future<void> _selectProfiles() async {
    final profileIds = await showDialog<List<String>>(
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
        subtitle: 'New User',
        body: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'KUID'),
                enabled: !_autoGenerateUid,
                controller: _uidController,
              ),
              CheckboxListTile(
                dense: true,
                value: _autoGenerateUid,
                title: const Text('Auto Generate kuid'),
                onChanged: (newvalue) {
                  setState(() {
                    _autoGenerateUid = newvalue;
                  });
                },
              ),
              ListTile(
                title: const Text('Profiles'),
                onTap: _selectProfiles,
                subtitle: _profileIds.isEmpty
                    ? const Text('No Profile Selected')
                    : Row(
                        children: _profileIds.map((e) => Text('$e,')).toList(),
                      ),
              )
            ],
          ),
        ),
      );
}
