import 'package:get/get_rx/src/rx_types/rx_types.dart';

class LoginModel {
  final String source;
  final RxString mobileNumber;
  final RxBool isTermsAccepted;

  LoginModel({
    required this.source,
    String? mobileNumber,
    bool? isTermsAccepted,
  })  : mobileNumber = (mobileNumber ?? '').obs,
        isTermsAccepted = (isTermsAccepted ?? false).obs;

  bool get isValid => mobileNumber.value.length == 10 && isTermsAccepted.value;
}
