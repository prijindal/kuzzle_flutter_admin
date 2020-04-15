import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/profileaction.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class ProfileChooserDialog extends StatefulWidget {
  final List<String> profileIds;
  ProfileChooserDialog({
    @required this.profileIds,
  });
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  void _refreshData() {
    if (StoreProvider.of<AppState>(context)
                .state
                .kuzzlesecurity
                .profiles
                .loadingState ==
            KuzzleState.INIT ||
        StoreProvider.of<AppState>(context)
                .state
                .kuzzlesecurity
                .profiles
                .loadingState ==
            KuzzleState.LOADED) {
      StoreProvider.of<AppState>(context).dispatch(getKuzzleProfiles);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Select Profiles'),
        actions: [
          RaisedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          RaisedButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(_profileIds);
            },
          ),
        ],
        content: StoreConnector<AppState, List<KuzzleSecurityProfile>>(
          converter: (store) => store.state.kuzzlesecurity.profiles.profiles,
          builder: (context, profiles) => Container(
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
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
