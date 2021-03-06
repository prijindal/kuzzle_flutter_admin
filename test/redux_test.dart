// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';

import 'package:kuzzle/kuzzle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';
import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/models/kuzzlestate.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzleindex/actions.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/reducer.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/useraction.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:kuzzleflutteradmin/helpers/kuzzle.dart';
// import 'package:kuzzleflutteradmin/redux/index.dart';

void main() {
  FlutterKuzzle.instance = FlutterKuzzle(
    WebSocketProtocol('localhost'),
  );
  FlutterKuzzle.instance.on('disconnect', () {
    exit(0);
  });
  test('Test Security Redux', testSecurity,
      timeout: const Timeout(Duration(minutes: 2)));
  test('Test Indexes Redux', testIndexes,
      timeout: const Timeout(Duration(minutes: 2)));
}

Future<void> testSecurity() async {
  final store = Store<KuzzleSecurity>(
    kuzzleSecurityReducer,
    middleware: [
      thunkMiddleware,
      LoggingMiddleware.printer(),
    ],
    initialState: const KuzzleSecurity(),
  );
  await FlutterKuzzle.instance.connect();
  store.dispatch(getKuzzleUsers);
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    if (store.state.users.loadingState == KuzzleState.LOADED) {
      timer.cancel();
      if (store.state.users.users.isNotEmpty) {
        store.dispatch(getKuzzleUser(store.state.users.users[0].uid));
        Timer.periodic(const Duration(milliseconds: 10), (timer) {
          if (store.state.users.users[0].loadingState == KuzzleState.LOADED) {
            timer.cancel();
            final credentials = {
              'local': {
                'username": "test',
                'password": "test',
              },
            };
            store.dispatch(
              addKuzzleUser(
                KuzzleSecurityUser(
                  uid: null,
                  content: const <String, dynamic>{
                    'profileIds': ['admin'],
                    'name': 'test',
                  },
                ),
                credentials,
              ),
            );
            Timer.periodic(const Duration(milliseconds: 10), (timer) {
              if (store.state.users.addingState == KuzzleState.LOADED) {
                timer.cancel();
                final user = store.state.users.users.last.copyWith(
                  content: const <String, dynamic>{
                    'name': 'Edited name',
                  },
                );
                store.dispatch(editKuzzleUser(user));
                Timer.periodic(const Duration(milliseconds: 10), (timer) {
                  if (store.state.users.users.last.savingState ==
                      KuzzleState.LOADED) {
                    timer.cancel();
                    store.dispatch(
                        deleteKuzzleUser(store.state.users.users.last.uid));
                    Timer.periodic(const Duration(milliseconds: 10), (timer) {
                      if (store.state.users.deletingState ==
                          KuzzleState.LOADED) {
                        timer.cancel();
                      }
                    });
                  }
                });
              }
            });
          }
        });
      }
    }
  });
}

Future<void> testIndexes() async {
  final store = Store<KuzzleIndexes>(
    kuzzleReducer,
    middleware: [
      thunkMiddleware,
      LoggingMiddleware.printer(),
    ],
    initialState: const KuzzleIndexes(),
  );
  await FlutterKuzzle.instance.connect();
  store.dispatch(getKuzzleIndexes);
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    if (store.state.loadingState == KuzzleState.LOADED) {
      const index = 'testindexname';
      const collectionName = 'comments';
      store.dispatch(addKuzzleIndex(index));
      timer.cancel();
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (store.state.addingState == KuzzleState.LOADED) {
          // var index = store.state.getIndexes()[0];
          store.dispatch(getKuzzleCollections(index));
          timer.cancel();
          Timer.periodic(const Duration(milliseconds: 10), (timer) {
            if (store.state.indexMap[index].loadingState ==
                KuzzleState.LOADED) {
              store.dispatch(
                addKuzzleCollection(
                  index,
                  const KuzzleCollection(name: collectionName, type: 'stored'),
                ),
              );
              timer.cancel();
              Timer.periodic(const Duration(milliseconds: 10), (timer) {
                if (store.state.indexMap[index].addingState ==
                    KuzzleState.LOADED) {
                  store.dispatch(
                    deleteKuzzleCollection(index, collectionName),
                  );
                  timer.cancel();
                  Timer.periodic(const Duration(milliseconds: 10), (timer) {
                    if (store.state.indexMap[index].deletingState ==
                        KuzzleState.LOADED) {
                      store.dispatch(deleteKuzzleIndex(index));
                      timer.cancel();
                      Timer.periodic(const Duration(milliseconds: 10), (timer) {
                        if (store.state.deletingState == KuzzleState.LOADED) {
                          FlutterKuzzle.instance.disconnect();
                          timer.cancel();
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        }
      });
    }
  });
}
