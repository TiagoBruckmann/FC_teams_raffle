// imports nativos do flutter
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';

class CustomSnackBar {

  CustomSnackBar({ required String messageKey, Color? color, Map<String, String>? params }) {

    Session.appEvents.sharedErrorEvent("snack_bar", messageKey);

    final context = Session.globalContext.currentContext!;

    final snackBar = SnackBar(
      content: Text(
        FlutterI18n.translate(context, messageKey, translationParams: params),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color ?? Theme.of(context).colorScheme.error,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}