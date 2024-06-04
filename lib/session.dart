import 'package:fc_teams_drawer/app/core/db/collections/fc_teams.dart';
import 'package:fc_teams_drawer/domain/source/local/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/domain/source/remote/performance.dart';
import 'package:fc_teams_drawer/domain/source/remote/app_events.dart';
import 'package:fc_teams_drawer/domain/source/remote/crash.dart';

class Session {
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  static final SecureStorageWrapper secureStorage = SecureStorageWrapper();
  static FCTeamsCollection fcTeamCollection = FCTeamsCollection();
  static final SharedServices sharedServices = SharedServices();
  static final Performance performance = Performance();
  static final AppEvents appEvents = AppEvents();
  static final Crash crash = Crash();

}