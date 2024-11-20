import 'package:flutter/material.dart';
import 'package:education_apps/app/modules/profile/views/qr_code_picker_screen.dart'; // Import the screen for the QR Code picker (not used but can be helpful)


class TopUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up Saldo'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih metode top up saldo Anda:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Virtual Account button
            _buildTopUpOption(
              context,
              'Top Up dengan Virtual Account',
              Icons.account_balance_wallet,
              Colors.blue.shade500,
            ),
            const SizedBox(height: 15),
            // Bank Transfer button
            _buildTopUpOption(
              context,
              'Top Up dengan Bank Transfer',
              Icons.account_balance,
              Colors.green.shade500,
            ),
            const SizedBox(height: 15),
            // QR Code button that will navigate to CameraScreen
            _buildTopUpOption(
              context,
              'Top Up dengan QR Code',
              Icons.qr_code,
              Colors.purple.shade500,
              onTap: () {
                // Navigate to CameraScreen when QR Code option is selected
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          leading: Icon(
            icon,
            color: color,
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
