import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:get_it/get_it.dart';

class CameraPreviewPage extends StatelessWidget {
  const CameraPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CameraCubit>()..initializeCamera(),
      child: const CameraPreviewView(),
    );
  }
}

class CameraPreviewView extends StatelessWidget {
  const CameraPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: BlocConsumer<CameraCubit, CameraState>(
        listener: (context, state) {
          if (state is CameraError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CameraLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CameraReady) {
            return Column(
              children: [
                Expanded(
                  child: ClipRect(
                    child: CameraPreview(state.controller),
                  ),
                ),
                _buildControlBar(context),
              ],
            );
          } else if (state is CameraCaptureInProgress) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Capturing image...'),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to initialize camera'),
            );
          }
        },
      ),
    );
  }

  Widget _buildControlBar(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => context.read<CameraCubit>().toggleCamera(),
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 32),
          ),
          GestureDetector(
            onTap: () async {
              final imageFile = await context.read<CameraCubit>().takePicture();
              if (imageFile != null && context.mounted) {
                Navigator.of(context).pop(imageFile);
              }
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(5),
              ),
            ),
          ),
          const SizedBox(width: 32), // Balance layout
        ],
      ),
    );
  }
}
