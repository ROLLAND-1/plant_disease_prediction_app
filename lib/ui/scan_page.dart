import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/widgets/dialogs.dart';
import 'package:image_picker/image_picker.dart';

import '../enums/plant_type.dart';
import '../service/api_service.dart';
import '../service/file_picker_service.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late PlantType _plantType;
  File? _image;
  late bool _isLoading;

  void onPlantTypeChanged(PlantType? plantType) {
    setState(() {
      _plantType = plantType ?? _plantType;
    });
  }

  @override
  void initState() {
    super.initState();
    _plantType = PlantType.values.first;
    _isLoading = false;
  }

  void _onSelectImage() {
    showDialog(
        context: context,
        builder: (_) => ImageSelectionDialog(
              onPickImage: onPickImage,
            ));
  }

  void _onPredict() async {
    setState(() {
      _isLoading = true;
    });
    var res = await ApiService.instance.getPrediction(_image!, _plantType);
    setState(() {
      _isLoading = false;
    });
    if (res == null) {
      showDialog(context: context, builder: (_) => const ErrorDialog());
      return;
    }
    showDialog(context: context, builder: (_) => ResultsDialog(response: res));
  }

  void onPickImage(ImageSource source) async {
    var res = await FilePicker.instance.pickImage(source);
    if (res != null) {
      setState(() {
        _image = File(res.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('favorite');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<PlantType>(
                        hint: const Text('Select a plant type'),
                        value: _plantType,
                        items: PlantType.values
                            .map((e) => DropdownMenuItem<PlantType>(
                                  value: e,
                                  child: Text(e.name),
                                ))
                            .toList(),
                        onChanged: onPlantTypeChanged),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: _onSelectImage,
                      child: Image.asset(
                        'assets/images/code-scan.png',
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tap to Select image for prediction',
                      style: TextStyle(
                        color: Constants.primaryColor.withOpacity(.80),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: size.height * .3,
                      color: Colors.black12,
                      child: Center(
                        child: _image == null
                            ? const Text('Please select an image')
                            : Image.file(
                                _image!,
                                height: size.height * .3,
                                width: double.infinity,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: _image == null ? null : _onPredict,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text('MAKE A PREDICTION'))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
