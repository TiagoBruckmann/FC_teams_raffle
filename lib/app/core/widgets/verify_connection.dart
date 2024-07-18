// imports nativos
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/widgets/loading_connection.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/source/local/mobx/connection/connection.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class VerifyConnection extends StatelessWidget {

  final String keyAppBar;
  final Map<String, String>? appBarParams;
  final List<Widget>? actionWidgets;
  final Widget page;
  final Function? floatingFunction;
  const VerifyConnection({ super.key, required this.keyAppBar, this.appBarParams, this.actionWidgets, required this.page, this.floatingFunction });

  @override
  Widget build(BuildContext context) {

    final connectionMobx = Provider.of<ConnectionMobx>(context);
    connectionMobx.listenChangeConnectivityState();
    final ThemeData theme = Theme.of(context);

    return Observer(
      builder: (builder) {

        return SafeArea(
          child: Scaffold(
            appBar: ( keyAppBar.trim().isEmpty )
            ? null
            : AppBar(
              title: Text(
                FlutterI18n.translate(context, keyAppBar, translationParams: appBarParams),
                style: theme.textTheme.bodyMedium,
              ),
              centerTitle: true,
              actions: actionWidgets ?? [],
            ),
            body: ( !Session.sharedServices.validateConnection(connectionMobx) )
            ? const LoadingConnection()
            : page,
            floatingActionButton: ( floatingFunction == null )
            ? null
            : FloatingActionButton(
              onPressed: () => floatingFunction!.call(),
              child: Icon(
                Icons.add,
                color: theme.colorScheme.surface,
                size: 25,
              ),
            ),
          ),
        );

      },
    );
  }
}