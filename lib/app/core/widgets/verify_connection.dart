// imports nativos
import 'package:flutter/material.dart';

// import das telas
import 'package:fc_teams_drawer/app/core/widgets/loading_overlay.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';

class VerifyConnection extends StatelessWidget {
  final String keyAppBar;
  final Map<String, String>? appBarParams;
  final List<Widget>? actionWidgets;
  final Widget page;
  final Function? floatingFunction;
  final bool isLoading;
  final String loadingMessage;
  const VerifyConnection({ super.key, required this.keyAppBar, this.appBarParams, this.actionWidgets, required this.page, this.floatingFunction, this.isLoading = false, this.loadingMessage = ""});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

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
        body: LoadingOverlay(
          isLoading: isLoading,
          message: loadingMessage,
          child: page,
        ),
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
  }
}