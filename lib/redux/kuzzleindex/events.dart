import 'package:kuzzleflutteradmin/models/kuzzleindexes.dart';

abstract class KuzzleIndexAction {}

class ResetKuzzleIndexAction extends KuzzleIndexAction {}

class GetKuzzleIndexesAction extends KuzzleIndexAction {}

class GetSuccessKuzzleIndexesAction extends KuzzleIndexAction {
  GetSuccessKuzzleIndexesAction(this.indexes);
  final List<String> indexes;
}

class GetErroredKuzzleIndexesAction extends KuzzleIndexAction {
  GetErroredKuzzleIndexesAction(this.errorMessage);
  final String errorMessage;
}

class AddKuzzleIndexAction extends KuzzleIndexAction {
  AddKuzzleIndexAction(this.index);
  final String index;
}

class AddSuccessKuzzleIndexAction extends KuzzleIndexAction {
  AddSuccessKuzzleIndexAction(this.index);
  final String index;
}

class AddErroredKuzzleIndexAction extends KuzzleIndexAction {
  AddErroredKuzzleIndexAction(this.index, this.errorMessage);
  final String index;
  final String errorMessage;
}

class DeleteKuzzleIndexAction extends KuzzleIndexAction {
  DeleteKuzzleIndexAction(this.index);
  final String index;
}

class DeleteSuccessKuzzleIndexAction extends KuzzleIndexAction {
  DeleteSuccessKuzzleIndexAction(this.index);
  final String index;
}

class DeleteErroredKuzzleIndexAction extends KuzzleIndexAction {
  DeleteErroredKuzzleIndexAction(this.index, this.errorMessage);
  final String index;
  final String errorMessage;
}

/* Collection indexes */
class GetKuzzleCollectionsAction extends KuzzleIndexAction {
  GetKuzzleCollectionsAction(this.index);
  final String index;
}

class GetSuccessKuzzleCollectionsAction extends KuzzleIndexAction {
  GetSuccessKuzzleCollectionsAction(this.index, this.collections);
  final String index;
  final List<KuzzleCollection> collections;
}

class GetErroredKuzzleCollectionsAction extends KuzzleIndexAction {
  GetErroredKuzzleCollectionsAction(this.index, this.errorMessage);
  final String index;
  final String errorMessage;
}

class AddKuzzleCollectionAction extends KuzzleIndexAction {
  AddKuzzleCollectionAction(this.index, this.collection);
  final String index;
  final KuzzleCollection collection;
}

class AddSuccessKuzzleCollectionAction extends KuzzleIndexAction {
  AddSuccessKuzzleCollectionAction(this.index, this.collection);
  final String index;
  final KuzzleCollection collection;
}

class AddErroredKuzzleCollectionAction extends KuzzleIndexAction {
  AddErroredKuzzleCollectionAction(
    this.index,
    this.collection,
    this.errorMessage,
  );
  final String index;
  final KuzzleCollection collection;
  final String errorMessage;
}

class DeleteKuzzleCollectionAction extends KuzzleIndexAction {
  DeleteKuzzleCollectionAction(this.index, this.collectionName);
  final String index;
  final String collectionName;
}

class DeleteSuccessKuzzleCollectionAction extends KuzzleIndexAction {
  DeleteSuccessKuzzleCollectionAction(this.index, this.collectionName);
  final String index;
  final String collectionName;
}

class DeleteErroredKuzzleCollectionAction extends KuzzleIndexAction {
  DeleteErroredKuzzleCollectionAction(
    this.index,
    this.collectionName,
    this.errorMessage,
  );
  final String index;
  final String collectionName;
  final String errorMessage;
}
