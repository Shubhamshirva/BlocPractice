import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/goal/goal_event.dart';
import 'package:practice/bloc/goal/goal_states.dart';
import 'package:practice/bloc/repository/goal_repository.dart';
import 'package:practice/ui/goal/goal_timelineitem.dart';
import '../../bloc/goal/goal_bloc.dart';


class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoalBloc(goalRepository: GoalRepository())..add(FetchGoals()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Goal Timeline')),
        body: BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state is GoalsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GoalsLoaded) {
              final goals = state.goals;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height:  MediaQuery.of(context).size.height,
                      child:
                      
                       ListView.builder(
                        itemCount: goals.length + 1,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Start ${DateTime(2024, 11, 12).toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)),
                            );
                          } else if (index == goals.length) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () {
                                  // Trigger your add goal UI (e.g., show a dialog)
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String newGoalName = '';
                                      return AlertDialog(
                                        title: Text('Add New Goal',style: TextStyle(color: Colors.orange),),
                                        content: TextField(
                                          onChanged: (value) {
                                            newGoalName = value;
                                          },
                                          decoration: InputDecoration(hintText: 'Goal Name'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancel',style: TextStyle(color: Colors.black),),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Add',style: TextStyle(color: Colors.red),),
                                            onPressed: () {
                                              if (newGoalName.isNotEmpty) {
                                                BlocProvider.of<GoalBloc>(context).add(AddGoal(newGoalName));
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    // SizedBox(width: 40 + 12),
                                    // _TimelineNode(isLast: true, isCompleted: false, isFirst: goals.isEmpty),
                                    // SizedBox(width: 16),
                                    Icon(Icons.add, size: 30, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text('Add new Goal', style: TextStyle(fontSize: 16, color: Colors.green)),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            final goal = goals[index - 1];
                            return InkWell(
                              onTap: () {
                                // Trigger your complete goal logic
                                BlocProvider.of<GoalBloc>(context).add(CompleteGoal(goal));
                              },
                              child: GoalTimelineItem(
                                goal: goal,
                                isFirst: index - 1 == 0,
                                isLast: index - 1 == goals.length - 1,
                              ),
                            );
                          }
                        },
                      ),
                   
                    ),
                  ],
                ),
              );
            } else if (state is GoalsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


