import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'user_list_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _secondsRemaining = 59;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) c.dispose();
    for (var n in _focusNodes) n.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) _secondsRemaining--;
          else _timer?.cancel();
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    String enteredOtp = _controllers.map((c) => c.text).join();

    if (enteredOtp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter 6-digit OTP")));
      return;
    }

    setState(() => _isVerifying = true);


    bool verified = await context.read<UserProvider>().validateOtp(enteredOtp);

    if (mounted) setState(() => _isVerifying = false);

    if (verified) {
      if (!mounted) return;

      await _showSuccessDialog();
      
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserListScreen()),
        (route) => false,
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP or Verification Failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 2), () {
          if (ctx.mounted && Navigator.canPop(ctx)) {
            Navigator.of(ctx).pop();
          }
        });
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.green.shade50, shape: BoxShape.circle),
                  child: const Icon(Icons.check_rounded,
                      color: Colors.green, size: 50),
                ),
                const SizedBox(height: 20),
                const Text("Success!",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("User verified successfully.",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = context.read<UserProvider>().phoneNumber;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                  child: Image.asset('assets/image/Group.png', height: 180)),
              const SizedBox(height: 40),
              const Text("OTP Verification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Enter OTP sent to $phone",
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => _otpInputBox(index))),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _isVerifying ? null : _verifyOtp,
                  child: _isVerifying
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpInputBox(int index) {
    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: _controllers[index].text.isNotEmpty
                ? Colors.red
                : Colors.grey.shade300),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(counterText: "", border: InputBorder.none),
        onChanged: (val) {
          setState(() {});
          if (val.isNotEmpty && index < 5) _focusNodes[index + 1].requestFocus();
          if (val.isEmpty && index > 0) _focusNodes[index - 1].requestFocus();
        },
      ),
    );
  }
}