import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// SEND OTP METHOD
Future<void> sendOTP(String phoneNumber, BuildContext context, String isFrom) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  try {
    // _setShowLoader(true);

    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // _setShowLoader(false);
        await auth.signInWithCredential(credential);
        print('Verification completed');
        // Handle verification completed
      },
      verificationFailed: (FirebaseAuthException e) {
        // _setShowLoader(false);
        // showToast('Verification failed: ${e.message}');
        // Handle verification failed
        // if (e.code == 'invalid-phone-number') {
        //   CommonSnackBar.showSnackBar(
        //       context: context, title: "Invalid MobileNumber");
        // } else if (e.code == 'missing-phone-number') {
        //   CommonSnackBar.showSnackBar(
        //       context: context, title: "Missing Phone Number");
        //   log('Missing Phone Number');
        // } else if (e.code == 'user-disabled') {
        //   CommonSnackBar.showSnackBar(
        //       context: context, title: "Number is Disabled");
        // } else if (e.code == 'quota-exceeded') {
        //   CommonSnackBar.showSnackBar(
        //       context: context, title: "You try too many time. try later ");
        // } else if (e.code == 'captcha-check-failed') {
        //   CommonSnackBar.showSnackBar(context: context, title: "Try Again");
        // } else {
        //   log('Verification Failed!');
        // }
        // CommonSnackBar.showSnackBar(
        //     context: context,
        //     title: "Verification failed try with another number");
      },
      codeSent: (String verificationId, int? resendToken) {
        // _setShowLoader(false);
        // verificationID = verificationId;
        // showToast("OTP sent successfully.", isSuccess: true);

        // ADD NAVIGATION OF VERIFICATION SCREEN
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // _setShowLoader(false);
      },
    );
  } catch (e) {
    // log('e :::::::::::::::::: ${e}');
    // _setShowLoader(false);
  }
}

/// VERIFY OTP METHOD
Future<void> verifyOTP(String otp, BuildContext context, String isFrom) async {
  // _setShowLoader(true);
  try {
    /// GET AND STORE FCM TOKEN
    // await FirebaseMessaging.instance.getToken().then((mToken) {
    //   getFcmToken = mToken ?? '';
    // });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      /// FROM PREVIOUS SCREEN
      verificationId: 'verificationID.toString()',
      smsCode: otp,
    );
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential? userCredential = await auth.signInWithCredential(credential);
    if (userCredential.user != null) {
      // _setShowLoader(false);
      // _preferences.setBool("token", true);
      // _preferences.setString("number", userCredential.user?.phoneNumber ?? "");

      /// ADD LOGIC FOR STORE DATA OR NAVIGATE TO NEXT SCREEN
    } else {
      // _setShowLoader(false);
      // _preferences.setBool("token", false);
      // showToast("OTP verification failed");
    }
  } catch (e) {
    // _preferences.setBool("token", false);
    // _setShowLoader(false);
    // showToast("OTP verification failed");
    // if (e.code == 'invalid-verification-code') {
    //   CommonSnackBar.showSnackBar(context: context, title: 'Invalid Code');
    // } else if (e.code == 'expired-action-code') {
    //   CommonSnackBar.showSnackBar(context: context, title: 'Code Expired');
    // } else if (e.code == 'invalid-verification-code') {
    //   CommonSnackBar.showSnackBar(context: context, title: 'Invalid Code');
    // } else if (e.code == 'user-disabled') {
    //   CommonSnackBar.showSnackBar(context: context, title: 'User Disabled');
    // }
  }
}

/// LOGOUT USER
Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    /// ADD NAVIGATION OF LOGIN SCREEN
  } catch (e) {
    // showToast('Error signing out. Try again.');
  }
}

/// LIKING SIGNUP METHODS
Future<bool> linkSignUpMethod({required String email, required String password, required BuildContext context}) async {
  try {
    // showProgressDialog();
    final credential = EmailAuthProvider.credential(email: email, password: password);

    final userCredential = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    return true;
  } on FirebaseAuthException catch (e) {
    // hideProgressDialog();
    // if (e.code == 'network-request-failed') {
    //   print('ERROR CREATE ON SIGN UP TIME == No Internet Connection.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "No Internet Connection.");
    // } else if (e.code == 'too-many-requests') {
    //   print(
    //       'ERROR CREATE ON SIGN UP TIME == Too many attempts please try later');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "Too many attempts please try later.");
    // } else if (e.code == 'weak-password') {
    //   print(
    //       'ERROR CREATE ON SIGN UP TIME == The password provided is too weak.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "The password provided is too weak.");
    // } else if (e.code == 'email-already-in-use') {
    //   print(
    //       'ERROR CREATE ON SIGN UP TIME == The account already exists for that email.');
    //   CommonSnackBar.showSnackBar(
    //       context: context,
    //       title: "The account already exists for that email.");
    // } else if (e.code == 'invalid-email') {
    //   print(
    //       'ERROR CREATE ON SIGN UP TIME == The email address is not valid.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "The email address is not valid.");
    // } else if (e.code == 'weak-password') {
    //   print(
    //       'ERROR CREATE ON SIGN UP TIME == The password is not strong enough.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "The password is not strong enough.");
    // } else if (e.code == "provider-already-linked") {
    //   CommonSnackBar.showSnackBar(
    //       context: context,
    //       title: "The provider has already been linked to the user.");
    // } else if (e.code == "invalid-credential") {
    //   CommonSnackBar.showSnackBar(
    //       context: context,
    //       title: "The provider's credential is not valid..");
    // } else if (e.code == "credential-already-in-use") {
    //   CommonSnackBar.showSnackBar(
    //       context: context,
    //       title:
    //       "The account corresponding to the credential already exists, "
    //           "or is already linked to a Firebase User.");
    // } else {
    //   print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "Something went to wrong.");
    // }

    return false;
  }
}

/// LOGIN WITH EMAIL-PASSWORD
Future<bool> logInMethod({required String email, required String password, required BuildContext context}) async {
  // showProgressDialog();
  try {
    // await kFirebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    // update();

    return true;
  } on FirebaseAuthException catch (e) {
    // hideProgressDialog();

    // if (e.code == 'network-request-failed') {
    //   print('ERROR CREATE ON SIGN IN TIME == No Internet Connection.');
    //
    //   CommonSnackBar.showSnackBar(context: context, title: "No Internet Connection.");
    // } else if (e.code == 'too-many-requests') {
    //   print('ERROR CREATE ON SIGN IN TIME == Too many attempts please try later');
    //   CommonSnackBar.showSnackBar(context: context, title: "Too many attempts please try later.");
    // } else if (e.code == 'user-not-found') {
    //   print('ERROR CREATE ON SIGN IN TIME == No user found for that email.');
    //
    //   CommonSnackBar.showSnackBar(context: context, title: "No user found for that email.");
    // } else if (e.code == 'wrong-password') {
    //   print('ERROR CREATE ON SIGN IN TIME == The password is invalid for the given email.');
    //   CommonSnackBar.showSnackBar(context: context, title: "The password is invalid for the given email.");
    // } else if (e.code == 'invalid-email') {
    //   print('ERROR CREATE ON SIGN IN TIME == The email address is not valid.');
    //   CommonSnackBar.showSnackBar(context: context, title: "The email address is not valid.");
    // } else if (e.code == 'user-disabled') {
    //   print('ERROR CREATE ON SIGN IN TIME ==  The user corresponding to the given email has been disabled.');
    //   CommonSnackBar.showSnackBar(
    //       context: context, title: "The user corresponding to the given email has been disabled.");
    // } else {
    //   print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
    //   CommonSnackBar.showSnackBar(context: context, title: "Something went to wrong.");
    // }
    // update();

    return false;
  }
}

/// FORGOT PASSWORD METHOD
Future<bool> forgotPasswordMethod({required String email, required BuildContext context}) async {
  // showProgressDialog();
  try {
    // await kFirebaseAuth.sendPasswordResetEmail(email: email);
    // update();

    return true;
  } on FirebaseAuthException catch (e) {
    // hideProgressDialog();
    // if (e.code == 'network-request-failed') {
    //   print('ERROR CREATE ON SIGN IN TIME == No Internet Connection.');
    //
    //   CommonSnackBar.showSnackBar(context: context, title: "No Internet Connection.");
    // } else if (e.code == 'too-many-requests') {
    //   print('ERROR CREATE ON SIGN IN TIME == Too many attempts please try later');
    //   CommonSnackBar.showSnackBar(context: context, title: "Too many attempts please try later.");
    // } else if (e.code == 'user-not-found') {
    //   print('ERROR CREATE ON SIGN IN TIME == No user found for that email.');
    //   CommonSnackBar.showSnackBar(context: context, title: "No user found for that email.");
    // } else if (e.code == 'invalid-email') {
    //   print('ERROR CREATE ON SIGN IN TIME == The email address is not valid.');
    //   CommonSnackBar.showSnackBar(context: context, title: "The email address is not valid.");
    // } else if (e.code == 'missing-email') {
    //   print('ERROR CREATE ON SIGN IN TIME ==  The user corresponding to the given email has been disabled.');
    //   CommonSnackBar.showSnackBar(context: context, title: "The email address is missing..");
    // } else {
    //   print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
    //   CommonSnackBar.showSnackBar(context: context, title: "Something went to wrong.");
    // }
    // update();
    return false;
  }
}

/// GET CURRENT USER DETAILS

// CollectionReference<Map<String, dynamic>> userCollection =
// FirebaseFirestore.instance.collection('user');
// getCurrentUserDetails({String? userId}) async {
//   var data = await userCollection.doc(userId).get();
//   Map<String, dynamic>? userData = await data.data();
//
//   nameController.text = userData!['userName'];
//   emailController.text = userData['userEmail'];
//   phoneController.text = userData['userPhoneNumber'];
//   phoneController.text = userData['userPhoneNumber'];
//   isMember = userData['isMember'];
//   endDate = userData['endDate'];
//
//   update();
// }
