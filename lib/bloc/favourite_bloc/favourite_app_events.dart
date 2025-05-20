import 'package:equatable/equatable.dart';
import 'package:practice/bloc/Model/favourite_item_model.dart';


abstract class FavouriteEvents extends Equatable  {

  const FavouriteEvents();
  @override
 List<Object> get props => [];
}

class FetchFavouriteList extends FavouriteEvents {}

class FavouriteItem extends FavouriteEvents {
  final FavouriteItemModel item;
  const FavouriteItem({required this.item});
}

class SelectItem extends FavouriteEvents {
  final FavouriteItemModel item;
  const SelectItem({required this.item});
}

class UnSelectItem extends FavouriteEvents {
  final FavouriteItemModel item;
  const UnSelectItem({required this.item});
}

class DeleteItem extends FavouriteEvents {}

