import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isloading = true;

  File? _image;
  List? _output;
  final _picker = ImagePicker();

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output;
      _isloading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  pickImageCam() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
    }

    detectImage(_image!);
  }

  pickImageGal() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
    }

    detectImage(_image!);
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text("Faiz Project"),
            const SizedBox(height: 5),
            const Text(
              "Cats & Dog Detector",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            _isloading
                ? const Center(
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: Icon(Icons.camera_alt_sharp),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        child: _image == null
                            ? const Icon(Icons.camera_alt_sharp)
                            : Image.file(_image!),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Confident ${_output![0]['confidence'] * 100}%",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _output != null
                          ? Text(
                              _output![0]['index'] == 1 ? 'ANJING' : 'KUCING',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(),
                    ],
                  ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickImageCam();
                  },
                  child: const Text("capture a photo"),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImageGal();
                  },
                  child: const Text("select a photo"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
