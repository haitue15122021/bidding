// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("Restaurant Management"),
    "cancelled" : MessageLookupByLibrary.simpleMessage("Cancelled"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "connectTimeout" : MessageLookupByLibrary.simpleMessage("Connect timeout"),
    "connectionProblem" : MessageLookupByLibrary.simpleMessage("There are some problems with the connection. Please try again"),
    "connectionTimedOut" : MessageLookupByLibrary.simpleMessage("The connection has timed out. Please try again"),
    "invalidCredentials" : MessageLookupByLibrary.simpleMessage("Invalid credentials"),
    "oops" : MessageLookupByLibrary.simpleMessage("OOPs..."),
    "openTime" : MessageLookupByLibrary.simpleMessage("Operating Hours"),
    "pleaseCheckYourInternetConnection" : MessageLookupByLibrary.simpleMessage("Please check your internet connection."),
    "receiveTimeout" : MessageLookupByLibrary.simpleMessage("Receive timeout"),
    "restaurantEmpty" : MessageLookupByLibrary.simpleMessage("There is no restaurant."),
    "restaurants" : MessageLookupByLibrary.simpleMessage("Restaurants"),
    "sendTimeout" : MessageLookupByLibrary.simpleMessage("Send timeout"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Try again")
  };
}
