import 'package:flutter/material.dart';

class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ONE CLOUD ENTERPRISE PLATFORM',
                  style: TextStyle(
                    color: Color(0xFF172B4D),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Secure cloud management platform',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          const Text(
            'All Systems Operational',
            style: TextStyle(
              color: Color(0xFF374151),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            'v1.0.0',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
