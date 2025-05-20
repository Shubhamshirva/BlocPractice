class Goal {
  String goalName;
  DateTime startDate;
  DateTime? completionDate;
  double progress;
  int? order;

  Goal({
    required this.goalName,
    required this.startDate,
    this.completionDate,
    this.progress = 0.0,
    this.order,
  });

  bool get isCompleted => completionDate != null;
}