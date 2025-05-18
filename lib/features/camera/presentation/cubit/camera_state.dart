part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  const CameraState();
  
  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {
  const CameraInitial();
}

class CameraLoading extends CameraState {
  const CameraLoading();
}

class CameraReady extends CameraState {
  const CameraReady(this.controller);
  
  final CameraController controller;
  
  @override
  List<Object?> get props => [controller];
}

class CameraCaptureInProgress extends CameraState {
  const CameraCaptureInProgress();
}

class CameraError extends CameraState {
  const CameraError(this.message);
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}
