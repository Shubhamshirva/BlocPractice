
import 'package:equatable/equatable.dart';
import 'package:practice/bloc/Model/favourite_item_model.dart';

enum ListStatus {loading ,success ,failure}

class FavouriteItemStates extends Equatable {

  final List<FavouriteItemModel> favouriteItemList ;
  final List<FavouriteItemModel> tempfavouriteItemList ;

  final ListStatus litStatus;

  const FavouriteItemStates( {
    this.favouriteItemList = const [],
    this.tempfavouriteItemList = const [],
    this.litStatus = ListStatus.loading,
  }
);

FavouriteItemStates copyWith ({List<FavouriteItemModel>? favouriteItemList ,List<FavouriteItemModel>? tempfavouriteItemList, ListStatus? listStatus}) {
  return FavouriteItemStates(
    favouriteItemList: favouriteItemList ?? this.favouriteItemList,
    tempfavouriteItemList: tempfavouriteItemList ?? this.tempfavouriteItemList,
    litStatus: listStatus ?? this.litStatus,
  );
}

  @override
  // TODO: implement props
  List<Object?> get props =>  [favouriteItemList, tempfavouriteItemList, litStatus];

} 