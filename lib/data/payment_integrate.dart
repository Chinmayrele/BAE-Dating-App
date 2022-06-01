import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentIntegrate extends StatefulWidget {
  PaymentIntegrate({Key? key}) : super(key: key);

  @override
  State<PaymentIntegrate> createState() => _PaymentIntegrateState();
}

class _PaymentIntegrateState extends State<PaymentIntegrate> {
  TextEditingController amountController = TextEditingController(text: '79');
  late Razorpay _razorpay;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint(
        "RESPONSE ORDERID: ${response.orderId}\nPAYMENT ID ${response.paymentId}\nSIGNATURE ${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint("CODE: ${response.code}\nMESSAGE ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    debugPrint("WALLET NAME ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  )),
              Text(
                'PAYMENT GATEWAY',
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 45),
          Center(
            child: Text(
              '𝓖𝓸 𝓟𝓻𝓮𝓶𝓲𝓾𝓶!',
              style: TextStyle(
                  color: Colors.red, fontSize: 42, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              // focusNode: _focusNode,
              readOnly: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 32, color: Colors.white),
              controller: amountController,
              decoration: InputDecoration(
                fillColor: Colors.white24,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                hintText: 'Enter Amount',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 18),
                prefixIcon: Icon(Icons.payment_outlined, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                launchPayment();
              },
              child: Text(
                'Make Payment',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(25),
                  primary: Colors.pink),
            ),
          )
        ],
      ),
    );
  }

  launchPayment() {
    int amountToPay = int.parse(amountController.text) * 100;
    var options = {
      'key': 'rzp_test_KuLoLYlScCzm2t',
      'amount': '$amountToPay',
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay.open(options);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
