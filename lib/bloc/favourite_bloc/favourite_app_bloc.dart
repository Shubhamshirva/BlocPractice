import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/Model/favourite_item_model.dart';
import 'package:practice/bloc/favourite_bloc/favourite_app_events.dart';
import 'package:practice/bloc/favourite_bloc/favourite_app_states.dart';
import 'package:practice/bloc/repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvents, FavouriteItemStates> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempfavouriteList = [];

  FavouriteRepository favouriteRepository;

  FavouriteBloc(this.favouriteRepository) : super(const FavouriteItemStates()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem>(_deleteItem);
  }

  void fetchList(
    FetchFavouriteList event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success,
      ),
    );
  }

  void _addFavouriteItem(
    FavouriteItem event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    final index = favouriteList.indexWhere(
      (element) => element.id == event.item.id,
    );

    if (event.item.isFavourite) {
      if (tempfavouriteList.contains(favouriteList[index])) {
        tempfavouriteList.remove(favouriteList[index]);
        tempfavouriteList.add(event.item);
      }
    } else {
      if (tempfavouriteList.contains(favouriteList[index])) {
        tempfavouriteList.remove(favouriteList[index]);
        tempfavouriteList.add(event.item);
      }
    }

    favouriteList[index] = event.item;

    emit(state.copyWith(favouriteItemList: List.from(favouriteList), 
    tempfavouriteItemList:  List.from(tempfavouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteItemStates> emit) async {
    tempfavouriteList.add(event.item);
    emit(state.copyWith(tempfavouriteItemList: List.from(tempfavouriteList)));
  }

  void _unSelectItem(
    UnSelectItem event,
    Emitter<FavouriteItemStates> emit,
  ) async {
    tempfavouriteList.remove(event.item);
    emit(state.copyWith(tempfavouriteItemList: List.from(tempfavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteItemStates> emit) async {
    for (int i = 0; i < tempfavouriteList.length; i++) {
      favouriteList.remove(tempfavouriteList[i]);
    }
    tempfavouriteList.clear();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempfavouriteItemList: List.from(tempfavouriteList),
      ),
    );
  }
}
