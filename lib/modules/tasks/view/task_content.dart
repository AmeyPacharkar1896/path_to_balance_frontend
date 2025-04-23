import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/view/tasks_page.dart';
import 'package:frontend/modules/tasks/view/widgets/tasks_tiles.dart'; // assumes your TaskTile lives here

class TaskContent extends StatelessWidget {
  const TaskContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          children: [
            TaskTile(
              icon: Icons.question_answer,
              label: 'Questionnaire',
              routeName: '/questionary-list',
            ),
            TaskTile(
              icon: Icons.today,
              label: 'Daily Tasks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(
                      isDaily: true,
                      title: 'Daily Tasks',
                    ),
                  ),
                );
              },
            ),
            TaskTile(
              icon: Icons.calendar_view_week,
              label: 'Weekly Tasks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(
                      isDaily: false,
                      title: 'Weekly Tasks',
                    ),
                  ),
                );
              },
            ),
            TaskTile(
              icon: Icons.history,
              label: 'Previous Assessments',
              routeName: '/assessment-history',
            ),
          ],
        ),
      ),
    );
  }
}
