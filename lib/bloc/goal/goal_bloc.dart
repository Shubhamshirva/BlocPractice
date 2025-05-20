import 'package:bloc/bloc.dart';
import 'package:practice/bloc/Model/goal_model.dart';
import 'package:practice/bloc/goal/goal_event.dart';
import 'package:practice/bloc/goal/goal_states.dart';
import 'package:practice/bloc/repository/goal_repository.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository _goalRepository;

  GoalBloc({required GoalRepository goalRepository}) : _goalRepository = goalRepository, super(GoalsLoading()) {
    on<FetchGoals>(_onFetchGoals);
    on<AddGoal>(_onAddGoal);
    on<CompleteGoal>(_onCompleteGoal);
  }

  Future<void> _onFetchGoals(FetchGoals event, Emitter<GoalState> emit) async {
    emit(GoalsLoading());
    try {
      final goals = await _goalRepository.fetchGoals();
      emit(GoalsLoaded(_sortGoals(goals)));
    } catch (e) {
      emit(GoalsError('Failed to fetch goals: ${e.toString()}'));
    }
  }

  Future<void> _onAddGoal(AddGoal event, Emitter<GoalState> emit) async {
    if (state is GoalsLoaded) {
      final currentGoals = (state as GoalsLoaded).goals;
      final newGoal = Goal(
        goalName: event.goalName,
        startDate: DateTime.now(),
        progress: 0.0,
        order: currentGoals.where((g) => !g.isCompleted).length + 1,
      );
      final updatedGoals = [...currentGoals, newGoal];
      // Optionally save to repository
      // await _goalRepository.addGoal(newGoal);
      emit(GoalsLoaded(_sortGoals(updatedGoals)));
    }
  }

  Future<void> _onCompleteGoal(CompleteGoal event, Emitter<GoalState> emit) async {
    if (state is GoalsLoaded) {
      final currentGoals = (state as GoalsLoaded).goals;
      final updatedGoals = currentGoals.map((goal) {
        if (goal == event.goal) {
          return Goal(
            goalName: goal.goalName,
            startDate: goal.startDate,
            completionDate: DateTime.now(),
            progress: 1.0,
            order: goal.order,
          );
        }
        return goal;
      }).toList();
      // Optionally save to repository
      // await _goalRepository.completeGoal(event.goal);
      emit(GoalsLoaded(_sortGoals(updatedGoals)));
    }
  }

  List<Goal> _sortGoals(List<Goal> goals) {
    final pendingGoals = goals.where((g) => !g.isCompleted).toList()
      ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    final completedGoals = goals.where((g) => g.isCompleted).toList()
      ..sort((a, b) => b.completionDate!.compareTo(a.completionDate!));
    return [...pendingGoals, ...completedGoals];
  }
}