import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart'; // For camera permissions

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // Initialize camera
  }

  // Request camera permission and initialize the camera
  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0], // Use the first camera (usually the back camera)
          ResolutionPreset.high, // Set high resolution for the camera feed
        );
        _initializeControllerFuture = _controller.initialize();
        _initializeControllerFuture.then((_) {
          if (mounted) {
            setState(() {
              _isCameraInitialized = true;
            });
          }
        }).catchError((e) {
          if (mounted) {
            setState(() {
              _errorMessage = "Error initializing camera: $e";
            });
          }
        });
      } else {
        setState(() {
          _errorMessage = "No cameras available.";
        });
      }
    } else {
      setState(() {
        _errorMessage = "Camera permission denied.";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the camera when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Camera Feed'),
        backgroundColor: Colors.blue,
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
          : _isCameraInitialized
              ? CameraPreview(_controller) // Show camera preview once initialized
              : Center(child: CircularProgressIndicator()), // Loading while initializing
    );
  }
}
