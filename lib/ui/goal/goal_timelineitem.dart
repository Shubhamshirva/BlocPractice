import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:practice/bloc/Model/goal_model.dart';

class GoalTimelineItem extends StatelessWidget {
  final Goal goal;
  final bool isFirst;
  final bool isLast;

  const GoalTimelineItem({
    Key? key,
    required this.goal,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 40), // Indentation for the line
          _TimelineNode(isFirst: isFirst, isLast: isLast, isCompleted: goal.isCompleted),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goal.goalName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Start: ${goal.startDate.toLocal().toString().split(' ')[0]}'),
              if (goal.isCompleted)
                Text('Completed: ${goal.completionDate!.toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 8),
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 5.0,
                percent: goal.progress,
                center: Text('${(goal.progress * 100).toInt()}%'),
                progressColor: goal.isCompleted ? Colors.green : Colors.blue,
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isCompleted;

  const _TimelineNode({
    Key? key,
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          SizedBox(
            height: 20,
            child: VerticalDivider(thickness: 2, color: Colors.grey.shade300),
          ),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? Colors.green : Colors.blue,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text('${(1).toInt()}', // Placeholder for goal number
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
        if (!isLast)
          VerticalDivider(thickness: 2, color: Colors.grey.shade300),
      ],
    );
  }
}
