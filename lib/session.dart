// imports nativos do flutter
import 'package:flutter/material.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/services/shared.dart';

// imports globais
import 'package:fc_teams_drawer/domain/source/remote/performance.dart';
import 'package:fc_teams_drawer/domain/source/remote/app_events.dart';
import 'package:fc_teams_drawer/domain/source/remote/crash.dart';

class Session {
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  static final SharedServices sharedServices = SharedServices();
  static final Performance performance = Performance();
  static final AppEvents appEvents = AppEvents();
  static final Crash crash = Crash();

}