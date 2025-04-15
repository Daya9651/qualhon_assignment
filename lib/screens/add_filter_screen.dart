import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/filtered_image.dart';
import '../providers/navigation_provider.dart';


class AddFilterScreen extends StatefulWidget {
  @override
  State<AddFilterScreen> createState() => _AddFilterScreenState();
}

class _AddFilterScreenState extends State<AddFilterScreen> {
  late List<File> selectedImages;
  int currentFilterIndex = 0;
  String? selectedAudioPath;

  final List<ColorFilter?> filters = [
    null, // Original
    ColorFilter.mode(Colors.grey, BlendMode.saturation),
    ColorFilter.mode(Colors.amber, BlendMode.modulate),
    ColorFilter.mode(Colors.blue, BlendMode.color),
    ColorFilter.mode(Colors.purple, BlendMode.color),
  ];

  final List<String> filterNames = ["Original", "Grayscale", "Sepia", "Blue", "Purple"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<File>) {
      selectedImages = args;
    } else {
      selectedImages = [];
    }
  }

  void _applyFilter(int index) {
    setState(() {
      currentFilterIndex = index;
    });
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedAudioPath = result.files.single.path!;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected audio: ${result.files.single.name}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ColorFiltered(
                      colorFilter: filters[currentFilterIndex] ?? ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                      child: Image.file(
                        selectedImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filters.length, (index) {
                  return GestureDetector(
                    onTap: () => _applyFilter(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: ClipOval(
                              child: ColorFiltered(
                                colorFilter: filters[index] ?? ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                                child: Image.file(
                                  selectedImages.first,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(filterNames[index], style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          CircleAvatar(
            radius: 30,
            child: IconButton(
              onPressed: _pickAudio,
              icon: Icon(Icons.music_note_outlined),
            ),
          ),
          SizedBox(height: 290),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.purple,
                ),
                child: TextButton(
                  onPressed: () {
                    final filteredList = selectedImages.map(
                          (img) => FilteredImage(image: img, filterIndex: currentFilterIndex),
                    ).toList();

                    Navigator.pushNamed(
                      context,
                      '/preview',
                      arguments: filteredList,
                    );
                  },
                  child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
