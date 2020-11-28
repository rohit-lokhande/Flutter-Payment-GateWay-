import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentGateway extends StatefulWidget {
  @override
  _RazorpayPaymentGatewayState createState() => _RazorpayPaymentGatewayState();
}

class _RazorpayPaymentGatewayState extends State<RazorpayPaymentGateway> {
  Razorpay _razorpay;
  static const platform = const MethodChannel("razorpay_flutter");

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();

    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Razorpay Payment Gateway'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[RaisedButton(onPressed: _checkout, child: Text('Open'))])));
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
  }

  _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message);
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }

  void _checkout() async {
    var options = {
      'key': 'rzp_test_eqitAmd1WyBqCG' , // change this test key with your account
      'amount': 500,
      'name': 'Test In Corp..',
      'description': 'LapTop',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.
      open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
}
