import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {

final ImagePicker _picker = ImagePicker();


// Future<XFile?>cameraCapture()async{
//   final XFile? file = await  _picker.pickImage(source: ImageSource.camera);
//   return file;
// }

Future<XFile?> cameraCapture() async {
  // Capture image from camera
  final XFile? file = await _picker.pickImage(source: ImageSource.camera);

  if (file != null) {
    // Crop the image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
        ),
       IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
      ],
    );

    if (croppedFile != null) {
      return XFile(croppedFile.path);
    }
  }
  
  return file; // Return original file if cropping was skipped
}

Future<XFile?> pickImageFromGallery() async {
  // Capture image from camera
  final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

  if (file != null) {
    // Crop the image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      
      uiSettings: [
         AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
        ),
       IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
      ],
    );

    if (croppedFile != null) {
      return XFile(croppedFile.path);
    }
  }
  
  return file; // Return original file if cropping was skipped
}


// Future<XFile?> pickImageFromGallery()async{
//   final XFile? file = await  _picker.pickImage(source: ImageSource.gallery);
//   return file;
// }

}