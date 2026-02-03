class UserEntity {
  final String name;
  final int age;
  final String? imagePath; // Local path from Image Picker

  UserEntity({required this.name, required this.age, this.imagePath});
}