// lib/models/filtered_image.dart
import 'dart:io';

class FilteredImage {
  final File image;
  final int filterIndex;

  FilteredImage({required this.image, required this.filterIndex});
}
