// pacotes nativos do flutter
import 'package:flutter/material.dart';
import 'dart:async';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';

class LoadingConnection extends StatefulWidget {
  const LoadingConnection({ super.key });

  @override
  State<LoadingConnection> createState() => _LoadingConnectionState();
}

class _LoadingConnectionState extends State<LoadingConnection> {

  bool _status = true;
  double _opacity = 1;
  Timer? _timer;

  void _changeStatus() {
    _timer = Timer.periodic(const Duration(seconds: 2, milliseconds: 5), (Timer t) {
      if ( _opacity == 0 ) {
        setState(() {
          _status = !_status;
          _opacity = 1;
        });
      } else {
        setState(() {
          _opacity = 0;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _changeStatus();
  }

  @override
  void dispose() {
    if ( _timer != null && _timer!.isActive ) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          padding: const EdgeInsets.only( top: 20, bottom: 100 ),
          color: themeData.scaffoldBackgroundColor,
          alignment: Alignment.center,
          duration: const Duration(seconds: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: _opacity,
                child: SizedBox(
                  height: 50,
                  child: Icon(
                    ( _status )
                    ? Icons.wifi
                    : Icons.wifi_off,
                    size: 80,
                    color: themeData.colorScheme.error,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22, 60, 22, 10),
                child: Text(
                  FlutterI18n.translate(context, "pages.connection.title"),
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.displaySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}