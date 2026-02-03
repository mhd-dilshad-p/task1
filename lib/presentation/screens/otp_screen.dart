import 'package:flutter/material.dart';
import 'user_list_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              const SizedBox(height: 40),
              // LAPTOP SHOPPING ILLUSTRATION
              Center(
                child: Image.asset(
                  'assets/image/Group.png', // Laptop shopping placeholder
                  height: 180,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "OTP Verification",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter the verification code we just sent to your number +91 *******21.",
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 30),
              // OTP INPUT ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _otpBox("0", true),
                  _otpBox("2", true),
                  _otpBox("", false),
                  _otpBox("", false),
                  _otpBox("", false),
                  _otpBox("", false),
                ],
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  "59 Sec", 
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Don't Get OTP? ",
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                    children: [
                      TextSpan(
                        text: "Resend",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // VERIFY BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (_) => const UserListScreen()),
                    (route) => false, // Remove login history
                  ),
                  child: const Text(
                    "Verify", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(String digit, bool isFilled) {
    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isFilled ? Colors.red : Colors.grey.shade300, width: 1.5),
      ),
      child: Text(
        digit,
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: isFilled ? Colors.red : Colors.black
        ),
      ),
    );
  }
}