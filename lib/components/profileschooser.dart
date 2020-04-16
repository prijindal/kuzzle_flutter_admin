import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/profileaction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class ProfileChooserDialog extends StatefulWidget {
  const ProfileChooserDialog({
    @required this.profileIds,
  });
  final List<String> profileIds;

  @override
  _ProfileChooserDialogState createState() => _ProfileChooserDialogState();
}

class _ProfileChooserDialogState extends State<ProfileChooserDialog> {
  List<String> _profileIds = <String>[];

  @override
  void initState() {
    setState(() {
      _profileIds = widget.profileIds;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Select Profiles'),
        actions: [
          RaisedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          RaisedButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(_profileIds);
            },
          ),
        ],
        content: StoreConnector<AppState, List<KuzzleSecurityProfile>>(
          onInit: (store) {
            if (store.state.kuzzlesecurity.profiles.loadingState ==
                    KuzzleState.INIT ||
                store.state.kuzzlesecurity.profiles.loadingState ==
                    KuzzleState.LOADED) {
              store.dispatch(getKuzzleProfiles);
            }
          },
          converter: (store) => store.state.kuzzlesecurity.profiles.profiles,
          builder: (context, profiles) => Container(
            height: 300, // Change as per your requirement
            width: 300, // Change as per your requirement
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: profiles
                  .map(
                    (profile) => CheckboxListTile(
                      value: _profileIds.contains(profile.uid),
                      title: Text(profile.uid),
                      onChanged: (newvalue) {
                        if (newvalue == true) {
                          setState(() {
                            _profileIds.add(profile.uid);
                          });
                        } else {
                          setState(() {
                            _profileIds.remove(profile.uid);
                          });
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
