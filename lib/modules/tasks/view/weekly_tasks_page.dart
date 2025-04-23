import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/provider/task_provider.dart';
import 'package:provider/provider.dart';

class WeeklyTasksPage extends StatefulWidget {
  const WeeklyTasksPage({super.key});

  @override
  State<WeeklyTasksPage> createState() => _WeeklyTasksPageState();
}

class _WeeklyTasksPageState extends State<WeeklyTasksPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<TasksProvider>(context, listen: false);
      if (!provider.isWeeklyLoaded) {
        provider.loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final theme = Theme.of(context);

    final weeklyTasks = tasksProvider.weeklyTasks;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Weekly Tasks'), centerTitle: true),
      body: SafeArea(
        child:
            weeklyTasks.isEmpty
                ? Center(
                  child: Text(
                    'No weekly tasks found.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                )
                : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: weeklyTasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final task = weeklyTasks[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: Icon(
                          task.status
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color:
                              task.status
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface.withOpacity(
                                    0.6,
                                  ),
                        ),
                        title: Text(
                          task.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          task.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                        trailing: Switch(
                          value: task.status,
                          onChanged:
                              (_) => tasksProvider.toggleTaskCompletion(
                                task.id,
                                false,
                              ),
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
