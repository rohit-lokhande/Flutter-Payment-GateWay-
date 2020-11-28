import 'package:flutter/material.dart';
import 'package:payment_gateway/ui/Razorpay/razorpay_payment_gateway.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment Gateway Sample'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 32,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RazorpayPaymentGateway()),
                      );
                    },
                    child: Text('Razorpay Payment Gateway')),
              )
            ],
          ),
        ));
  }
}
