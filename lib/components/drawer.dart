import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/expansiontile.dart';
import 'package:kuzzleflutteradmin/models/environment.dart';
import 'package:kuzzleflutteradmin/models/environments.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/addenvironment.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/pages/environments.dart';
import 'package:kuzzleflutteradmin/pages/indexes.dart';
import 'package:kuzzleflutteradmin/pages/newcollection.dart';
import 'package:kuzzleflutteradmin/pages/newindex.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class KuzzleDrawer extends StatefulWidget {
  _KuzzleDrawerState createState() => _KuzzleDrawerState();
}

class _KuzzleDrawerState extends State<KuzzleDrawer> {
  void _chooseEnvironmentConfirm(Environment environment) {}
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getData());
    super.initState();
  }

  void _getData() {
    if (StoreProvider.of<AppState>(context).state.kuzzleindexes.loadingState ==
        KuzzleState.INIT) {
      StoreProvider.of<AppState>(context).dispatch(getKuzzleIndexes);
    }
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            Container(
              height: 64.0,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 48.0,
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text('Data'),
            ),
            StoreConnector<AppState, List<String>>(
              converter: (store) => store.state.kuzzleindexes.getIndexes(),
              builder: (context, indexes) => BaseExpansionTile<String>(
                addRoute: MaterialPageRoute(
                  builder: (context) => NewIndexPage(),
                ),
                manageRoute: MaterialPageRoute(
                  builder: (context) => IndexesPage(),
                ),
                items: indexes,
                title: 'Indexes',
                icon: Icon(Icons.dns),
                buildChild: (index) => _IndexExpansionTile(
                  index: index,
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text('Security'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Users'),
              onTap: () {
                Navigator.of(context).pushNamed('users');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Profiles'),
              onTap: () {
                Navigator.of(context).pushNamed('profiles');
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text('Roles'),
              onTap: () {
                Navigator.of(context).pushNamed('roles');
              },
            ),
            ListTile(
              dense: true,
              title: Text('Settings'),
            ),
            StoreConnector<AppState, Environments>(
              converter: (store) => store.state.environments,
              builder: (context, environments) =>
                  BaseExpansionTile<Environment>(
                addRoute: MaterialPageRoute(
                  builder: (context) => AddEnvironmentPage(),
                ),
                manageRoute: MaterialPageRoute(
                  builder: (context) => EnvironmentsPage(),
                ),
                items: environments.environments.values.toList(),
                title: 'Environments',
                icon: Icon(Icons.kitchen),
                buildChild: (environment) => ListTile(
                  dense: true,
                  enabled: environment.name !=
                      StoreProvider.of<AppState>(context)
                          .state
                          .environments
                          .defaultEnvironment,
                  leading: Icon(
                    Icons.list,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints:
                            const BoxConstraints(maxWidth: 200, maxHeight: 40),
                        child: Text(environment.name),
                      ),
                    ],
                  ),
                  onTap: () => _chooseEnvironmentConfirm(environment),
                ),
              ),
            ),
          ],
        ),
      );
}

class _IndexExpansionTile extends StatefulWidget {
  final String index;

  _IndexExpansionTile({@required this.index});

  _IndexExpansionTileState createState() => _IndexExpansionTileState();
}

class _IndexExpansionTileState extends State<_IndexExpansionTile> {
  void _goToCollectionPage(KuzzleCollection collection) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionsPage(
          index: widget.index,
        ),
      ),
    );
  }

  KuzzleCollection get _selectedCollection {
    return null;
  }

  void _onValueChange(bool newvalue) {
    if (newvalue == true &&
        StoreProvider.of<AppState>(context)
                .state
                .kuzzleindexes
                .indexMap[widget.index]
                .loadingState ==
            KuzzleState.INIT) {
      StoreProvider.of<AppState>(context)
          .dispatch(getKuzzleCollections(widget.index));
    }
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, List<KuzzleCollection>>(
        converter: (store) =>
            store.state.kuzzleindexes.indexMap[widget.index].collections,
        builder: (context, collections) => BaseExpansionTile<KuzzleCollection>(
          icon: Icon(Icons.dns),
          title: widget.index,
          onValueChange: _onValueChange,
          addRoute: MaterialPageRoute(
            builder: (context) => NewCollectionPage(
              index: widget.index,
            ),
          ),
          manageRoute: MaterialPageRoute(
            builder: (context) => CollectionsPage(
              index: widget.index,
            ),
          ),
          items: collections,
          buildChild: (collection) => ListTile(
            dense: true,
            enabled: _selectedCollection == null ||
                _selectedCollection != collection,
            selected: _selectedCollection != null &&
                _selectedCollection == collection,
            leading: Icon(
              Icons.list,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 200, maxHeight: 40),
                  child: Text(collection.name),
                ),
              ],
            ),
            onTap: () => _goToCollectionPage(collection),
          ),
        ),
      );
}
