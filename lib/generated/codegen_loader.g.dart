// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> de = {
  "chats": "Chats",
  "general": {
    "changeText": "Ändern",
    "addText": "Hinzufügen",
    "createText": "Erstellen",
    "locationForm": {
      "country": "Land",
      "city": "Stadt",
      "zip": "PLZ",
      "street": "Straße",
      "number": "Nr."
    },
    "eventPermissionForm": {
      "changeTitle": "Titel ändern",
      "changeDescription": "Beschreibung ändern",
      "changeCoverImage": "Bild ändern",
      "changeDate": "Datum ändern",
      "changeAddress": "Adresse ändern",
      "changeStatus": "Status ändern",
      "addUsers": "Mitglied hinzufügen",
      "addShoppingListItem": "Einkaufsliste hinzufügen",
      "updateShoppingListItem": "Einkaufsliste bearbeiten",
      "deleteShoppingListItem": "Einkaufsliste löschen"
    }
  },
  "eventPage": {
    "tabs": {
      "shoppingListTab": {
        "title": "Einkaufsliste"
      },
      "userListTab": {
        "title": "Mitglieder"
      }
    },
    "createShoppingListItemPage": {
      "title": "Neues Item"
    },
    "inviteUserPage": {
      "title": "Benutzer zum Event hinzufügen"
    },
    "updateLocationPage": {
      "title": "Ort aktualisieren"
    },
    "updatePermissionPage": {
      "title": "Mitgliederberechtigungen"
    }
  }
};
static const Map<String,dynamic> en = {
  "chats": "Chats",
  "general": {
    "changeText": "Change",
    "addText": "Add",
    "createText": "Create",
    "locationForm": {
      "country": "Country",
      "city": "City",
      "zip": "Zip",
      "street": "Street",
      "number": "Nr."
    },
    "eventPermissionForm": {
      "changeTitle": "Change title",
      "changeDescription": "Change description",
      "changeCoverImage": "Change image",
      "changeDate": "Change date",
      "changeAddress": "Change address",
      "changeStatus": "Change status",
      "addUsers": "add user",
      "addShoppingListItem": "add shopping-list-item",
      "updateShoppingListItem": "update shopping-list-item",
      "deleteShoppingListItem": "delete shopping-list-item"
    }
  },
  "eventPage": {
    "tabs": {
      "shoppingListTab": {
        "title": "Shopping List"
      },
      "userListTab": {
        "title": "Members"
      }
    },
    "createShoppingListItemPage": {
      "title": "New Item"
    },
    "inviteUserPage": {
      "title": "Add User to Event"
    },
    "updateLocationPage": {
      "title": "Update Location"
    },
    "updatePermissionPage": {
      "title": "Member Permissions"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}
