import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color borderColor;
  final List<String> features;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.borderColor,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 2),
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
          // Title & Subtitle
          Text(
            title,
            style: GoogleFonts.mulish(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: borderColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.mulish(
                  fontSize: 18,
                  color: const Color(0xFF0F274A).withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.mulish(
              fontSize: 16,
              color: borderColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),

          // Features list
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: features
                  .map(
                    (feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.green, size: 20,),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.mulish(
                                fontSize: 16,
                                color: borderColor.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
