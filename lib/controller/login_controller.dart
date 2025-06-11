import 'package:apex_test/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late final LoginModel model;
  final TextEditingController textController = TextEditingController();

  LoginController({required String source}) {
    model = LoginModel(
      source: source,
      mobileNumber: '',
      isTermsAccepted: false,
    );

    // Sync text controller with model
    textController.addListener(() {
      model.mobileNumber.value = textController.text;
    });
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void updateMobileNumber(String value) {
    model.mobileNumber.value = value;
  }

  void toggleTermsAccepted(bool? value) {
    model.isTermsAccepted.value = value ?? false;
  }

  Future<void> getOTPViaWhatsapp() async {
    if (!_validateInputs()) return;
    await _sendOTP('whatsapp');
  }

  Future<void> getOTPViaSMS() async {
    if (!_validateInputs()) return;
    await _sendOTP('sms');
  }

  bool _validateInputs() {
    if (model.mobileNumber.value.isEmpty) {
      Get.snackbar('Error', 'Please enter mobile number');
      return false;
    }

    if (model.mobileNumber.value.length != 10) {
      Get.snackbar('Error', 'Please enter 10-digit mobile number');
      return false;
    }

    if (!model.isTermsAccepted.value) {
      Get.snackbar('Error', 'Please accept terms and conditions');
      return false;
    }

    return true;
  }

  Future<void> _sendOTP(String method) async {
    try {
      final mobile = model.mobileNumber.value;

      final uri = Uri.parse('https://qrbuddy.in/opd/buddy/f88333dc521611ee87200ab43322a272/login')
          .replace(queryParameters: {
        'mobile': mobile,
        'method': method,
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Get.toNamed('/otp', arguments: {
          'source': model.source,
          'mobileNumber': mobile,
        });
      } else {
        Get.snackbar('Error', 'Failed to send OTP: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    }
  }
}
