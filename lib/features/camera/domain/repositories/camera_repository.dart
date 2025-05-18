import 'package:camera/camera.dart';

abstract class CameraRepository {
  /// Initialize the camera
  Future<void> initialize();
  
  /// Check if camera is initialized
  bool isInitialized();
  
  /// Get the camera controller
  CameraController? getController();
  
  /// Capture a raw image
  Future<XFile?> captureRawImage();
  
  /// Toggle between front and back cameras
  Future<void> toggleCamera();
  
  /// Clean up resources
  Future<void> dispose();
}
