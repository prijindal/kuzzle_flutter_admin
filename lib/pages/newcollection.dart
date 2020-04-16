import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kuzzleflutteradmin/components/loading.dart';
import 'package:kuzzleflutteradmin/components/responsivepage.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/pages/collections.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/events.dart';
import 'package:kuzzleflutteradmin/redux/state.dart';

class NewCollectionPageRouteArguments {
  NewCollectionPageRouteArguments({@required this.index});
  final String index;
}

class NewCollectionPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) => NewCollectionPage(
        index: (ModalRoute.of(context).settings.arguments
                as NewCollectionPageRouteArguments)
            .index,
      );
}

class NewCollectionPage extends StatefulWidget {
  const NewCollectionPage({@required this.index});
  final String index;

  @override
  _NewCollectionPageState createState() => _NewCollectionPageState();
}

class _NewCollectionPageState extends State<NewCollectionPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _checkingAdded = false;

  void _addNewCollection() {
    StoreProvider.of<AppState>(context).dispatch(
      addKuzzleCollection(
        widget.index,
        KuzzleCollection(name: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, KuzzleIndex>(
        onInit: (store) {
          store.dispatch(InitAddKuzzleCollectionAction(widget.index));
        },
        onWillChange: (_, newValue) {
          if (newValue.addingState == KuzzleState.LOADED &&
              _checkingAdded == false) {
            setState(() {
              _checkingAdded = true;
            });
            Navigator.of(context).pushReplacementNamed(
              'collections',
              arguments: CollectionsPageRouteArguments(index: widget.index),
            );
          }
        },
        converter: (store) => store.state.kuzzleindexes.indexMap[widget.index],
        builder: (context, kuzzleindex) => ResponsiveScaffold(
          subtitle: '${widget.index}/Create a new collection',
          body: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    child: const Text('Create'),
                    onPressed: kuzzleindex.addingState == KuzzleState.LOADING
                        ? null
                        : _addNewCollection,
                  ),
                ),
                if (kuzzleindex.addingState == KuzzleState.LOADING)
                  const LoadingAnimation()
              ],
            ),
          ),
        ),
      );
}
