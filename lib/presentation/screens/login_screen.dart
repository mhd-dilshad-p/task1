import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

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
              Center(
                  child: Image.asset('assets/image/OBJECTS.png', height: 180)),
              const SizedBox(height: 50),
              const Text("Enter Phone Number",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "Enter Phone Number *",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          String phone = phoneController.text.trim();
                          if (phone.length < 10) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Enter valid 10-digit number")));
                            return;
                          }

                          setState(() => _isLoading = true);


                          bool sent = await context
                              .read<UserProvider>()
                              .requestOtp(phone);

                          if (mounted) setState(() => _isLoading = false);

                          if (sent) {
                            if (!mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const OtpScreen()));
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Failed to send OTP"),
                                    backgroundColor: Colors.red));
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Get OTP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}