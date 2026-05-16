import 'package:attendance_nmscst/src/data/provider/demo_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoModeDialog extends StatelessWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const DemoModeDialog({
    super.key,
    this.onConfirm,
    this.onCancel,
  });

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DemoModeDialog(
        onConfirm: () {
          Provider.of<DemoModeProvider>(context, listen: false)
              .enableDemoMode();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          Provider.of<DemoModeProvider>(context, listen: false)
              .setConnectivityChecked();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.orange[700],
            size: 28,
          ),
          const SizedBox(width: 10),
          const Text(
            'API Connection Failed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unable to connect to the server. This could be due to:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildBulletPoint('Server is offline or unreachable'),
          _buildBulletPoint('Network connection issues'),
          _buildBulletPoint('Incorrect server configuration'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 24),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Would you like to continue in Demo Mode with sample data?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onConfirm,
          icon: const Icon(Icons.play_arrow),
          label: const Text(
            'Enter Demo Mode',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
