

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/bloc/image_picker/image_picker_event.dart';
import 'package:practice/bloc/image_picker/image_picker_state.dart';
import 'package:practice/utils/image_picker_utils.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerStates>{
  
final ImagePickerUtils imagePickerUtils;

 ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerStates()){
  on<CameraCapture>(cameraCapture);
  on<GalleryImagePicker>(gallerypickimage);
   on<RemoveImage>(_onRemoveImage);
}

void cameraCapture(CameraCapture event, Emitter<ImagePickerStates> states)async{
  XFile ? file = await imagePickerUtils.cameraCapture();
  emit(state.copyWith(file: file));
}

void gallerypickimage(GalleryImagePicker event, Emitter<ImagePickerStates> states)async{
  XFile ? file = await imagePickerUtils.pickImageFromGallery();
  emit(state.copyWith(file: file));
}

void _onRemoveImage(RemoveImage event, Emitter<ImagePickerStates> emit) {
    emit(ImagePickerStates(file: null)); // Set file to null to remove the image
  }

}