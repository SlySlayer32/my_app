import 'package:camera/camera.dart';
import 'package:my_app/features/camera/data/camera_controller.dart';
import 'package:my_app/features/camera/domain/repositories/camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraRepositoryImpl({CustomCameraController? cameraController})
      : _cameraController = cameraController ?? CustomCameraController();
  
  final CustomCameraController _cameraController;
  
  @override
  Future<void> initialize() => _cameraController.initialize();
  
  @override
  bool isInitialized() => _cameraController.isInitialized;
  
  @override
  CameraController? getController() => _cameraController.controller;
  
  @override
  Future<XFile?> captureRawImage() => _cameraController.captureRawImage();
  
  @override
  Future<void> toggleCamera() => _cameraController.toggleCamera();
  
  @override
  Future<void> dispose() => _cameraController.dispose();
}
