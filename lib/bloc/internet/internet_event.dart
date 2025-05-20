import 'package:equatable/equatable.dart';

abstract class InternetEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InternetLostEvent extends InternetEvent{}

class InternetGainedEvent extends InternetEvent{}