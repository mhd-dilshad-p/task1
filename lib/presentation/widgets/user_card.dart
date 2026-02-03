import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Age: ${user.age}"),
      ),
    );
  }
}