import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CustomCameraController {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;

  /// Initialize the camera
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        throw CameraException('No cameras', 'No cameras available on device');
      }

      // By default use the back camera
      await setCamera(CameraLensDirection.back);

      _isInitialized = true;
    } on CameraException catch (e) {
      debugPrint('Camera initialization error: ${e.code}, ${e.description}');
      rethrow;
    }
  }

  /// Set active camera by direction
  Future<void> setCamera(CameraLensDirection direction) async {
    if (_cameras == null || _cameras!.isEmpty) {
      throw CameraException('No cameras', 'No cameras available');
    }

    // Find the requested camera
    final camera = _cameras!.firstWhere(
      (camera) => camera.lensDirection == direction,
      orElse: () => _cameras!.first,
    );

    // Dispose previous controller if exists
    await _controller?.dispose();

    // Create a new controller
    _controller = CameraController(
      camera,
      // Use highest resolution available
      ResolutionPreset.max,
      // Enable raw image format
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // Initialize the controller
    await _controller!.initialize();
  }

  /// Capture a raw image
  Future<XFile?> captureRawImage() async {
    if (!_isInitialized ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      throw CameraException(
          'Camera not initialized', 'Initialize camera before capturing');
    }

    try {
      // Capture the image
      final file = await _controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error capturing image: ${e.code}, ${e.description}');
      return null;
    }
  }

  /// Dispose the controller
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }

  /// Toggle between front and back cameras
  Future<void> toggleCamera() async {
    if (_controller == null || _cameras == null || _cameras!.isEmpty) return;

    final currentDirection = _controller!.description.lensDirection;
    final newDirection = currentDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    await setCamera(newDirection);
  }
}
