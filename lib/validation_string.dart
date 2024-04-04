extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(this);
  }
}

extension MobileNumberValidator on String {
  bool isValidMobileNumber() {
    RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(this);
  }
}

class ValidationString {
  final String emailEmpty = "Please Enter email";
  final String emailValid = "Please Enter valid email";
  final String passwordEmpty = "Please Enter password";
  final String newPasswordEmpty = "Please Enter New Password";
  final String reTypePasswordEmpty = "Please Re-Type New Password";
  final String currentPasswordEmpty = "Please Enter Current password";
  final String confirmPasswordEmpty = "Please Enter Confirm password";
  final String passwordCharacter = "Password Must be more than 5 characters";
  final String passwordValid = "Password should contain upper,lower,digit and Special character";
  final String confirmPasswordValid = "Password And Confirm Password Must be Same";
  final String nameEmpty = "Please Enter Name";
  final String lastNameEmpty = "Please Enter Last Name";
  final String phoneNumberEmpty = "Please Enter Phone Number";
  final String phoneNumberValid = "Please Enter Valid Phone Number";
  final String phoneNumberSize = "Phone Number Size Must be 10 Digits";
  final String acceptPolicy = "Please accept the terms and conditions.";
}

/// VALIDATION IMPLEMENTATION
// final ValidationString commonValidateTexts = ValidationString();
//
// String? validateNameField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.nameEmpty;
//   }
//   return null;
// }
//
// String? validateLastNameField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.lastNameEmpty;
//   }
//   return null;
// }
//
// String? validateEmailField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.emailEmpty;
//   } else if (text.toString().isValidEmail() == false) {
//     return commonValidateTexts.emailValid;
//   }
//   return null;
// }
//
// String? validatePhoneNumberField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.phoneNumberEmpty;
//   } else if (text.toString().length != 10) {
//     return commonValidateTexts.phoneNumberSize;
//   } else if (text.toString().isValidMobileNumber() == false) {
//     return commonValidateTexts.phoneNumberValid;
//   }
//   return null;
// }
//
// String? validatePasswordField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.passwordEmpty;
//   } else if (text.toString().length < 6) {
//     return commonValidateTexts.passwordCharacter;
//   } else if (!text.toString().isValidPassword()) {
//     return commonValidateTexts.passwordValid;
//   }
//   return null;
// }
//
// String? validateConfirmPasswordField(String? text) {
//   if (text.toString().isEmpty) {
//     return commonValidateTexts.confirmPasswordEmpty;
//   } else if (password.text != cPassword.text) {
//     return commonValidateTexts.confirmPasswordValid;
//   }
//   return null;
// }
