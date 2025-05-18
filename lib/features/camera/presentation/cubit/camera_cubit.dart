import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/camera/domain/repositories/camera_repository.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit(this._cameraRepository) : super(const CameraInitial());
  
  final CameraRepository _cameraRepository;
  
  Future<void> initializeCamera() async {
    emit(const CameraLoading());
    try {
      await _cameraRepository.initialize();
      final controller = _cameraRepository.getController();
      if (controller != null) {
        emit(CameraReady(controller));
      } else {
        emit(const CameraError('Failed to initialize camera controller'));
      }
    } catch (e) {
      emit(CameraError('Failed to initialize camera: $e'));
    }
  }
  
  Future<XFile?> takePicture() async {
    if (state is! CameraReady) {
      emit(const CameraError('Camera not ready'));
      return null;
    }
    
    try {
      emit(const CameraCaptureInProgress());
      final imageFile = await _cameraRepository.captureRawImage();
      
      // Return to ready state
      emit(CameraReady(_cameraRepository.getController()!));
      return imageFile;
    } catch (e) {
      emit(CameraError('Failed to capture image: $e'));
      return null;
    }
  }
  
  Future<void> toggleCamera() async {
    if (state is! CameraReady) return;
    
    emit(const CameraLoading());
    try {
      await _cameraRepository.toggleCamera();
      final controller = _cameraRepository.getController();
      if (controller != null) {
        emit(CameraReady(controller));
      }
    } catch (e) {
      emit(CameraError('Failed to toggle camera: $e'));
    }
  }
  
  @override
  Future<void> close() async {
    await _cameraRepository.dispose();
    return super.close();
  }
}
