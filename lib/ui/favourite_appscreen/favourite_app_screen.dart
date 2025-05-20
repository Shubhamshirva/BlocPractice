import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/Model/favourite_item_model.dart';
import 'package:practice/bloc/favourite_bloc/favourite_app_bloc.dart';
import 'package:practice/bloc/favourite_bloc/favourite_app_events.dart';
import 'package:practice/bloc/favourite_bloc/favourite_app_states.dart';

class FavouriteAppscreen extends StatefulWidget {
  const FavouriteAppscreen({super.key});

  @override
  State<FavouriteAppscreen> createState() => _FavouriteAppscreenState();
}

class _FavouriteAppscreenState extends State<FavouriteAppscreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Fav App"),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteItemStates>(
            builder: (context, state) {
              return Visibility(
                visible:  state.tempfavouriteItemList.isNotEmpty ? true : false,
                child: IconButton(onPressed: () {
                  context.read<FavouriteBloc>().add(DeleteItem());
                
                },
                 icon: Icon(Icons.delete, color: Colors.red,)),
              );
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FavouriteBloc, FavouriteItemStates>(builder: (context,state) {
          switch(state.litStatus) {
            case ListStatus.loading:
            return Center(child: const CircularProgressIndicator());
            case ListStatus.failure:
            return const Text("something went wrong");
            case ListStatus.success:
             return ListView.builder(
            itemCount: state.favouriteItemList.length,
            itemBuilder: (context,index) {
              final item = state.favouriteItemList[index];
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: state.tempfavouriteItemList.contains(item) ? true : false, 
                    onChanged: (value) {
                      if (value!) {
                        context.read<FavouriteBloc>().add(SelectItem(item: item));

                      } else {
                        context.read<FavouriteBloc>().add(UnSelectItem(item: item));


                      }

                  }),
                  title: Text(item.value.toString()),
                  trailing: IconButton(onPressed: () {
                    FavouriteItemModel itemModel = FavouriteItemModel(
                      id: item.id, 
                      value: item.value,
                      isFavourite:  item.isFavourite ? false : true,


                      );
                    context.read<FavouriteBloc>().add(FavouriteItem(item: itemModel));
                  },
                   icon: 
                  item.isFavourite ? Icon(Icons.favorite_outlined)
                  :
                  Icon(Icons.favorite_outline)),
                ),
              );
        
          });
            
        
          }
         
        }),
      ),
    );
  }
}