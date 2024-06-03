import 'package:camera/camera.dart';
import 'package:fc_teams_drawer/app/core/services/shared.dart';
import 'package:fc_teams_drawer/app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late List<CameraDescription> _cameras;
  late CameraController _controller;

  Future<void> _getAvailableCameras() async {
    _cameras = await availableCameras();
    _configureCamera();
  }

  void _configureCamera() {

    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });

  }

  Future<void> _initializeCameraController( CameraDescription cameraDescription ) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        CustomSnackBar(messageKey: 'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
          cameraController.getMinExposureOffset().then(
                  (double value) => _minAvailableExposureOffset = value),
          cameraController
              .getMaxExposureOffset()
              .then((double value) => _maxAvailableExposureOffset = value)
        ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          CustomSnackBar(messageKey: 'You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
          CustomSnackBar(messageKey: 'Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
        // iOS only
          CustomSnackBar(messageKey: 'Camera access is restricted.');
        case 'AudioAccessDenied':
          CustomSnackBar(messageKey: 'You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
          CustomSnackBar(messageKey: 'Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
        // iOS only
          CustomSnackBar(messageKey: 'Audio access is restricted.');
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showCameraException(CameraException e) {
    SharedServices.logError(e.code, e.description);
    CustomSnackBar(messageKey: 'Error: ${e.code}\n${e.description}');
  }

  @override
  void initState() {
    super.initState();
    _getAvailableCameras();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {

    final CameraController cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if ( !cameraController.value.isInitialized ) {
      return;
    }

    if ( state == AppLifecycleState.inactive ) {
      cameraController.dispose();
    } else if ( state == AppLifecycleState.resumed ) {
      _initializeCameraController(cameraController.description);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if ( !_controller.value.isInitialized ) {
      return Container();
    }

    return const Placeholder();
  }
}
