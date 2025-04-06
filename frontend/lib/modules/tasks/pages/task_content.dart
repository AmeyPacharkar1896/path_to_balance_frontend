import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/pages/widgets/tasks_tiles.dart';
import 'package:frontend/routes/app_routes.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade100, Colors.indigo.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Tasks",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.indigo),
          centerTitle: true,
        ),
        body: Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: ListView(
            children: const [
              TaskTile(
                icon: Icons.question_answer,
                label: "Questionnaire",
                routeName: AppRoutes.questionaryList,
              ),
              TaskTile(
                icon: Icons.today,
                label: "Daily Tasks",
                routeName: AppRoutes.dailyTasks,
              ),
              TaskTile(
                icon: Icons.calendar_view_week,
                label: "Weekly Tasks",
                routeName: AppRoutes.weeklyTasks,
              ),
              TaskTile(
                icon: Icons.history,
                label: "Previous Assessments",
                routeName: AppRoutes.assessmentHistory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
