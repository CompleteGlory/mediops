import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  static const int freeTrialDays = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF0F274A)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Text(
              'Clinic Subscription',
              style: GoogleFonts.mulish(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F274A),
              ),
            ),

            const SizedBox(height: 20),

            /// Free Trial Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF00F488E),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.card_giftcard,
                    size: 32,
                    color: Color(0xFF00F488E),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$freeTrialDays days FREE trial\nNo payment required now',
                      style: GoogleFonts.mulish(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F274A),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// Pricing Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '500 EGP / month',
                    style: GoogleFonts.mulish(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F274A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlimited patients\nClinic & staff apps\nWhatsApp & notifications',
                    style: GoogleFonts.mulish(
                      fontSize: 16,
                      color: const Color(0xFF0F274A).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// CTA
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO:
                  // 1. Save trial start date
                  // 2. Navigate to dashboard
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F488E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  'Start Free Trial',
                  style: GoogleFonts.mulish(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
