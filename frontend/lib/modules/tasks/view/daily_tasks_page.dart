import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/provider/task_provider.dart';
import 'package:provider/provider.dart';

class DailyTasksPage extends StatefulWidget {
  const DailyTasksPage({super.key});

  @override
  State<DailyTasksPage> createState() => _DailyTasksPageState();
}

class _DailyTasksPageState extends State<DailyTasksPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<TasksProvider>(context, listen: false);
      if (!provider.isDailyLoaded) {
        provider.loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Daily Tasks")),
      body: tasksProvider.dailyTasks.isEmpty
          ? const Center(child: Text("No daily tasks found."))
          : ListView.builder(
              itemCount: tasksProvider.dailyTasks.length,
              itemBuilder: (context, index) {
                final task = tasksProvider.dailyTasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Switch(
                      value: task.status,
                      onChanged: (val) {
                        tasksProvider.toggleTaskCompletion(task.id, true);
                      },
                      activeColor: Colors.green,
                    ),
                    leading: Icon(
                      task.status ? Icons.check_circle : Icons.circle_outlined,
                      color: task.status ? Colors.green : Colors.grey,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
