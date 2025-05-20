
import 'package:practice/bloc/Model/goal_model.dart';

class GoalRepository {
  // Simulate fetching goals
  Future<List<Goal>> fetchGoals() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate loading
    return [
      Goal(goalName: 'Retirement', startDate: DateTime(2024, 11, 12), completionDate: DateTime(2025, 4, 15), progress: 1.0, order: 1),
      Goal(goalName: 'Home Renovation', startDate: DateTime(2024, 12, 01), progress: 0.6, order: 2),
      Goal(goalName: 'Car', startDate: DateTime(2025, 01, 20), progress: 0.8, order: 3),
      Goal(goalName: 'Vacation', startDate: DateTime(2025, 03, 05), progress: 0.2, order: 4),
      Goal(goalName: 'Education Fund', startDate: DateTime(2024, 11, 20), completionDate: DateTime(2025, 3, 10), progress: 1.0, order: 5),
    ];
  }

  // Implement methods to add, complete, etc., goals to your data source
}