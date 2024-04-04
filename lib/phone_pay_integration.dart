import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:uuid/uuid.dart';

/// ### PACKAGES ### ///
// phonepe_payment_sdk: ^1.0.4
// crypto: ^3.0.3
// uuid: ^3.0.7

/// PERMISSION TO ADD IN MANIFEST ///

// <meta-data android:name="com.phonepe.android.sdk.isUAT" android:value="true"/>
// <meta-data android:name="com.phonepe.android.sdk.isSimulator" android:value="true"/>
// <meta-data android:name="com.phonepe.android.sdk.MerchantId" android:value="merchantId(je hoy e nakhvani)"/>

/// BUILD GRADLE (PROJECT)
/// In allprojects part
// maven {
// url  "https://phonepe.mycloudrepo.io/public/repositories/phonepe-intentsdk-android"
// }

/// INITIALIZATION

// phonepeInit() in initstate;
// startPgTransaction() in payButton

class PaymentController extends GetxController {
  ///Phonepe SDK
  String environment = "SANDBOX";
  String appId = "";
  String merchantId = "merchantId NAKHVANI";
  String saltKey = "SALT KEY NAKHVANI";
  String saltIndex = "1";
  String callbackUrl = "https://webhook.site/callback-url";
  String type = "";

  String checksum = "";
  String? merchantTransactionId;
  String body = "";
  String apiEndPoint = "/pg/v1/pay";
  Object? result;
  bool enableLogging = true;

  ///phonepe sdk checksum
  getChecksum({
    String? amount,
  }) {
    merchantTransactionId = const Uuid().v4().substring(0, 30);
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": merchantTransactionId,
      // "merchantUserId": DYNAMIC ID HOVI JOIYE,
      "amount": AMOUNT,
      "mobileNumber": "MOBILE NO",
      "deviceContext": {"deviceOS": Platform.isAndroid ? "ANDROID" : "IOS"},
      "redirectUrl": callbackUrl,
      "redirectMode": "REDIRECT",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    log("requestData=============$requestData");

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) async => {
              log("PhonePePaymentSdk.getPackageSignatureForAndroid()====>${await PhonePePaymentSdk.getPackageSignatureForAndroid()}"),
              result = 'PhonePe SDK Initialized - $val',
              log("INIT++++SUCCESS"),
            })
        .catchError((error) {
      result = {"error": error};
      return <dynamic>{};
    });
    update();
  }

  void startPgTransaction({
    String? amount,
  }) async {
    try {
      body = getChecksum(
        amount: amount,
      ).toString();
      var response = PhonePePaymentSdk.startPGTransaction(
          body, callbackUrl, checksum, {}, apiEndPoint, "");
      response.then((val) async {
        if (val != null) {
          String status = val['status'].toString();
          String error = val['error'].toString();

          log("status=====$status");

          if (status == 'SUCCESS') {
            result = "Flow complete - status : SUCCESS";
            await checkStatus();
          } else {
            result = "Flow complete - status : $status and error $error";
          }
        } else {
          result = "Flow Incomplete";
        }
      }).catchError((error) {
        result = {"error": error};
        return <dynamic>{};
      });
    } catch (error) {
      result = {"error": error};
    }
    update();
  }

  checkStatus() async {
    try {

      /// TESTING URL CHE PRODUCTION MA CHANGE THASHE 
      String url =
          "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$merchantTransactionId"; //Test

      String concatenatedString =
          "/pg/v1/status/$merchantId/$merchantTransactionId$saltKey";

      var bytes = utf8.encode(concatenatedString);
      var digest = sha256.convert(bytes);
      String hashedString = digest.toString();
      //  combine with salt key
      String xVerify = "$hashedString###$saltIndex";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "X-MERCHANT-ID": merchantId,
        "X-VERIFY": xVerify,
      };

      await http.get(Uri.parse(url), headers: headers).then((value) {
        Map<String, dynamic> res = jsonDecode(value.body);

        log("res=-=------$res");

        try {
          if (res["code"] == "PAYMENT_SUCCESS" &&
              res['data']['responseCode'] == "SUCCESS") {
            log(" res['data']['responseCode'] ${res['data']['responseCode']}");
          } else {
            log(" res['data']['responseCode'] ===========================${res['data']['responseCode']}");
          }
        } catch (e) {
          log("e=------${e}");
        }
      });
    } catch (e) {
      log("e=--eeeeee----${e}");
    }
  }
}
