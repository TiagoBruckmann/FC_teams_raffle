import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final String message;
  final bool isLoading;
  const LoadingOverlay({super.key, required this.child, this.message = "", this.isLoading = false});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return PopScope(
      canPop: !isLoading,
      child: Stack(
        children: [
          child,

          if ( isLoading )
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withValues(alpha: 0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const CircularProgressIndicator(),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      FlutterI18n.translate(context, message),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),

                ],
              ),
            ),
        ],
      ),
    );
  }
}