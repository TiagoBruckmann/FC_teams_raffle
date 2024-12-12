import 'package:fc_teams_drawer/domain/entity/team.dart';
import 'package:fc_teams_drawer/domain/source/local/fc_drawer_logs.dart';
import 'package:flutter/material.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/domain/source/remote/performance.dart';
import 'package:fc_teams_drawer/domain/source/remote/app_events.dart';
import 'package:fc_teams_drawer/domain/source/remote/crash.dart';

class Session {
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  static final SharedServices sharedServices = SharedServices();
  static final Performance performance = Performance();
  static final FcDrawerLogs logs = FcDrawerLogs();
  static final AppEvents appEvents = AppEvents();
  static final List<TeamEntity> teams = [];
  static final Crash crash = Crash();

}