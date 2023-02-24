// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool? checkStatus;
  final String text;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  const TodoTile({
    super.key,
    required this.onChanged,
    required this.checkStatus,
    required this.text,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            // Edit action
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.green.shade200,
              borderRadius: BorderRadius.circular(12),
            ),

            // Delete action
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 75,
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 5.0,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
              Checkbox(value: checkStatus, onChanged: onChanged),
            ],
          ),
        ),
      ),
    );
  }
}
