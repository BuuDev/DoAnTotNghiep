part of 'profile_info.dart';

class ProfileLogic with ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  XFile? images;
  Future<void> getSingleImage() async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    images = selectedImages;
    notifyListeners();
  }
}
