import 'package:flutter/material.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              // EXACT ILLUSTRATION FROM UI
              Center(
                child: Image.asset(
                  'assets/image/OBJECTS.png', 
                  height: 180,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Enter Phone Number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 15),
              // STYLED TEXTFIELD
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number *",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // MULTI-COLOR TEXT (RichText)
              RichText(
                text: const TextSpan(
                  text: "By Continuing, I agree to TotalX's ",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  children: [
                    TextSpan(
                      text: "Terms and condition",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: " & "),
                    TextSpan(
                      text: "privacy policy",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // PILL BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const OtpScreen())
                  ),
                  child: const Text(
                    "Get OTP", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}