import 'dart:io';
import 'package:flutter/material.dart';
import 'package:machine_text/domain/entities/user_entity.dart';
import 'package:machine_text/presentation/widgets/sort_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/add_user_dialog.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We watch the provider to rebuild when users are added, searched, or sorted
    final provider = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 70,
        elevation: 0,
        title: const Row(children: [
          Icon(Icons.location_on, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text("Nilambur", style: TextStyle(color: Colors.white, fontSize: 16)),
        ]),
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(context),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Users Lists",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: provider.filteredUsers.isEmpty
                ? const Center(child: Text("No users found"))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: provider.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = provider.filteredUsers[index];
                      return _userCard(user);
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddUserDialog(),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                onChanged: (value) {
                  context.read<UserProvider>().updateSearchQuery(value);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                  hintText: "search by name",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const SortBottomSheet(),
            ),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 22),
            ),
          )
        ],
      ),
    );
  }

  Widget _userCard(UserEntity user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            // Uses the helper to decide Network vs File
            backgroundImage: _getUserImage(user.imagePath),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                "Age: ${user.age}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Image Helper Logic
  ImageProvider _getUserImage(String? path) {
    if (path == null || path.isEmpty) {
      // Default placeholder if no image
      return const NetworkImage(
        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      );
    }

    if (path.startsWith('http')) {
      // If it's a URL (for Mock Data)
      return NetworkImage(path);
    } else {
      // If it's a local file path (for newly Added Data via Image Picker)
      return FileImage(File(path));
    }
  }
}