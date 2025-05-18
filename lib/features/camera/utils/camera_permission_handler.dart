import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

class CameraPermissionHandler {
  static Future<bool> checkCameraPermission(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      return cameras.isNotEmpty;
    } on CameraException catch (e) {
      _showPermissionDialog(
        context: context,
        title: 'Camera Access Required',
        message: 'Please grant camera permission to use this feature.',
        error: e.description ?? 'Unknown camera error',
      );
      return false;
    } on PlatformException catch (e) {
      _showPermissionDialog(
        context: context,
        title: 'Camera Access Required',
        message: 'Please grant camera permission to use this feature.',
        error: e.message ?? 'Unknown platform error',
      );
      return false;
    }
  }

  static void _showPermissionDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String error,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text('$message\n\nError: $error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
