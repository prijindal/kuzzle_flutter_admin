import 'state.dart';

abstract class KuzzleIndexAction {}

class ResetKuzzleIndexAction extends KuzzleIndexAction {}

class GetKuzzleIndexesAction extends KuzzleIndexAction {}

class GetSuccessKuzzleIndexesAction extends KuzzleIndexAction {
  final List<String> indexes;
  GetSuccessKuzzleIndexesAction(this.indexes);
}

class GetErroredKuzzleIndexesAction extends KuzzleIndexAction {
  final String errorMessage;
  GetErroredKuzzleIndexesAction(this.errorMessage);
}

class AddKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  AddKuzzleIndexAction(this.index);
}

class AddSuccessKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  AddSuccessKuzzleIndexAction(this.index);
}

class AddErroredKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  final String errorMessage;
  AddErroredKuzzleIndexAction(this.index, this.errorMessage);
}

class DeleteKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  DeleteKuzzleIndexAction(this.index);
}

class DeleteSuccessKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  DeleteSuccessKuzzleIndexAction(this.index);
}

class DeleteErroredKuzzleIndexAction extends KuzzleIndexAction {
  final String index;
  final String errorMessage;
  DeleteErroredKuzzleIndexAction(this.index, this.errorMessage);
}

/* Collection indexes */
class GetKuzzleCollectionsAction extends KuzzleIndexAction {
  final String index;
  GetKuzzleCollectionsAction(this.index);
}

class GetSuccessKuzzleCollectionsAction extends KuzzleIndexAction {
  final String index;
  final List<KuzzleCollection> collections;
  GetSuccessKuzzleCollectionsAction(this.index, this.collections);
}

class GetErroredKuzzleCollectionsAction extends KuzzleIndexAction {
  final String index;
  final String errorMessage;
  GetErroredKuzzleCollectionsAction(this.index, this.errorMessage);
}

class AddKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final KuzzleCollection collection;
  AddKuzzleCollectionAction(this.index, this.collection);
}

class AddSuccessKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final KuzzleCollection collection;
  AddSuccessKuzzleCollectionAction(this.index, this.collection);
}

class AddErroredKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final KuzzleCollection collection;
  final String errorMessage;
  AddErroredKuzzleCollectionAction(
    this.index,
    this.collection,
    this.errorMessage,
  );
}

class DeleteKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final String collectionName;
  DeleteKuzzleCollectionAction(this.index, this.collectionName);
}

class DeleteSuccessKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final String collectionName;
  DeleteSuccessKuzzleCollectionAction(this.index, this.collectionName);
}

class DeleteErroredKuzzleCollectionAction extends KuzzleIndexAction {
  final String index;
  final String collectionName;
  final String errorMessage;
  DeleteErroredKuzzleCollectionAction(
    this.index,
    this.collectionName,
    this.errorMessage,
  );
}
