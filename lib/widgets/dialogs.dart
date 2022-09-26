import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/api_response.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionDialog extends StatelessWidget {
  const ImageSelectionDialog({Key? key, required this.onPickImage})
      : super(key: key);
  final void Function(ImageSource) onPickImage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: const Text('SELECT'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPickImage(ImageSource.gallery);
              },
              child: const Text('GALLERY')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPickImage(ImageSource.camera);
              },
              child: const Text('CAMERA'))
        ],
      ),
    );
  }
}

class ResultsDialog extends StatelessWidget {
  const ResultsDialog({Key? key, required this.response}) : super(key: key);
  final ApiResponse response;

  @override
  Widget build(BuildContext context) {
    String confidence = '${(response.confidence * 100).toStringAsFixed(2)}%';
    return AlertDialog(
      title: const Text('Results'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: 'Result: ',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                      text: response.className,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400))
                ]),
          ),
          RichText(
            text: TextSpan(
                text: 'Confidence: ',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                      text: confidence,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400))
                ]),
          )
        ],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Error'),
      content: Text('Error getting prediction'),
    );
  }
}
