import 'package:scoped_model/scoped_model.dart';
import '../models/ocr_results.dart';

class ImageModel extends Model {
  ImageModel(this._images);

  ImageOCR _images;
  int _selectedImageIndex;

  ImageOCR get images => _images;
  int get selectedImageIndex => _selectedImageIndex;

  // ! TODO Unused for now!
}