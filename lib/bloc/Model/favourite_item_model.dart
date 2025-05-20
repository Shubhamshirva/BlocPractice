

import 'package:equatable/equatable.dart';

class FavouriteItemModel  extends Equatable{

 const FavouriteItemModel({
  required this.id,
  required this.value,
  this.isDeleting =  false,
  this.isFavourite = false,
 });

 final String id;
 final String value;
 final bool isDeleting;
 final bool isFavourite;

 FavouriteItemModel copywith({String? id, String? value, bool? isDeleting,bool? isFavourite}) {
  return FavouriteItemModel(
    id: id  ?? this.id, 
    value: value ?? this.value,
    isDeleting: isDeleting ?? this.isDeleting,
    isFavourite: isFavourite ?? this.isFavourite
    );
 }

 
  @override
  // TODO: implement props
  List<Object?> get props =>  [id,value,isFavourite,isDeleting];
}