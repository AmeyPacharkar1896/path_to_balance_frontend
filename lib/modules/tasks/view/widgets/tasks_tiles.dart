import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? routeName;
  final VoidCallback? onTap;

  const TaskTile({
    Key? key,
    required this.icon,
    required this.label,
    this.routeName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        leading: Icon(icon, size: 28, color: theme.colorScheme.primary),
        title: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 20,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        onTap:
            onTap ??
            () {
              if (routeName != null) {
                Navigator.pushNamed(context, routeName!);
              }
            },
      ),
    );
  }
}
