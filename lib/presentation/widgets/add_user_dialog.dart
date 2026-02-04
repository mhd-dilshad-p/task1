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
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add A New User", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade700]),
                        image: _image != null ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover) : null,
                      ),
                      child: _image == null ? const Icon(Icons.person, size: 60, color: Colors.white70) : null,
                    ),
                    Container(
                      width: 100, height: 35,
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50))),
                      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Name", style: TextStyle(color: Colors.grey, fontSize: 14)),
            TextField(controller: _nameController, decoration: InputDecoration(hintText: "Shaukath Ali OP", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            const Text("Age", style: TextStyle(color: Colors.grey, fontSize: 14)),
            TextField(controller: _ageController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "43", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.grey),
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(115, 153, 152, 152)),
                 shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                 ),
                  ),
                  ),
                const SizedBox(width: 12),
                provider.isLoading 
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty) {
                          await provider.createAndUploadUser(
                            name: _nameController.text,
                            age: int.parse(_ageController.text),
                            imagePath: _image?.path,
                          );
                          Navigator.pop(context);
                        }
                      },
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