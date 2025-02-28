import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import '../models/payment_model.dart';

abstract class MpesaDataSource {
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment);
}

class MpesaDataSourceImpl implements MpesaDataSource {
  // Initialize M-PESA SDK
  void initialize() {
    MpesaFlutterPlugin.setConsumerKey(
        "QnNgoGg5pL5xjLED6QNap9cdkBoaIunZtcU4i6RhyDG6v3fA");
    MpesaFlutterPlugin.setConsumerSecret(
        "E7C11LAxxrPfMWS8byqkR8eUVNPeGLPV1t0QE3zsme0fNA6fh7aZRPfQUB1ZwfYN");
  }

  @override
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment) async {
    try {
      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: payment.businessCode,
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: payment.amount,
          partyA: payment.phoneNumber,
          partyB: payment.businessCode,
          callBackURL: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
          accountReference: payment.reference,
          phoneNumber: payment.phoneNumber,
          baseUri: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
          transactionDesc: payment.description,
          passKey:
          "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      debugPrint("Transaction Result: $result");
      return {
        'success': true,
        'message': 'STK Push sent successfully',
        'data': result,
      };
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}