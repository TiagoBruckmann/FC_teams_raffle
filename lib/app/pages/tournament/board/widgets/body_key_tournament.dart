import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BodyKeyTournamentWidget extends StatelessWidget {
  final String playerName;
  final String teamLogo;
  final Function( int ) function;
  final int? score;
  final bool hasWinner;
  final bool hasChampion;
  final bool isLoser;
  const BodyKeyTournamentWidget({ super.key, required this.playerName, required this.teamLogo, this.score, required this.hasWinner, required this.function, this.hasChampion = false, this.isLoser = false });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return ListTile(
      leading: Image.asset(
        ( teamLogo.trim().isNotEmpty )
        ? "assets/img/teams/$teamLogo.png"
        : "assets/img/teams/chelsea.png",
        height: 50,
        color: teamLogo.trim().isNotEmpty ? null : Colors.grey.shade400,
        errorBuilder: ( builder, exception, stackTrace ) {

          Session.appEvents.sharedErrorEvent("load_image_error", exception.toString());
          Session.crash.onError("load_image_error", error: exception, stackTrace: stackTrace);

          return Shimmer(
            duration: const Duration(seconds: 5),
            color: Colors.grey[50]!,
            colorOpacity: 0.3,
            enabled: true,
            direction: const ShimmerDirection.fromLTRB(),
            child: Image.asset(
              "assets/img/teams/chelsea.png",
              color: Colors.grey.shade400,
            ),
          );

        },
      ),
      title: Text(
        ( isLoser && playerName.trim().isEmpty )
        ? FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser")
        : playerName,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall,
      ),
      subtitle: ( hasChampion )
      ? Text(
        FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.team_champion", translationParams: {"team": teamLogo.replaceAll("_", " ")}),
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium!.apply(
          color: theme.colorScheme.secondary,
        ),
      )
      : Card(
        child: PopupMenuButton<int>(
          enabled: !hasWinner && teamLogo.trim().isNotEmpty,
          color: theme.colorScheme.secondary,
          icon: Text(
            ( score != null)
              ? score.toString()
              : " - ",
            style: theme.textTheme.bodySmall,
          ),
          onSelected: ( int value ) => function( value ),
          itemBuilder: (context) {
        
            final List<int> goals = [];
            for ( int i = 0; i < 16; i++ ) {
              goals.add(i);
            }
        
            return goals.map(( int item) {
        
              return PopupMenuItem<int>(
                value: item,
                child: Text(
                  item.toString(),
                  style: theme.textTheme.bodySmall,
                ),
              );
        
            }).toList();
        
          },
        ),
      ),
    );
  }
}
