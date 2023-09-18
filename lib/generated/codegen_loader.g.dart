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
  "general": {
    "changeText": "Change",
    "addText": "Add",
    "createText": "Create",
    "saveText": "Save",
    "continueText": "Continue",
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
    },
    "groupchatPermissionForm": {
      "changeTitle": "Change title",
      "changeDescription": "Change description",
      "changeProfileImage": "Change image",
      "createEventForGroupchat": "Create event for groupchat",
      "addUsers": "add user"
    },
    "userSearch": {
      "userSearchText": "User search:",
      "noUsersFoundText": "No users found"
    }
  },
  "homePage": {
    "pages": {
      "chatPage": {
        "title": "Chats",
        "noChatsText": "No chats"
      },
      "eventPage": {
        "title": "Events",
        "noEventsText": "No events"
      },
      "searchPage": {
        "title": "Discover"
      },
      "profilePage": {
        "title": "Profile"
      }
    }
  },
  "futureEventPage": {
    "title": "Future Events",
    "noFutureEventsText": "No Future Events"
  },
  "pastEventPage": {
    "title": "Past Events",
    "noPastEventsText": "No Past Events"
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
      "title": "Update location"
    },
    "updatePermissionPage": {
      "title": "Member permissions"
    }
  },
  "groupchatPage": {
    "addUserPage": {
      "title": "Add user to Groupchat"
    },
    "changeChatUsernamePage": {
      "title": "Change chat Username",
      "newChatUsername": "New chat username",
      "deleteChatName": "Delete chat Name"
    },
    "futurePrivateEventsPage": {
      "title": "Future private events",
      "noFuturePrivateEventsText": "No future private events for this groupchat"
    },
    "updatePermissionPage": {
      "title": "Member permissions"
    }
  },
  "introductionPages": {
    "permissionPages": {
      "general": {
        "requestPermissionText": "Request permission",
        "dontRequestPermissionText": "Don't request permission"
      },
      "microphonePage": {
        "text": "If you want to use the microphone for e.g. voice messages. Please press request"
      },
      "notificationPage": {
        "text": "If you want to receive notifications such as messages, you have been invited, etc.. Please press request"
      }
    },
    "featurePages": {
      "messagePage": {
        "title": "Messages",
        "receivedButNotReadText": "Received but not read",
        "receivedAndReadText": "Received and read"
      },
      "groupchatPage": {
        "text": "ChattyEvent is the ultimate solution for your party and event planning! Our innovative app is all about group interaction and makes it easy for you to communicate with your friends, family or colleagues. Whether you're organizing an epic party or just want to keep in closer touch, ChattyEvent is the ideal companion to bring all your contacts together in one central location.\n\nChattyEvent stands out for its effortless usability and has all the tools you need for smooth group communication and impeccable event planning. Don't wait any longer - try it out today and see for yourself the ease and efficiency of our app. Increase the potential of your party planning and event organization with ChattyEvent!\n\nHave fun with ChattyEvent!"
      },
      "privateEventPage": {
        "text": "ChattyEvent's special party planning feature allows you to set up events quickly and effortlessly, sharing all the details with ease. You can link the event to a group chat or plan it independently. This innovative feature ensures that everyone is invited and that all relevant details are visible at a glance.\n\nTo simplify event planning even further, we've even included a handy shopping list feature. This allows you to clearly define what each event participant should contribute. This prevents anything from being forgotten and allows you to coordinate all the details perfectly in advance."
      },
      "usersPage": {
        "text": "Likewise, ChattyEvent provides a sophisticated friendship system that allows you to specifically manage the powers of your friends. This means that you can specifically choose which friends you include in a group and how far-reaching their access should be. Individual permissions can be customized to your liking for each friend - ensuring a well-organized and protected group dynamic."
      }
    }
  },
  "newGroupchatPage": {
    "title": "New groupchat",
    "pages": {
      "permissionTab": {
        "title": "Member Permissions"
      },
      "selectUserTab": {
        "title": "Select Members"
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Description (optional)"
      },
      "deleteAfterEndDateSwitch": {
        "title": "Should the event be deleted automatically after the end"
      }
    }
  },
  "newPrivateEventPage": {
    "title": "New private event",
    "pages": {
      "typTab": {
        "title": "Typ"
      },
      "searchTab": {
        "title": "Search"
      },
      "dateTab": {
        "title": "Date"
      },
      "locationTab": {
        "title": "Location (optional)"
      },
      "permissionTab": {
        "title": "Member Permissions"
      },
      "selectUserTab": {
        "title": "Select Members"
      },
      "eventTypTab": {
        "privateGroupchatEvent": {
          "title": "Private groupchat event",
          "description": "Here you connect an event with a group chat. All users who are in the group chat are automatically invited. If a user leaves the chat or is kicked, this also happens in the event."
        },
        "normalPrivateEvent": {
          "title": "Normal private event",
          "description": "You can invite and uninvite users here independently from a chat"
        }
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Description (optional)"
      }
    }
  },
  "profilePage": {
    "userRelationsTabs": {
      "followRequestsTab": {
        "title": "Follow requests",
        "noFollowRequestsText": "No follow requests"
      },
      "followedTab": {
        "title": "Followed",
        "noFollowedText": "No followed"
      },
      "followerTab": {
        "title": "Followers",
        "noFollowersText": "No followers"
      }
    },
    "chatPage": {
      "otherUserNotFollowerInfoText": "The other user can't write you a message because he doesn't follow you, if you want to write with him, please check if he sent you a friend request. But the other user can read your message"
    }
  },
  "settingsPage": {
    "title": "Settings",
    "logout": "Logout",
    "themeModePage": {
      "title": "Theme Mode",
      "darkModeText": "Dark Mode",
      "darkModeAutomaticText": "Dark Mode automatic"
    },
    "privacyPage": {
      "title": "Privacy & Security",
      "personalDataTitle": "Personal Data",
      "howOthersInteractWithYouText": "How may others interact with you?",
      "calenderTileMessage": "Followers can see if you have time on an appointment",
      "updatePasswordPage": {
        "title": "Update password",
        "newPasswordText": "New password",
        "confirmNewPasswordText": "Confirm new password",
        "sendEmailText": "Can't re-verify? Send password reset email"
      },
      "updateEmailPage": {
        "title": "Update E-Mail",
        "currentEmailAddressText": "E-Mail address: {}",
        "newEmailAddressText": "New email",
        "confirmNewEmailAddressText": "Confirm new email"
      },
      "updateBirthdatePage": {
        "title": "Update Birthdate",
        "birthdateText": "Birthdate: {}"
      },
      "privateEventAddMePage": {
        "title": "Private event add permission"
      },
      "groupchatAddMePage": {
        "title": "Groupchat add permission"
      },
      "calendarWatchIHaveTimePage": {
        "title": "Calendar see permission"
      }
    },
    "infoPage": {
      "title": "Info & Privacy",
      "faqText": "FAQ",
      "privacyPolicyText": "Privacy policy",
      "termsOfUseText": "Terms of use",
      "imprintText": "Imprint",
      "rightOnDataAccessText": "Right on data access",
      "rightOnDeletionPage": {
        "title": "Right on deletion",
        "text": "When you click on the 'Delete data' button all your data will be deleted.",
        "followingDataWillBeDeletedText": "The following data cannot be deleted:",
        "deleteDataText": "Delete Data",
        "dialog": {
          "title": "Really delete all data",
          "message": "Do you really want to delete all your data"
        }
      }
    }
  },
  "shoppingListPage": {
    "title": "Shopping list",
    "noItemsNeededText": "No items that need to be bought"
  }
};
static const Map<String,dynamic> en = {
  "general": {
    "changeText": "Change",
    "addText": "Add",
    "createText": "Create",
    "saveText": "Save",
    "continueText": "Continue",
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
    },
    "groupchatPermissionForm": {
      "changeTitle": "Change title",
      "changeDescription": "Change description",
      "changeProfileImage": "Change image",
      "createEventForGroupchat": "Create event for groupchat",
      "addUsers": "add user"
    },
    "userSearch": {
      "userSearchText": "User search:",
      "noUsersFoundText": "No users found"
    }
  },
  "homePage": {
    "pages": {
      "chatPage": {
        "title": "Chats",
        "noChatsText": "No chats"
      },
      "eventPage": {
        "title": "Events",
        "noEventsText": "No events"
      },
      "searchPage": {
        "title": "Discover"
      },
      "profilePage": {
        "title": "Profile"
      }
    }
  },
  "futureEventPage": {
    "title": "Future Events",
    "noFutureEventsText": "No Future Events"
  },
  "pastEventPage": {
    "title": "Past Events",
    "noPastEventsText": "No Past Events"
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
      "title": "Update location"
    },
    "updatePermissionPage": {
      "title": "Member permissions"
    }
  },
  "groupchatPage": {
    "addUserPage": {
      "title": "Add user to Groupchat"
    },
    "changeChatUsernamePage": {
      "title": "Change chat Username",
      "newChatUsername": "New chat username",
      "deleteChatName": "Delete chat Name"
    },
    "futurePrivateEventsPage": {
      "title": "Future private events",
      "noFuturePrivateEventsText": "No future private events for this groupchat"
    },
    "updatePermissionPage": {
      "title": "Member permissions"
    }
  },
  "introductionPages": {
    "permissionPages": {
      "general": {
        "requestPermissionText": "Request permission",
        "dontRequestPermissionText": "Don't request permission"
      },
      "microphonePage": {
        "text": "If you want to use the microphone for e.g. voice messages. Please press request"
      },
      "notificationPage": {
        "text": "If you want to receive notifications such as messages, you have been invited, etc.. Please press request"
      }
    },
    "featurePages": {
      "messagePage": {
        "title": "Messages",
        "receivedButNotReadText": "Received but not read",
        "receivedAndReadText": "Received and read"
      },
      "groupchatPage": {
        "text": "ChattyEvent is the ultimate solution for your party and event planning! Our innovative app is all about group interaction and makes it easy for you to communicate with your friends, family or colleagues. Whether you're organizing an epic party or just want to keep in closer touch, ChattyEvent is the ideal companion to bring all your contacts together in one central location.\n\nChattyEvent stands out for its effortless usability and has all the tools you need for smooth group communication and impeccable event planning. Don't wait any longer - try it out today and see for yourself the ease and efficiency of our app. Increase the potential of your party planning and event organization with ChattyEvent!\n\nHave fun with ChattyEvent!"
      },
      "privateEventPage": {
        "text": "ChattyEvent's special party planning feature allows you to set up events quickly and effortlessly, sharing all the details with ease. You can link the event to a group chat or plan it independently. This innovative feature ensures that everyone is invited and that all relevant details are visible at a glance.\n\nTo simplify event planning even further, we've even included a handy shopping list feature. This allows you to clearly define what each event participant should contribute. This prevents anything from being forgotten and allows you to coordinate all the details perfectly in advance."
      },
      "usersPage": {
        "text": "Likewise, ChattyEvent provides a sophisticated friendship system that allows you to specifically manage the powers of your friends. This means that you can specifically choose which friends you include in a group and how far-reaching their access should be. Individual permissions can be customized to your liking for each friend - ensuring a well-organized and protected group dynamic."
      }
    }
  },
  "newGroupchatPage": {
    "title": "New groupchat",
    "pages": {
      "permissionTab": {
        "title": "Member Permissions"
      },
      "selectUserTab": {
        "title": "Select Members"
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Description (optional)"
      },
      "deleteAfterEndDateSwitch": {
        "title": "Should the event be deleted automatically after the end"
      }
    }
  },
  "newPrivateEventPage": {
    "title": "New private event",
    "pages": {
      "typTab": {
        "title": "Typ"
      },
      "searchTab": {
        "title": "Search"
      },
      "dateTab": {
        "title": "Date"
      },
      "locationTab": {
        "title": "Location (optional)"
      },
      "permissionTab": {
        "title": "Member Permissions"
      },
      "selectUserTab": {
        "title": "Select Members"
      },
      "eventTypTab": {
        "privateGroupchatEvent": {
          "title": "Private groupchat event",
          "description": "Here you connect an event with a group chat. All users who are in the group chat are automatically invited. If a user leaves the chat or is kicked, this also happens in the event."
        },
        "normalPrivateEvent": {
          "title": "Normal private event",
          "description": "You can invite and uninvite users here independently from a chat"
        }
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Description (optional)"
      }
    }
  },
  "profilePage": {
    "userRelationsTabs": {
      "followRequestsTab": {
        "title": "Follow requests",
        "noFollowRequestsText": "No follow requests"
      },
      "followedTab": {
        "title": "Followed",
        "noFollowedText": "No followed"
      },
      "followerTab": {
        "title": "Followers",
        "noFollowersText": "No followers"
      }
    },
    "chatPage": {
      "otherUserNotFollowerInfoText": "The other user can't write you a message because he doesn't follow you, if you want to write with him, please check if he sent you a friend request. But the other user can read your message"
    }
  },
  "settingsPage": {
    "title": "Settings",
    "logout": "Logout",
    "themeModePage": {
      "title": "Theme Mode",
      "darkModeText": "Dark Mode",
      "darkModeAutomaticText": "Dark Mode automatic"
    },
    "privacyPage": {
      "title": "Privacy & Security",
      "personalDataTitle": "Personal Data",
      "howOthersInteractWithYouText": "How may others interact with you?",
      "calenderTileMessage": "Followers can see if you have time on an appointment",
      "updatePasswordPage": {
        "title": "Update password",
        "newPasswordText": "New password",
        "confirmNewPasswordText": "Confirm new password",
        "sendEmailText": "Can't re-verify? Send password reset email"
      },
      "updateEmailPage": {
        "title": "Update E-Mail",
        "currentEmailAddressText": "E-Mail address: {}",
        "newEmailAddressText": "New email",
        "confirmNewEmailAddressText": "Confirm new email"
      },
      "updateBirthdatePage": {
        "title": "Update Birthdate",
        "birthdateText": "Birthdate: {}"
      },
      "privateEventAddMePage": {
        "title": "Private event add permission"
      },
      "groupchatAddMePage": {
        "title": "Groupchat add permission"
      },
      "calendarWatchIHaveTimePage": {
        "title": "Calendar see permission"
      }
    },
    "infoPage": {
      "title": "Info & Privacy",
      "faqText": "FAQ",
      "privacyPolicyText": "Privacy policy",
      "termsOfUseText": "Terms of use",
      "imprintText": "Imprint",
      "rightOnDataAccessText": "Right on data access",
      "rightOnDeletionPage": {
        "title": "Right on deletion",
        "text": "When you click on the 'Delete data' button all your data will be deleted.",
        "followingDataWillBeDeletedText": "The following data cannot be deleted:",
        "deleteDataText": "Delete Data",
        "dialog": {
          "title": "Really delete all data",
          "message": "Do you really want to delete all your data"
        }
      }
    }
  },
  "shoppingListPage": {
    "title": "Shopping list",
    "noItemsNeededText": "No items that need to be bought"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}
