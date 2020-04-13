import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/abstractevent.dart';

/* Users */
/* Get all */
class GetKuzzleUsersAction extends KuzzleSecurityAction {}

class GetSuccessKuzzleUsersAction extends KuzzleSecurityAction {
  final List<KuzzleSecurityUser> users;
  GetSuccessKuzzleUsersAction(this.users);
}

class GetErroredKuzzleUsersAction extends KuzzleSecurityAction {
  final String errorMessage;
  GetErroredKuzzleUsersAction(this.errorMessage);
}

/* Get one */
class GetKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  GetKuzzleUserAction(this.uid);
}

class GetSuccessKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityUser user;
  GetSuccessKuzzleUserAction(this.uid, this.user);
}

class GetErroredKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  GetErroredKuzzleUserAction(this.uid, this.errorMessage);
}

/* Add */
class AddKuzzleUserAction extends KuzzleSecurityAction {
  final KuzzleSecurityUser user;
  AddKuzzleUserAction(this.user);
}

class AddSuccessKuzzleUserAction extends KuzzleSecurityAction {
  final KuzzleSecurityUser user;
  AddSuccessKuzzleUserAction(this.user);
}

class AddErroredKuzzleUserAction extends KuzzleSecurityAction {
  final KuzzleSecurityUser user;
  final String errorMessage;
  AddErroredKuzzleUserAction(this.user, this.errorMessage);
}

/* Edit */
class SaveKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityUser user;
  SaveKuzzleUserAction(this.uid, this.user);
}

class SaveSuccessKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityUser user;
  SaveSuccessKuzzleUserAction(this.uid, this.user);
}

class SaveErroredKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  SaveErroredKuzzleUserAction(this.uid, this.errorMessage);
}

/* Delete */
class DeleteKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  DeleteKuzzleUserAction(this.uid);
}

class DeleteSuccessKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  DeleteSuccessKuzzleUserAction(this.uid);
}

class DeleteErroredKuzzleUserAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  DeleteErroredKuzzleUserAction(this.uid, this.errorMessage);
}
