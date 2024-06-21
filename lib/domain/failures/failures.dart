// import dos pacotes
import 'package:equatable/equatable.dart';

abstract class Failure {
  final String message = "";
}

class ServerFailure extends Failure with EquatableMixin {
  final String errorMessage;
  ServerFailure( this.errorMessage );

  @override
  List<Object?> get props => [errorMessage];

}

class CacheFailure extends Failure with EquatableMixin {
  final String errorMessage;
  CacheFailure( this.errorMessage );

  @override
  List<Object?> get props => [errorMessage];
}

class GeneralFailure extends Failure with EquatableMixin {
  final String errorMessage;
  GeneralFailure( this.errorMessage );

  @override
  List<Object?> get props => [errorMessage];
}