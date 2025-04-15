import 'package:flutter/material.dart';
import '../model/filtered_image.dart';

class PreviewPostScreen extends StatefulWidget {
  @override
  State<PreviewPostScreen> createState() => _PreviewPostScreenState();
}

class _PreviewPostScreenState extends State<PreviewPostScreen> {
  late List<FilteredImage> selectedImages;
  int currentFilterIndex = 0;


  final List<ColorFilter?> filters = [
    null, // Original
    ColorFilter.mode(Colors.grey, BlendMode.saturation),
    ColorFilter.mode(Colors.amber, BlendMode.modulate),
    ColorFilter.mode(Colors.blue, BlendMode.color),
    ColorFilter.mode(Colors.purple, BlendMode.color),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<FilteredImage>) {
      selectedImages = args;
    } else {
      selectedImages = [];
    }
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8), // Adjust viewportFraction to show part of the next image
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ColorFiltered(
                      colorFilter: filters[selectedImages[index].filterIndex] ?? ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.file(
                          selectedImages[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 400),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.purple,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/new_post',
                    arguments: selectedImages, // Pass the selected images
                  );
                },
                child: Text("Share", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
