import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_permissions_dto.dart';

class UpdateEventPermissionsDto extends CreateEventPermissionsDto {
  UpdateEventPermissionsDto({
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
