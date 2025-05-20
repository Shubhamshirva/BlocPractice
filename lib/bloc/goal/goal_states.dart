
import 'package:equatable/equatable.dart';
import 'package:practice/bloc/Model/goal_model.dart';

abstract class GoalState extends Equatable {
  const GoalState();

  @override
  List<Object> get props => [];
}

class GoalsLoading extends GoalState {}

class GoalsLoaded extends GoalState {
  final List<Goal> goals;

  const GoalsLoaded(this.goals);

  @override
  List<Object> get props => [goals];
}

class GoalsError extends GoalState {
  final String message;

  const GoalsError(this.message);

  @override
  List<Object> get props => [message];
}