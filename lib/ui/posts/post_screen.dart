import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/posts/posts_bloc.dart';
import 'package:practice/bloc/posts/posts_event.dart';
import 'package:practice/bloc/posts/posts_states.dart';
import 'package:practice/utils/enums.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsBloc>().add(PostFetched()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        title:  Text('Post Apis'),
      ),
      body: BlocBuilder<PostsBloc,PostStates>(
        builder: (context,state){
          switch(state.postStatus){
            case PostStatus.loading:
            return Center(child: CircularProgressIndicator());
              case PostStatus.failure:
            return Center(child: Text(state.message.toString()));
              case PostStatus.success:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search with email",
                        border: OutlineInputBorder()
                      ),
                      onChanged: (filterKey){
                         context.read<PostsBloc>().add(SearchItem(filterKey));
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: state.searchMessage.isNotEmpty?
                     Center(child: Text(state.searchMessage.toString()))
                     : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.temPostList.isEmpty ? state.postList.length : state.temPostList.length,
                      itemBuilder: (context, index){
                        if(state.temPostList.isNotEmpty) {
                           final item = state.temPostList[index];
                              return SingleChildScrollView(
                                child: Card(
                                  child: ListTile(
                                    title: Text(item.email.toString()),
                                    subtitle: Text(item.body.toString()),
                                                      
                                                      
                                  ),
                                ),
                              );

                        }else {
                           final item = state.postList[index];
                              return Card(
                                child: ListTile(
                                  title: Text(item.email.toString()),
                                  subtitle: Text(item.body.toString()),
                                                    
                                                    
                                ),
                              );

                        }
                       
                            }),
                  ),
                ],
              );
          }
     
      }),
    );
  }
}