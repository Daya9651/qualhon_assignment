import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageScreens extends StatefulWidget {
  const SelectImageScreens({super.key});

  @override
  State<SelectImageScreens> createState() => _SelectImageScreensState();
}

class _SelectImageScreensState extends State<SelectImageScreens> {
  final List<File> _selectedImages = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _selectedImages.add(File(photo.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("New Post", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/add_filter',
                arguments: _selectedImages,
              );
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.purple, fontSize: 20),
            ),
          ),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Image.file(
                          _selectedImages[index],
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, ),
                            onPressed: () {
                              setState(() {
                                _pickImageFromCamera();
                              });
                            },
                          ),
                        )
                      ]
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 420,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Text("Post"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text("Reel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
