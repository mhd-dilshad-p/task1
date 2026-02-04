import '../repositories/user_repository.dart';

class SendOtpUseCase {
  final UserRepository repository;
  SendOtpUseCase(this.repository);

  Future<bool> call(String phone) {
    return repository.sendOtp(phone);
  }
}

class VerifyOtpUseCase {
  final UserRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<bool> call(String phone, String otp) {
    return repository.verifyOtp(phone, otp);
  }
}
