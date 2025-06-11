import 'package:apex_test/controller/login_controller.dart';
import 'package:apex_test/widgets/custom_button.dart';
import 'package:apex_test/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final String source;

  const LoginView({required this.source, super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController(source: source));

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Patient Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please enter your mobile number for verification',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    CustomInput(
                      controller: controller.textController,
                      hintText: 'Mobile Number',
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      prefix: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                        child: DropdownButton<String>(
                          value: '+91',
                          underline: Container(),
                          onChanged: null,
                          items: [
                            DropdownMenuItem<String>(
                              value: '+91',
                              child: Text(
                                '+91',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'OTP Via Whatsapp',
                            onPressed: () => controller.getOTPViaWhatsapp(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: 'OTP Via SMS',
                            onPressed: () => controller.getOTPViaSMS(),
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: controller.model.isTermsAccepted.value,
                              onChanged: controller.toggleTermsAccepted,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black87, fontSize: 12),
                                  children: [
                                    const TextSpan(text: 'I Agree to the '),
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(color: Colors.red.shade300),
                                    ),
                                    const TextSpan(text: ', '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.red.shade300),
                                    ),
                                    const TextSpan(text: ' and compliance towards DPDP Act'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 24),

                    Obx(() => CustomButton(
                          text: 'Get OTP',
                          onPressed: controller.model.isValid ? () => controller.getOTPViaSMS() : null,
                          useGradient: false,
                          trailingIcon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white.withOpacity(0.8),
                            size: 18,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
