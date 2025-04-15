import 'package:flutter/material.dart';
import '../model/filtered_image.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late List<FilteredImage> selectedImages;

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
        title: Text("Shared Post", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.person, size: 35),
                ),
                Text("  John Karter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PageView.builder(
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.file(
                        selectedImages[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, ),
            child: Row(
              children: [
                Text("2 min ago", style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 450,)

        ],
      ),
      
    );
  }
}