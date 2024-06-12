import 'package:equatable/equatable.dart';

class TournamentEntity extends Equatable {

  final String name, date;
  final bool isActive;

  const TournamentEntity( this.name, this.date, this.isActive );

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "is_active": isActive,
    };

    return map;
  }

  Map<String, dynamic> updStatus( bool status ) {

    Map<String, dynamic> map = {
      "name": name,
      "date": date,
      "is_active": status,
    };

    return map;
  }

  @override
  List<Object?> get props => [name, date, isActive];

}