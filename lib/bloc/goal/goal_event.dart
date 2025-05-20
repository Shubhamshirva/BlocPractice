
import 'package:equatable/equatable.dart';
import 'package:practice/bloc/Model/goal_model.dart';



abstract class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object> get props => [];
}

class FetchGoals extends GoalEvent {}

class AddGoal extends GoalEvent {
  final String goalName;

  const AddGoal(this.goalName);

  @override
  List<Object> get props => [goalName];
}

class CompleteGoal extends GoalEvent {
  final Goal goal;

  const CompleteGoal(this.goal);

  @override
  List<Object> get props => [goal];
}