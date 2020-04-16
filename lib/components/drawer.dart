import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/animatedlistview.dart';
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
import 'package:redux/redux.dart';

class KuzzleDrawer extends StatelessWidget {
  void _chooseEnvironmentConfirm(Environment environment) {}

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              Container(
                height: 64,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: 48,
                  ),
                ),
              ),
              const ListTile(
                dense: true,
                title: Text('Data'),
              ),
              StoreConnector<AppState, List<String>>(
                onInit: (store) {
                  if (store.state.kuzzleindexes.loadingState ==
                      KuzzleState.INIT) {
                    store.dispatch(getKuzzleIndexes);
                  }
                },
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
                  icon: const Icon(Icons.dns),
                  buildChild: (index) => _IndexExpansionTile(
                    index: index,
                  ),
                ),
              ),
              const ListTile(
                dense: true,
                title: Text('Security'),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Users'),
                onTap: () {
                  Navigator.of(context).pushNamed('users');
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Profiles'),
                onTap: () {
                  Navigator.of(context).pushNamed('profiles');
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock_open),
                title: const Text('Roles'),
                onTap: () {
                  Navigator.of(context).pushNamed('roles');
                },
              ),
              const ListTile(
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
                    builder: (context) => const EnvironmentsPage(),
                  ),
                  items: environments.environments.values.toList(),
                  title: 'Environments',
                  icon: const Icon(Icons.kitchen),
                  buildChild: (environment) => ListTile(
                    dense: true,
                    enabled:
                        environment.name != environments.defaultEnvironment,
                    leading: const Icon(
                      Icons.list,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, maxHeight: 40),
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
        ),
      );
}

class _IndexExpansionTile extends StatelessWidget {
  const _IndexExpansionTile({@required this.index});
  final String index;

  void _goToCollectionPage(KuzzleCollection collection, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionsPage(
          index: index,
        ),
      ),
    );
  }

  KuzzleCollection get _selectedCollection => null;

  void _onValueChange(bool newvalue, Store<AppState> store) {
    if (newvalue == true &&
        store.state.kuzzleindexes.indexMap[index].loadingState ==
            KuzzleState.INIT) {
      store.dispatch(getKuzzleCollections(index));
    }
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, List<KuzzleCollection>>(
        converter: (store) =>
            store.state.kuzzleindexes.indexMap[index].collections,
        builder: (context, collections) => BaseExpansionTile<KuzzleCollection>(
          icon: const Icon(Icons.dns),
          title: index,
          onValueChange: (newvalue) =>
              _onValueChange(newvalue, StoreProvider.of(context)),
          addRoute: MaterialPageRoute(
            builder: (context) => NewCollectionPage(
              index: index,
            ),
          ),
          manageRoute: MaterialPageRoute(
            builder: (context) => CollectionsPage(
              index: index,
            ),
          ),
          items: collections,
          buildChild: (collection) => ListTile(
            dense: true,
            enabled: _selectedCollection == null ||
                _selectedCollection != collection,
            selected: _selectedCollection != null &&
                _selectedCollection == collection,
            leading: const Icon(
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
            onTap: () => _goToCollectionPage(collection, context),
          ),
        ),
      );
}
