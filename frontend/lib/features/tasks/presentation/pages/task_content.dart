import 'package:flutter/material.dart';
import 'questionary_page.dart';
import 'daily_tasks_page.dart';
import 'weekly_tasks_page.dart';
import 'previous_assessments_page.dart';

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
            children: [
              ListTile(
                leading: const Icon(Icons.question_answer, color: Colors.indigo),
                title: const Text(
                  "Questionnaire",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuestionaryPage()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.today, color: Colors.indigo),
                title: const Text(
                  "Daily Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DailyTasksPage()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.calendar_view_week, color: Colors.indigo),
                title: const Text(
                  "Weekly Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WeeklyTasksPage()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.indigo),
                title: const Text(
                  "Previous Assessments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PreviousAssessmentsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
