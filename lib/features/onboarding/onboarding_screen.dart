import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediops/features/onboarding/feature_card.dart';
import 'package:mediops/features/payment/payment_screen.dart';

class MediOpsOnboarding extends StatelessWidget {
  const MediOpsOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    const cardHeight = 460.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              /// FREE TRIAL BADGE
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00F488E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🎉 1 Month Free Trial – No Credit Card Required',
                  style: GoogleFonts.mulish(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// LOGO
              Image.asset(
                'assets/images/mediops light.png',
                height: 190,
              ),

              const SizedBox(height: 24),

              /// MAIN VALUE PROPOSITION
              Text(
                'Run Your Clinic Like a Business',
                style: GoogleFonts.mulish(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F274A),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'Appointments, patients, payments, and growth — all in one system.',
                style: GoogleFonts.mulish(
                  fontSize: 18,
                  height: 1.4,
                  color: const Color(0xFF0F274A).withOpacity(0.75),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              /// PRICING / ROLE CARDS
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: FeatureCard(
                              title: 'For Patients',
                              subtitle: 'Always Free',
                              description:
                                  'Mobile apps for iOS & Android\nSmart reminders & easy booking',
                              borderColor: Color(0xFF0F274A),
                              features: [
                                'Book appointments easily',
                                'WhatsApp & notification reminders',
                                'View medical history',
                                'Free mobile app',
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 32),
                        Expanded(
                          child: SizedBox(
                            height: cardHeight,
                            child: FeatureCard(
                              title: 'For Clinics',
                              subtitle: '500 EGP / month',
                              description:
                                  'Complete clinic management platform\nMobile & desktop apps',
                              borderColor: Color(0xFF00F488E),
                              features: [
                                '1 month FREE trial',
                                'Profit & sales management',
                                'Schedule & staff management',
                                'Patient history & analytics',
                                'Referrals & service packages',
                                'WhatsApp & push notifications',
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: const [
                        SizedBox(
                          height: cardHeight,
                          child: FeatureCard(
                            title: 'For Patients',
                            subtitle: 'Always Free',
                            description:
                                'Mobile apps for iOS & Android\nSmart reminders & easy booking',
                            borderColor: Color(0xFF0F274A),
                            features: [
                              'Book appointments easily',
                              'WhatsApp & notification reminders',
                              'View medical history',
                              'Free mobile app',
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          height: cardHeight,
                          child: FeatureCard(
                            title: 'For Clinics',
                            subtitle: '500 EGP / month',
                            description:
                                'Complete clinic management platform\nMobile & desktop apps',
                            borderColor: Color(0xFF00F488E),
                            features: [
                              '1 month FREE trial',
                              'Profit & sales management',
                              'Schedule & staff management',
                              'Patient history & analytics',
                              'Referrals & service packages',
                              'WhatsApp & push notifications',
                            ],
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 56),

              /// PRIMARY CTA
              SizedBox(
                width: 260,
                height: 62,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PaymentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 12,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00F488E),
                          Color(0xFF0F274A),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(
                        'Start Free Trial',
                        style: GoogleFonts.mulish(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// SECONDARY TRUST TEXT
              Text(
                'No credit card required • Cancel anytime',
                style: GoogleFonts.mulish(
                  fontSize: 14,
                  color: const Color(0xFF0F274A).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
