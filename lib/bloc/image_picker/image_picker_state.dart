

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerStates  extends Equatable{

  final XFile? file;

const ImagePickerStates({
  this.file
});

ImagePickerStates copyWith({XFile? file}){
  return ImagePickerStates(
    file: file ?? this.file
  );
}

  @override
  // TODO: implement props
  List<Object?> get props => [file];

}