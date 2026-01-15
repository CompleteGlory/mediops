// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymobCheckoutScreen extends StatefulWidget {
//   const PaymobCheckoutScreen({super.key});

//   @override
//   State<PaymobCheckoutScreen> createState() => _PaymobCheckoutScreenState();
// }

// class _PaymobCheckoutScreenState extends State<PaymobCheckoutScreen> {
//   late WebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             if (url.contains('success=true')) {
//               Navigator.pop(context, true);
//             }
//             if (url.contains('success=false')) {
//               Navigator.pop(context, false);
//             }
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(
//           'https://accept.paymob.com/api/acceptance/iframes/734400?payment_token=PAYMENT_KEY_FROM_BACKEND'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Secure Payment'),
//       ),
//       body: WebViewWidget(controller: _webViewController),
//     );
//   }
// }
