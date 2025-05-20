import 'package:equatable/equatable.dart';

abstract class LoginEvent  extends Equatable{

  @override
   List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
   EmailChanged({ required this.email});

   final String email;

   @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  PasswordChanged({ required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}


class LoginApi extends LoginEvent{}