import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/abstractevent.dart';

/* Users */
/* Get all */
class GetKuzzleUsersAction extends KuzzleSecurityAction {}

class GetSuccessKuzzleUsersAction extends KuzzleSecurityAction {
  GetSuccessKuzzleUsersAction(this.users);
  final List<KuzzleSecurityUser> users;
}

class GetErroredKuzzleUsersAction extends KuzzleSecurityAction {
  GetErroredKuzzleUsersAction(this.errorMessage);
  final String errorMessage;
}

/* Get one */
class GetKuzzleUserAction extends KuzzleSecurityAction {
  GetKuzzleUserAction(this.uid);
  final String uid;
}

class GetSuccessKuzzleUserAction extends KuzzleSecurityAction {
  GetSuccessKuzzleUserAction(this.uid, this.user);
  final String uid;
  final KuzzleSecurityUser user;
}

class GetErroredKuzzleUserAction extends KuzzleSecurityAction {
  GetErroredKuzzleUserAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}

/* Add */
class AddKuzzleUserAction extends KuzzleSecurityAction {
  AddKuzzleUserAction(this.user);
  final KuzzleSecurityUser user;
}

class AddSuccessKuzzleUserAction extends KuzzleSecurityAction {
  AddSuccessKuzzleUserAction(this.user);
  final KuzzleSecurityUser user;
}

class AddErroredKuzzleUserAction extends KuzzleSecurityAction {
  AddErroredKuzzleUserAction(this.user, this.errorMessage);
  final KuzzleSecurityUser user;
  final String errorMessage;
}

/* Edit */
class SaveKuzzleUserAction extends KuzzleSecurityAction {
  SaveKuzzleUserAction(this.uid, this.user);
  final String uid;
  final KuzzleSecurityUser user;
}

class SaveSuccessKuzzleUserAction extends KuzzleSecurityAction {
  SaveSuccessKuzzleUserAction(this.uid, this.user);
  final String uid;
  final KuzzleSecurityUser user;
}

class SaveErroredKuzzleUserAction extends KuzzleSecurityAction {
  SaveErroredKuzzleUserAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}

/* Delete */
class DeleteKuzzleUserAction extends KuzzleSecurityAction {
  DeleteKuzzleUserAction(this.uid);
  final String uid;
}

class DeleteSuccessKuzzleUserAction extends KuzzleSecurityAction {
  DeleteSuccessKuzzleUserAction(this.uid);
  final String uid;
}

class DeleteErroredKuzzleUserAction extends KuzzleSecurityAction {
  DeleteErroredKuzzleUserAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}
