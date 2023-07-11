import 'package:chattyevent_app_flutter/infastructure/dto/private_event/create_private_event_permissions_dto.dart';

class UpdatePrivateEventPermissionsDto
    extends CreatePrivateEventPermissionsDto {
  UpdatePrivateEventPermissionsDto({
    super.addUsers,
    super.changeDescription,
    super.changeAddress,
    super.addShoppingListItem,
    super.changeTitle,
    super.changeCoverImage,
    super.changeDate,
    super.changeStatus,
    super.deleteShoppingListItem,
    super.updateShoppingListItem,
  });
}
