import 'package:kuzzleflutteradmin/models/kuzzlesecurity.dart';
import 'package:kuzzleflutteradmin/redux/kuzzlesecurity/abstractevent.dart';

/* Profiles */
/* Get all */
class GetKuzzleProfilesAction extends KuzzleSecurityAction {}

class GetSuccessKuzzleProfilesAction extends KuzzleSecurityAction {
  GetSuccessKuzzleProfilesAction(this.profiles);
  final List<KuzzleSecurityProfile> profiles;
}

class GetErroredKuzzleProfilesAction extends KuzzleSecurityAction {
  GetErroredKuzzleProfilesAction(this.errorMessage);
  final String errorMessage;
}

/* Get one */
class GetKuzzleProfileAction extends KuzzleSecurityAction {
  GetKuzzleProfileAction(this.uid);
  final String uid;
}

class GetSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  GetSuccessKuzzleProfileAction(this.uid, this.profile);
  final String uid;
  final KuzzleSecurityProfile profile;
}

class GetErroredKuzzleProfileAction extends KuzzleSecurityAction {
  GetErroredKuzzleProfileAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}

/* Add */
class AddKuzzleProfileAction extends KuzzleSecurityAction {
  AddKuzzleProfileAction(this.profile);
  final KuzzleSecurityProfile profile;
}

class AddSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  AddSuccessKuzzleProfileAction(this.profile);
  final KuzzleSecurityProfile profile;
}

class AddErroredKuzzleProfileAction extends KuzzleSecurityAction {
  AddErroredKuzzleProfileAction(this.profile, this.errorMessage);
  final KuzzleSecurityProfile profile;
  final String errorMessage;
}

/* Edit */
class SaveKuzzleProfileAction extends KuzzleSecurityAction {
  SaveKuzzleProfileAction(this.uid, this.profile);
  final String uid;
  final KuzzleSecurityProfile profile;
}

class SaveSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  SaveSuccessKuzzleProfileAction(this.uid, this.profile);
  final String uid;
  final KuzzleSecurityProfile profile;
}

class SaveErroredKuzzleProfileAction extends KuzzleSecurityAction {
  SaveErroredKuzzleProfileAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}

/* Delete */
class DeleteKuzzleProfileAction extends KuzzleSecurityAction {
  DeleteKuzzleProfileAction(this.uid);
  final String uid;
}

class DeleteSuccessKuzzleProfileAction extends KuzzleSecurityAction {
  DeleteSuccessKuzzleProfileAction(this.uid);
  final String uid;
}

class DeleteErroredKuzzleProfileAction extends KuzzleSecurityAction {
  DeleteErroredKuzzleProfileAction(this.uid, this.errorMessage);
  final String uid;
  final String errorMessage;
}
