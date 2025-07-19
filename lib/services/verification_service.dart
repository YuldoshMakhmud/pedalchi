import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodchi/controllers/phone_verification_controller.dart';
import 'package:get/get.dart';

class VerificationService {
  final controller = Get.put(PhoneVerificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
    
  ) async {

  }

  Future<void> verifySmsCode() async {

  }
}
