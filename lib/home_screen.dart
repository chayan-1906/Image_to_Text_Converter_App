import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = '';
  File? image;
  Future<File>? imageFile;
  ImagePicker? imagePicker;

  _pickImageGallery() async {
    PickedFile? _pickedFile =
        await imagePicker!.getImage(source: ImageSource.gallery);
    image = File(_pickedFile!.path);
    setState(() {
      image;
      // do the image labelling - extract text from image
      _performImageLabelling();
    });
  }

  _captureImageCamera() async {
    PickedFile? _pickedFile =
        await imagePicker!.getImage(source: ImageSource.camera);
    image = File(_pickedFile!.path);
    setState(() {
      image;
      // do the image labelling - extract text from image
      _performImageLabelling();
    });
  }

  _performImageLabelling() async {
    final FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    VisionText visionText =
        await textRecognizer.processImage(firebaseVisionImage);
    result = '';
    setState(() {
      for (TextBlock block in visionText.blocks) {
        final String text = block.text;
        for (TextLine textLine in block.lines) {
          for (TextElement textElement in textLine.elements) {
            result += textElement.text + ' ';
          }
        }
        result += '\n\n';
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 280.0,
                  width: 250.0,
                  margin: const EdgeInsets.only(top: 70.0),
                  padding: const EdgeInsets.only(
                      left: 28.0, bottom: 5.0, right: 18.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/note.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        result,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.getFont(
                          'Source Serif Pro',
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                Container(
                  margin: const EdgeInsets.only(top: 20.0, right: 140.0),
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/pin.png',
                              height: 240.0,
                              width: 240.0,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: FlatButton(
                          onPressed: () {
                            _pickImageGallery();
                          },
                          onLongPress: () {
                            _captureImageCamera();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 25.0),
                            child: image != null
                                ? Image.file(
                                    image!,
                                    width: 140.0,
                                    height: 192.0,
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                                    width: 240.0,
                                    height: 200.0,
                                    child: const Icon(
                                      Icons.camera_front_rounded,
                                      size: 100.0,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
