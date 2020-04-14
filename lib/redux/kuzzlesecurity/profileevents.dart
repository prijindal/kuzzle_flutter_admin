import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/abstractevent.dart';

/* Profiles */
/* Get all */
class GetKuzzleProfilesAction extends KuzzleSecurityAction {}

class GetSuccessKuzzleProfilesAction extends KuzzleSecurityAction {
  final List<KuzzleSecurityProfile> profiles;
  GetSuccessKuzzleProfilesAction(this.profiles);
}

class GetErroredKuzzleProfilesAction extends KuzzleSecurityAction {
  final String errorMessage;
  GetErroredKuzzleProfilesAction(this.errorMessage);
}

/* Get one */
class GetKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  GetKuzzleProfileAction(this.uid);
}

class GetSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityProfile profile;
  GetSuccessKuzzleProfileAction(this.uid, this.profile);
}

class GetErroredKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  GetErroredKuzzleProfileAction(this.uid, this.errorMessage);
}

/* Add */
class AddKuzzleProfileAction extends KuzzleSecurityAction {
  final KuzzleSecurityProfile profile;
  AddKuzzleProfileAction(this.profile);
}

class AddSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  final KuzzleSecurityProfile profile;
  AddSuccessKuzzleProfileAction(this.profile);
}

class AddErroredKuzzleProfileAction extends KuzzleSecurityAction {
  final KuzzleSecurityProfile profile;
  final String errorMessage;
  AddErroredKuzzleProfileAction(this.profile, this.errorMessage);
}

/* Edit */
class SaveKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityProfile profile;
  SaveKuzzleProfileAction(this.uid, this.profile);
}

class SaveSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final KuzzleSecurityProfile profile;
  SaveSuccessKuzzleProfileAction(this.uid, this.profile);
}

class SaveErroredKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  SaveErroredKuzzleProfileAction(this.uid, this.errorMessage);
}

/* Delete */
class DeleteKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  DeleteKuzzleProfileAction(this.uid);
}

class DeleteSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  DeleteSuccessKuzzleProfileAction(this.uid);
}

class DeleteErroredKuzzleProfileAction extends KuzzleSecurityAction {
  final String uid;
  final String errorMessage;
  DeleteErroredKuzzleProfileAction(this.uid, this.errorMessage);
}
