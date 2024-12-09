// imports nativos
import 'package:flutter/material.dart';

// import das telas
import 'package:fc_teams_drawer/app/pages/tournament/create/create_tournament_page.dart';
import 'package:fc_teams_drawer/app/pages/tournament/home/tournament_page.dart';
import 'package:fc_teams_drawer/app/pages/tournament/board/board_page.dart';
import 'package:fc_teams_drawer/app/pages/result_raffle/result_raffle.dart';
import 'package:fc_teams_drawer/app/core/style/app_images.dart';
import 'package:fc_teams_drawer/app/pages/splash/splash.dart';
import 'package:fc_teams_drawer/app/pages/home/home.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';

class Routes {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    final args = settings.arguments;

    switch( settings.name ) {
      case "/splash" :
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case "/" :
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case "/result-raffle" :
        return MaterialPageRoute(
          builder: (_) {

            final map = args as Map<String, dynamic>;
            bool isSolo = map["is_solo"];

            return ResultRaffle(
              isSolo: isSolo,
            );

          },
        );
      case "/tournament" :
        return MaterialPageRoute(
          builder: (_) => const TournamentPage(),
        );
      case "/new-tournament" :
        return MaterialPageRoute(
          builder: (_) => const CreateTournamentPage(),
        );
      case "/board" :
        return MaterialPageRoute(
          builder: (_) => BoardPage(
            tournament: args as TournamentEntity,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {

    return MaterialPageRoute(
      builder: ( context ) {

        final theme = Theme.of(context);

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                FlutterI18n.translate(context, "routes.app_bar"),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset(
                    AppImages.logoJpg,
                    height: 100,
                    width: 160,
                  ),

                  Text(
                    FlutterI18n.translate(context, "routes.title"),
                    style: theme.textTheme.displayLarge!.apply(
                      letterSpacingDelta: 4,
                      fontWeightDelta: 2,
                      fontSizeDelta: 5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only( top: 25 ),
                    child: Text(
                      FlutterI18n.translate(context, "routes.subtitle"),
                      style: theme.textTheme.displayMedium,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only( top: 50 ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                      ),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false),
                      child: Text(
                        FlutterI18n.translate(context, "routes.btn"),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium!.apply(
                          color: theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );

  }
}