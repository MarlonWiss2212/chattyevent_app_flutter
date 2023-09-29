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
    "changeText": "Ändern",
    "addText": "Hinzufügen",
    "createText": "Erstellen",
    "saveText": "Speichern",
    "continueText": "Weiter",
    "noText": "Nein",
    "yesText": "Ja",
    "okText": "Ok",
    "reloadText": "Neu laden",
    "loadMoreText": "Mehr laden",
    "loadMembersText": "Mitglieder laden",
    "everyoneText": "Jeder",
    "noInfoText": "Keine Informationen",
    "deleteText": "Löschen",
    "acceptText": "Akzeptieren",
    "rejectText": "Ablehnen",
    "defaultDataText": "Standarddaten",
    "openInMapsText": "In Karten öffnen",
    "kickText": "Rauswerfen",
    "chatText": "Chat",
    "removeText": "Entfernen",
    "errorText": "Fehler",
    "noDescriptionText": "Keine Beschreibung",
    "memberPermissionText": "Mitgliedsberechtigungen",
    "birthdateText": "Geburtsdatum: {}",
    "showAllText": "Alle anzeigen",
    "shoppingList": {
      "title": "Einkaufsliste"
    },
    "notificationAlert": {
      "deleteImageText": "Bild löschen",
      "saveImageText": "Bild speichern",
      "internetIsThereAlert": {
        "title": "Internetverbindung",
        "message": "Sie sind wieder mit dem Internet verbunden"
      },
      "noInternetIsThereAlert": {
        "title": "Keine Internetverbindung",
        "message": "Sie haben die Verbindung zum Internet verloren"
      }
    },
    "amountIsntANumberAlert": {
      "title": "Mengenfehler",
      "message": "Die eingegebene Menge muss eine Zahl sein"
    },
    "messageArea": {
      "noMessagesText": "Keine Nachrichten"
    },
    "groupchatPermissionMenu": {
      "onlyAdminsText": "Nur Admins"
    },
    "request": {
      "invitationEventText": "Der Benutzer {} hat Ihnen eine Einladung zum Event {} für das folgende Datum gesendet: {}",
      "invitationGroupchatText": "Der Benutzer {} hat Ihnen eine Einladung zum Gruppenchat {} gesendet"
    },
    "eventPermissionMenu": {
      "creatorOnlyText": "Nur Ersteller",
      "organizerOnlyText": "Nur Organisatoren"
    },
    "followButton": {
      "followText": "Folgen",
      "followedText": "Gefolgt",
      "requestedText": "Angefragt",
      "blockText": "Blockieren",
      "blockedText": "Blockiert",
      "takeBackRequest": "Anfrage zurückziehen",
      "dontBlockAnymoreText": "Nicht mehr blockieren",
      "dontFollowAnymoreText": "Nicht mehr folgen"
    },
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
      "addUsers": "Benutzer hinzufügen",
      "addShoppingListItem": "Einkaufslistenpunkt hinzufügen",
      "updateShoppingListItem": "Einkaufslistenpunkt aktualisieren",
      "deleteShoppingListItem": "Einkaufslistenpunkt löschen"
    },
    "groupchatPermissionForm": {
      "changeTitle": "Titel ändern",
      "changeDescription": "Beschreibung ändern",
      "changeProfileImage": "Bild ändern",
      "createEventForGroupchat": "Event für Gruppenchat erstellen",
      "addUsers": "Benutzer hinzufügen"
    },
    "userSearch": {
      "userSearchText": "Benutzersuche:",
      "noUsersFoundText": "Keine Benutzer gefunden"
    },
    "chatMessage": {
      "reactMessageContainer": {
        "filesText": "Dateien",
        "currentLocationText": "Aktueller Standort",
        "audioText": "Audio"
      },
      "readByContainer": {
        "title": "Gelesen von:",
        "emptyMessage": "Niemand hat die Nachricht gelesen"
      }
    },
    "chatMessageInput": {
      "textField": {
        "hintText": "Nachricht"
      },
      "voiceMessage": {
        "title": "Sprachnachricht"
      }
    },
    "dialog": {
      "cameraText": "Kamera",
      "galleryText": "Galerie",
      "removeImageText": "Bild entfernen",
      "yourLocationText": "Ihr Standort"
    }
  },
  "authPages": {
    "dataprotectionBox": {
      "text1": "Ich habe die ",
      "text2": " gelesen und stimme den ",
      "text3": " zu",
      "privacyPolicyText": "Datenschutzrichtlinien",
      "termsOfUseText": "Nutzungsbedingungen"
    }
  },
  "homePage": {
    "pages": {
      "chatPage": {
        "title": "Chats",
        "noChatsText": "Keine Chats"
      },
      "eventPage": {
        "title": "Events",
        "noEventsText": "Keine Events",
        "lastEvents": "Letzte Events",
        "nextEvents": "Kommende Events"
      },
      "mapPage": {
        "title": "Event Map"
      },
      "searchPage": {
        "title": "Entdecken"
      },
      "profilePage": {
        "title": "Profil"
      }
    }
  },
  "futureEventPage": {
    "title": "Kommende Events",
    "noFutureEventsText": "Keine kommenden Events"
  },
  "pastEventPage": {
    "title": "Vergangene Events",
    "noPastEventsText": "Keine vergangenen Events"
  },
  "eventPage": {
    "tabs": {
      "shoppingListTab": {
        "title": "Einkaufsliste"
      },
      "userListTab": {
        "title": "Mitglieder",
        "leftUserList": {
          "pastMembers": "Vergangene Mitglieder: {}"
        },
        "userList": {
          "addUserToEvent": "Benutzer zum Event hinzufügen",
          "membersThatWillBeThereCount": "Mitglieder, die dabei sein werden: {}",
          "changeChatUsernameText": "Chat-Benutzernamen ändern",
          "kickedText": "Rausgeworfen",
          "acceptedText": "Akzeptiert",
          "rejectedText": "Abgelehnt",
          "unknownText": "Unbekannt",
          "statusPlusOrganizerText": " | Organisator",
          "removeOrganizerStatus": "Organisatorenstatus entfernen",
          "makeOrganizer": "Zum Organisator machen"
        },
        "invitationList": {
          "errorToDisplayOneInvitationText": "Fehler beim Anzeigen eines eingeladenen Benutzers",
          "invitedByText": "Eingeladen von: {}",
          "deleteInvitationText": "Einladung löschen",
          "invitedUsersCount": "Eingeladene Benutzer: {}"
        },
        "leaveEventButton": {
          "leaveEventText": "Event verlassen",
          "leaveEventDescriptionText": "Möchten Sie das Event wirklich verlassen?"
        }
      },
      "infoTab": {
        "connectedGroupchatText": "Verbundener Gruppenchat",
        "addressButton": {
          "leftEmptyText": "Adresse: ",
          "rightEmptyText": "Adresse hinzufügen",
          "removeAddressDialog": {
            "title": "Adresse entfernen",
            "message": "Möchten Sie die Adresse wirklich entfernen?"
          }
        },
        "deleteButton": {
          "dialog": {
            "title": "Event löschen",
            "message": "Möchten Sie das Event wirklich löschen?"
          }
        },
        "coverImageButton": {
          "saveCoverImageDescription": "Möchten Sie das Bild als Titelbild für das Event verwenden?",
          "deleteCoverImageDescription": "Möchten Sie das Titelbild des Event wirklich löschen?"
        },
        "statusButton": {
          "leftText": "Status: ",
          "takesPlaceText": "Findet statt",
          "cancelledText": "Abgesagt",
          "undecidedText": "Unentschieden"
        },
        "eventDateText": "Datum: ",
        "eventEndDateText": "Enddatum: ",
        "memberPermissionsText": "Mitgliederberechtigungen"
      }
    },
    "createShoppingListItemPage": {
      "title": "Neuer Artikel",
      "fields": {
        "itemNameField": {
          "lable": "Artikelname"
        },
        "amountField": {
          "lable": "Menge"
        },
        "unitField": {
          "lable": "Einheit"
        }
      },
      "userWhoShouldBuyTheItemText": "Benutzer, der den Artikel kaufen soll: {}"
    },
    "inviteUserPage": {
      "title": "Benutzer zum Event hinzufügen"
    },
    "updateLocationPage": {
      "title": "Standort aktualisieren"
    },
    "updatePermissionPage": {
      "title": "Mitgliederberechtigungen aktualisieren"
    }
  },
  "groupchatPage": {
    "addUserPage": {
      "title": "Benutzer zum Gruppenchat hinzufügen"
    },
    "infoPage": {
      "invitationList": {
        "errorToDisplayOneInvitationText": "Fehler beim Anzeigen eines eingeladenen Benutzers",
        "invitedByText": "Eingeladen von: {}",
        "deleteInvitationText": "Einladung löschen",
        "invitedUsersCount": "Eingeladene Benutzer: {}"
      },
      "leftUserList": {
        "pastMembers": "Vergangene Mitglieder: {}"
      },
      "userList": {
        "addUserToGroupchat": "Benutzer zum Gruppenchat hinzufügen",
        "membersCount": "Mitglieder: {}",
        "changeChatUsernameText": "Chat-Benutzernamen ändern",
        "adminText": "Admin",
        "notAdminText": "Kein Admin",
        "makeAdmin": "Zum Admin machen",
        "degradeAdmin": "Adminstatus zurückstufen"
      },
      "leaveChatButton": {
        "leaveGroupchatText": "Gruppenchat verlassen",
        "leaveGroupchatDescriptionText": "Möchten Sie den Gruppenchat wirklich verlassen?"
      },
      "profileImageButton": {
        "saveProfileImageDescription": "Möchten Sie das Bild als Profilbild für den Gruppenchat verwenden?",
        "deleteProfileImageDescription": "Möchten Sie das Profilbild des Gruppenchats wirklich löschen?"
      },
      "futureConnectedEventsText": "Künftige verbundene Events: "
    },
    "changeChatUsernamePage": {
      "title": "Chat-Benutzernamen ändern",
      "newChatUsername": "Neuer Chat-Benutzername",
      "deleteChatName": "Chat-Namen löschen"
    },
    "futurePrivateEventsPage": {
      "title": "Künftige private Events",
      "noFuturePrivateEventsText": "Keine künftigen privaten Events für diesen Gruppenchat"
    },
    "updatePermissionPage": {
      "title": "Mitgliederberechtigungen"
    }
  },
  "introductionPages": {
    "permissionPages": {
      "general": {
        "requestPermissionText": "Berechtigung anfordern",
        "dontRequestPermissionText": "Keine Berechtigung anfordern"
      },
      "microphonePage": {
        "text": "Wenn Sie das Mikrofon beispielsweise für Sprachnachrichten verwenden möchten, drücken Sie bitte auf Anfordern."
      },
      "notificationPage": {
        "text": "Wenn Sie Benachrichtigungen wie Nachrichten, Einladungen usw. erhalten möchten, drücken Sie bitte auf Anfordern."
      }
    },
    "featurePages": {
      "messagePage": {
        "title": "Nachrichten",
        "receivedButNotReadText": "Empfangen, aber nicht gelesen",
        "receivedAndReadText": "Empfangen und gelesen"
      },
      "groupchatPage": {
        "text": "ChattyEvent ist die ultimative Lösung für Ihre Party- und Eventplanung! Unsere innovative App dreht sich um Gruppeninteraktion und macht es Ihnen leicht, mit Ihren Freunden, Ihrer Familie oder Ihren Kollegen zu kommunizieren. Ob Sie eine epische Party organisieren oder einfach in engerem Kontakt bleiben möchten, ChattyEvent ist der ideale Begleiter, um all Ihre Kontakte an einem zentralen Ort zusammenzuführen.\n\nChattyEvent zeichnet sich durch seine mühelose Benutzerfreundlichkeit aus und bietet alle Tools, die Sie für reibungslose Gruppenkommunikation und makellose Eventplanung benötigen. Warten Sie nicht länger - probieren Sie es noch heute aus und überzeugen Sie sich von der Leichtigkeit und Effizienz unserer App. Steigern Sie das Potenzial Ihrer Partyplanung und Eventorganisation mit ChattyEvent!\n\nViel Spaß mit ChattyEvent!"
      },
      "privateEventPage": {
        "text": "ChattyEvents spezielle Partyplanungsfunktion ermöglicht es Ihnen, Events schnell und mühelos einzurichten und alle Details mühelos zu teilen. Sie können die Event mit einem Gruppenchat verknüpfen oder unabhängig planen. Diese innovative Funktion stellt sicher, dass jeder eingeladen ist und alle relevanten Details auf einen Blick sichtbar sind.\n\nUm die Eventplanung noch weiter zu vereinfachen, haben wir sogar eine praktische Einkaufsliste hinzugefügt. Dadurch können Sie klar festlegen, was jeder Teilnehmer zum Event beitragen soll. Dadurch wird vermieden, dass etwas vergessen wird, und Sie können alle Details perfekt im Voraus koordinieren."
      },
      "usersPage": {
        "text": "Ebenso bietet ChattyEvent ein ausgefeiltes Freundschaftssystem, mit dem Sie die Rechte Ihrer Freunde gezielt verwalten können. Das bedeutet, dass Sie genau auswählen können, welche Freunde Sie in eine Gruppe aufnehmen und wie weitreichend ihr Zugriff sein soll. Individuelle Berechtigungen können für jeden Freund nach Ihren Wünschen angepasst werden - für eine gut organisierte und geschützte Gruppendynamik."
      }
    }
  },
  "newGroupchatPage": {
    "title": "Neuer Gruppenchat",
    "pages": {
      "permissionTab": {
        "title": "Mitgliederberechtigungen"
      },
      "selectUserTab": {
        "title": "Mitglieder auswählen"
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Beschreibung (optional)"
      },
      "deleteAfterEndDateSwitch": {
        "title": "Soll das Event automatisch nach dem Ende gelöscht werden"
      }
    }
  },
  "newPrivateEventPage": {
    "title": "Neues privates event",
    "pages": {
      "typTab": {
        "title": "Typ"
      },
      "searchTab": {
        "title": "Suche"
      },
      "dateTab": {
        "title": "Datum",
        "selectDateButtonText": "Datum auswählen*: {}",
        "selectEndDateButtonText": "Enddatum auswählen: {}"
      },
      "locationTab": {
        "title": "Ort (optional)"
      },
      "permissionTab": {
        "title": "Mitgliederberechtigungen"
      },
      "selectUserTab": {
        "title": "Mitglieder auswählen"
      },
      "eventTypTab": {
        "privateGroupchatEvent": {
          "title": "Privates Gruppenchat-Event",
          "description": "Hier verknüpfen Sie ein Event mit einem Gruppenchat. Alle Benutzer, die sich im Gruppenchat befinden, werden automatisch eingeladen. Wenn ein Benutzer den Chat verlässt oder entfernt wird, geschieht dies auch im Event."
        },
        "normalPrivateEvent": {
          "title": "Normales privates event",
          "description": "Hier können Sie Benutzer unabhängig von einem Chat einladen oder ausladen."
        }
      }
    },
    "fields": {
      "nameField": {
        "lable": "Name*"
      },
      "descriptionField": {
        "lable": "Beschreibung (optional)"
      }
    }
  },
  "profilePage": {
    "profileImageButton": {
      "saveProfileImageDescription": "Möchten Sie das Bild als Profilbild verwenden?",
      "deleteProfileImageDescription": "Möchten Sie das Profilbild löschen?"
    },
    "userRelationsTabs": {
      "followRequestsTab": {
        "title": "Folgeanfragen",
        "noFollowRequestsText": "Keine Folgeanfragen"
      },
      "followedTab": {
        "title": "Gefolgt",
        "noFollowedText": "Keine Gefolgt"
      },
      "followerTab": {
        "title": "Follower",
        "noFollowersText": "Keine Follower"
      }
    },
    "chatPage": {
      "otherUserNotFollowerInfoText": "Der andere Benutzer kann Ihnen keine Nachricht schreiben, da er Ihnen nicht folgt. Wenn Sie mit ihm schreiben möchten, überprüfen Sie bitte, ob er Ihnen eine Freundschaftsanfrage gesendet hat. Der andere Benutzer kann jedoch Ihre Nachrichten lesen."
    }
  },
  "settingsPage": {
    "title": "Einstellungen",
    "logout": "Abmelden",
    "themeModePage": {
      "title": "Design-Modus",
      "darkModeText": "Dunkelmodus",
      "darkModeAutomaticText": "Automatischer Dunkelmodus"
    },
    "privacyPage": {
      "title": "Privatsphäre",
      "personalDataTitle": "Persönliche Daten",
      "howOthersInteractWithYouText": "Wie dürfen andere mit Ihnen interagieren?",
      "calenderTileMessage": "Follower können sehen, ob Sie Zeit an einem Termin haben",
      "updatePasswordPage": {
        "title": "Passwort aktualisieren",
        "newPasswordText": "Neues Passwort",
        "confirmNewPasswordText": "Neues Passwort bestätigen",
        "sendEmailText": "Kann nicht erneut überprüfen? E-Mail zum Zurücksetzen des Passworts senden"
      },
      "updateEmailPage": {
        "title": "E-Mail aktualisieren",
        "currentEmailAddressText": "E-Mail-Adresse: {}",
        "newEmailAddressText": "Neue E-Mail",
        "confirmNewEmailAddressText": "Neue E-Mail bestätigen"
      },
      "updateBirthdatePage": {
        "title": "Geburtsdatum aktualisieren"
      },
      "chipTitles": {
        "noone": "Niemand",
        "followersExcept": "Follower außer",
        "onlyTheseFollowers": "Nur diese Follower"
      },
      "userListTexts": {
        "noUsersCanBeSelected": "Keine Benutzer können ausgewählt werden",
        "couldntLoadUsersDueToPermission": "Benutzer können aufgrund fehlender Berechtigungen nicht geladen werden"
      },
      "privateEventAddMePage": {
        "title": "Berechtigung zum Hinzufügen zu privaten events"
      },
      "groupchatAddMePage": {
        "title": "Berechtigung zum Hinzufügen zu Gruppenchats"
      },
      "calendarWatchIHaveTimePage": {
        "title": "Berechtigung zum sehen des Kalenders"
      }
    },
    "infoPage": {
      "title": "Info & Datenschutz",
      "faqText": "FAQ",
      "privacyPolicyText": "Datenschutzrichtlinie",
      "termsOfUseText": "Nutzungsbedingungen",
      "imprintText": "Impressum",
      "rightOnDataAccessText": "Recht auf Datenzugriff",
      "rightOnDeletionPage": {
        "title": "Recht auf Löschung",
        "text": "Wenn Sie auf die Schaltfläche 'Daten löschen' klicken, werden alle Ihre Daten gelöscht.",
        "followingDataWillBeDeletedText": "Die folgenden Daten können nicht gelöscht werden:",
        "deleteDataText": "Daten löschen",
        "dialog": {
          "title": "Wirklich alle Daten löschen",
          "message": "Möchten Sie wirklich alle Ihre Daten löschen?"
        }
      }
    }
  },
  "shoppingListPage": {
    "noItemsNeededText": "Es müssen keine Artikel gekauft werden",
    "changeUserText": "Benutzer ändern",
    "userWhoShouldBuyTheItemText": "Benutzer, der den Artikel kaufen soll",
    "unitText": " (Einheit)",
    "boughtText": " gekauft",
    "connectedEvent": {
      "title": "Verbundenes privates event: ",
      "connectedEventText": "Verbundenes Event"
    },
    "createBoughtAmount": {
      "newBoughtAmountText": "Neue gekaufte Menge",
      "boughtAmountIsntANumberAlert": {
        "title": "Fehler bei der gekauften Menge",
        "message": "Die eingegebene Menge muss eine Zahl sein"
      }
    },
    "boughtAmountList": {
      "noBoughtElementsFoundText": "Keine gekauften Mengen gefunden",
      "itemSubtitle": "Gekaufte Menge: {}"
    }
  },
  "createUserPage": {
    "title": "Benutzer erstellen",
    "usernameLable": "Benutzername"
  },
  "loginPage": {
    "title": "Anmelden",
    "emailLable": "E-Mail",
    "passwordLable": "Passwort",
    "loginText": "Anmelden",
    "passwordForgottenText": "Passwort vergessen?",
    "registerInsteadText": "Registrieren?"
  },
  "registerPage": {
    "title": "Registrieren",
    "emailLable": "E-Mail",
    "passwordLable": "Passwort",
    "confirmPasswordLable": "Passwort bestätigen",
    "registerText": "Registrieren",
    "loginInsteadText": "Anmelden?"
  },
  "resetPasswordPage": {
    "title": "Passwort zurücksetzen",
    "emailLable": "E-Mail",
    "sendEmailLable": "E-Mail senden"
  },
  "verifyEmailPage": {
    "title": "E-Mail bestätigen",
    "resendEmail": "E-Mail erneut senden"
  }
};
static const Map<String,dynamic> en = {
  "general": {
    "changeText": "Change",
    "addText": "Add",
    "createText": "Create",
    "saveText": "Save",
    "continueText": "Continue",
    "noText": "No",
    "yesText": "Yes",
    "okText": "Ok",
    "reloadText": "Reload",
    "loadMoreText": "Load more",
    "loadMembersText": "Load members",
    "everyoneText": "Everyone",
    "noInfoText": "No info",
    "deleteText": "Delete",
    "acceptText": "Accept",
    "rejectText": "Reject",
    "defaultDataText": "default data",
    "openInMapsText": "Open in maps",
    "kickText": "Kick",
    "chatText": "Chat",
    "removeText": "Remove",
    "errorText": "Error",
    "noDescriptionText": "No description",
    "memberPermissionText": "Member Permissions",
    "birthdateText": "Birthdate: {}",
    "showAllText": "Show all",
    "shoppingList": {
      "title": "Shopping list"
    },
    "notificationAlert": {
      "deleteImageText": "Delete image",
      "saveImageText": "Save image",
      "internetIsThereAlert": {
        "title": "Internet connection",
        "message": "You are connected to the internet again"
      },
      "noInternetIsThereAlert": {
        "title": "No internet connection",
        "message": "You lost your connection to the internet"
      }
    },
    "amountIsntANumberAlert": {
      "title": "Amount error",
      "message": "The entered quantity must be a number"
    },
    "messageArea": {
      "noMessagesText": "No messages"
    },
    "groupchatPermissionMenu": {
      "onlyAdminsText": "Only Admins"
    },
    "request": {
      "invitationEventText": "The user {} send you and invitation to the event {} at the following date: {}",
      "invitationGroupchatText": "The user {} send you and invitation to the groupchat {}"
    },
    "eventPermissionMenu": {
      "creatorOnlyText": "Creator only",
      "organizerOnlyText": "Organizers only"
    },
    "followButton": {
      "followText": "Follow",
      "followedText": "Followed",
      "requestedText": "Requested",
      "blockText": "Block",
      "blockedText": "Blocked",
      "takeBackRequest": "Take back request",
      "dontBlockAnymoreText": "Don't block anymore",
      "dontFollowAnymoreText": "Don't follow anymore"
    },
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
    },
    "chatMessage": {
      "reactMessageContainer": {
        "filesText": "Files",
        "currentLocationText": "Current Location",
        "audioText": "Audio"
      },
      "readByContainer": {
        "title": "Read By:",
        "emptyMessage": "Nobody read the message"
      }
    },
    "chatMessageInput": {
      "textField": {
        "hintText": "Message"
      },
      "voiceMessage": {
        "title": "Voice message"
      }
    },
    "dialog": {
      "cameraText": "Camera",
      "galleryText": "Gallery",
      "removeImageText": "Remove image",
      "yourLocationText": "Your Location"
    }
  },
  "authPages": {
    "dataprotectionBox": {
      "text1": "i have read and agree to the ",
      "text2": " and ",
      "text3": "",
      "privacyPolicyText": "Privacy policy",
      "termsOfUseText": "Terms of use"
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
        "noEventsText": "No events",
        "lastEvents": "Last events",
        "nextEvents": "Next events"
      },
      "mapPage": {
        "title": "Event Map"
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
        "title": "Members",
        "leftUserList": {
          "pastMembers": "Past members: {}"
        },
        "userList": {
          "addUserToEvent": "Add user to event",
          "membersThatWillBeThereCount": "Members that will be there: {}",
          "changeChatUsernameText": "Change chat username",
          "kickedText": "Kicked",
          "acceptedText": "Accepted",
          "rejectedText": "Rejected",
          "unknownText": "Unknown",
          "statusPlusOrganizerText": " | Organizer",
          "removeOrganizerStatus": "Remove organizer status",
          "makeOrganizer": "Make organizer"
        },
        "invitationList": {
          "errorToDisplayOneInvitationText": "Error when displaying an Invited User",
          "invitedByText": "Invited by: {}",
          "deleteInvitationText": "Delete invitation",
          "invitedUsersCount": "Invited users: {}"
        },
        "leaveEventButton": {
          "leaveEventText": "Leave event",
          "leaveEventDescriptionText": "Do you really want to leave the event?"
        }
      },
      "infoTab": {
        "connectedGroupchatText": "Connected groupchat",
        "addressButton": {
          "leftEmptyText": "Address: ",
          "rightEmptyText": "Add address",
          "removeAddressDialog": {
            "title": "Remove address",
            "message": "Do you really want to remove the address?"
          }
        },
        "deleteButton": {
          "dialog": {
            "title": "Delete event",
            "message": "Do you really want to delete the event?"
          }
        },
        "coverImageButton": {
          "saveCoverImageDescription": "Do you want to take the image as the event cover image?",
          "deleteCoverImageDescription": "Do you want to delete the event cover image?"
        },
        "statusButton": {
          "leftText": "Status: ",
          "takesPlaceText": "Takes place",
          "cancelledText": "Cancelled",
          "undecidedText": "Undecided"
        },
        "eventDateText": "Event date: ",
        "eventEndDateText": "Event end date: ",
        "memberPermissionsText": "Member permissions"
      }
    },
    "createShoppingListItemPage": {
      "title": "New Item",
      "fields": {
        "itemNameField": {
          "lable": "Item name"
        },
        "amountField": {
          "lable": "amount"
        },
        "unitField": {
          "lable": "unit"
        }
      },
      "userWhoShouldBuyTheItemText": "User that should buy the item: {}"
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
    "infoPage": {
      "invitationList": {
        "errorToDisplayOneInvitationText": "Error when displaying an Invited User",
        "invitedByText": "Invited by: {}",
        "deleteInvitationText": "Delete invitation",
        "invitedUsersCount": "Invited users: {}"
      },
      "leftUserList": {
        "pastMembers": "Past members: {}"
      },
      "userList": {
        "addUserToGroupchat": "Add user to groupchat",
        "membersCount": "Members: {}",
        "changeChatUsernameText": "Change chat username",
        "adminText": "Admin",
        "notAdminText": "Not admin",
        "makeAdmin": "Make admin",
        "degradeAdmin": "Degrade admin"
      },
      "leaveChatButton": {
        "leaveGroupchatText": "Leave groupchat",
        "leaveGroupchatDescriptionText": "Do you really want to leave the group chat?"
      },
      "profileImageButton": {
        "saveProfileImageDescription": "Do you want to take the image as groupchat profile image?",
        "deleteProfileImageDescription": "Do you want to delete the groupchat profile image?"
      },
      "futureConnectedEventsText": "Future connected events: "
    },
    "changeChatUsernamePage": {
      "title": "change chat username",
      "newChatUsername": "New chat username",
      "deleteChatName": "Delete chat name"
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
        "title": "Date",
        "selectDateButtonText": "Select date*: {}",
        "selectEndDateButtonText": "Select end date: {}"
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
    "profileImageButton": {
      "saveProfileImageDescription": "Do you want to take the image as profile image?",
      "deleteProfileImageDescription": "Do you want to delete the profile image?"
    },
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
        "title": "Update Birthdate"
      },
      "chipTitles": {
        "noone": "Noone",
        "followersExcept": "Followers Except",
        "onlyTheseFollowers": "Only these followers"
      },
      "userListTexts": {
        "noUsersCanBeSelected": "Keine User können gewählt werden",
        "couldntLoadUsersDueToPermission": "Kann keine User laden, da die berechtigung nicht geladen werden konnte"
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
    "noItemsNeededText": "No items that need to be bought",
    "changeUserText": "Change user",
    "userWhoShouldBuyTheItemText": "User that should buy the item",
    "unitText": " (unit)",
    "boughtText": " bought",
    "connectedEvent": {
      "title": "Connected private event: ",
      "connectedEventText": "Connected event"
    },
    "createBoughtAmount": {
      "newBoughtAmountText": "New bought amount",
      "boughtAmountIsntANumberAlert": {
        "title": "Bought amount error",
        "message": "The entered quantity must be a number"
      }
    },
    "boughtAmountList": {
      "noBoughtElementsFoundText": "No bought amounts",
      "itemSubtitle": "Bought amount: {}"
    }
  },
  "createUserPage": {
    "title": "Create User",
    "usernameLable": "Username"
  },
  "loginPage": {
    "title": "Login",
    "emailLable": "E-Mail",
    "passwordLable": "Password",
    "loginText": "Login",
    "passwordForgottenText": "Password forgotten?",
    "registerInsteadText": "Register?"
  },
  "registerPage": {
    "title": "Register",
    "emailLable": "E-Mail",
    "passwordLable": "Password",
    "confirmPasswordLable": "Confirm password",
    "registerText": "Register",
    "loginInsteadText": "Login?"
  },
  "resetPasswordPage": {
    "title": "Reset Password",
    "emailLable": "E-Mail",
    "sendEmailLable": "Send E-Mail"
  },
  "verifyEmailPage": {
    "title": "Verify E-Mail",
    "resendEmail": "Resend E-Mail"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}
