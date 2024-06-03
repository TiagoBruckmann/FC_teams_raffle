import 'package:fc_teams_drawer/app/core/services/app_enums.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/cupertino.dart';

class NavigationRoutes {

  static BuildContext currentContext = Session.globalContext.currentContext!;

  static void navigation( String type, String route, { Object? extra }) {

    if ( type == NavigationTypeEnum.pushAndRemoveUntil.value ) {
      Navigator.pushNamedAndRemoveUntil(
        currentContext,
        route,
        arguments: extra,
        (route) => false,
      );
      return;
    }

    if ( type == NavigationTypeEnum.push.value ) {
      Navigator.pushNamed(
        currentContext,
        route,
        arguments: extra,
      );
      return;
    }

    Navigator.pop(currentContext, extra);
    return;

  }

}