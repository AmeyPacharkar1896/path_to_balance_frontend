import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;

  const TaskTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.indigo),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
        const Divider(),
      ],
    );
  }
}
