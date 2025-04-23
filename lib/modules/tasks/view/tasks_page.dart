import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/provider/task_provider.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  final bool isDaily;
  final String title;

  const TaskPage({super.key, required this.isDaily, required this.title});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<TasksProvider>(context, listen: false);
      // Load tasks if not already loaded based on the type of tasks (daily/weekly)
      if (widget.isDaily && !provider.isDailyLoaded) {
        provider.loadTasks();
      } else if (!widget.isDaily && !provider.isWeeklyLoaded) {
        provider.loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final theme = Theme.of(context);

    final tasks = widget.isDaily ? tasksProvider.dailyTasks : tasksProvider.weeklyTasks;
    final isLoading = widget.isDaily ? !tasksProvider.isDailyLoaded : !tasksProvider.isWeeklyLoaded;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
            : tasks.isEmpty
                ? Center(
                    child: Text(
                      'No tasks found.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          leading: Icon(
                            task.status ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: task.status
                                ? theme.colorScheme.primary // green when completed
                                : theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          title: Text(
                            task.title,
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(task.description, style: theme.textTheme.bodyMedium),
                          trailing: Switch(
                            value: task.status,
                            onChanged: (_) => tasksProvider.toggleTaskCompletion(task.id, widget.isDaily),
                            activeColor: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
