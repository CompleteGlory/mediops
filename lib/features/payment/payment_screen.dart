// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mediops/features/payment/paymob_checkout_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});

//   static const int freeTrialDays = 30;
//   static const int priceEGP = 500;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF1F9FF),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         iconTheme: const IconThemeData(color: Color(0xFF0F274A)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HEADER
//             Text(
//               'Clinic Subscription',
//               style: GoogleFonts.mulish(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFF0F274A),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Text(
//               'Start with a free trial, then pay monthly',
//               style: GoogleFonts.mulish(
//                 fontSize: 16,
//                 color: const Color(0xFF0F274A).withOpacity(0.7),
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// FREE TRIAL CARD
//             _infoCard(
//               icon: Icons.card_giftcard,
//               title: '$freeTrialDays Days Free Trial',
//               subtitle: 'No payment required today',
//               borderColor: const Color(0xFF00F488E),
//             ),

//             const SizedBox(height: 24),

//             /// PRICING CARD
//             _infoCard(
//               icon: Icons.credit_card,
//               title: '$priceEGP EGP / month',
//               subtitle: 'Cancel anytime • Unlimited usage',
//               borderColor: const Color(0xFF0F274A),
//             ),

//             const Spacer(),

//             /// CTA
//             SizedBox(
//               width: double.infinity,
//               height: 58,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Trial starts without payment
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const PaymobCheckoutScreen(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00F488E),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 child: Text(
//                   'Continue to Payment',
//                   style: GoogleFonts.mulish(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Center(
//               child: Text(
//                 'Secure payment powered by Paymob',
//                 style: GoogleFonts.mulish(
//                   fontSize: 14,
//                   color: Colors.black.withOpacity(0.6),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color borderColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: borderColor, width: 2),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: borderColor, size: 32),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.mulish(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF0F274A),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.mulish(
//                     fontSize: 14,
//                     color: Colors.black.withOpacity(0.6),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
