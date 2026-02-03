import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});
  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add A New User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade400,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
                    ),
                    Container(
                      width: 100, height: 30,
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50))),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Name", style: TextStyle(color: Colors.grey, fontSize: 13)),
            TextField(controller: nameController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 15),
            const Text("Age", style: TextStyle(color: Colors.grey, fontSize: 13)),
            TextField(controller: ageController, keyboardType: TextInputType.number, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(backgroundColor: Colors.grey.shade200), child: const Text("Cancel")),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserProvider>().addUser(nameController.text, int.parse(ageController.text), _image?.path);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}