import 'package:bloc/bloc.dart';
import 'package:practice/bloc/Model/post_model.dart';
import 'package:practice/bloc/posts/posts_event.dart';
import 'package:practice/bloc/posts/posts_states.dart';
import 'package:practice/bloc/repository/post_repository.dart';
import 'package:practice/utils/enums.dart';

class PostsBloc  extends Bloc<PostsEvent,PostStates>{

  List<PostModel> temPostList = [];

  PostRepository postRepository = PostRepository();

PostsBloc():super(const PostStates()){
  on<PostFetched>(fetchPostApi);
  on<SearchItem>(_filterList);


}

void fetchPostApi(PostFetched event ,Emitter<PostStates> emit)async{
 await  postRepository.fetchPost().then((value){
    emit(state.copyWith(postStatus: PostStatus.success, message: 'success',
    postList: value
    ));
  }).onError((error, stackTrace){
    print(error);
    print(stackTrace);
    emit(state.copyWith(postStatus: PostStatus.failure, message:  error.toString()));
  });

}

void _filterList(SearchItem event ,Emitter<PostStates> emit)async{

  if(event.stSearch.isEmpty){
  emit(state.copyWith(temPostList: [] , searchMessage: ''));

  }else {
  // temPostList = state.postList.where((element) => element.email == event.stSearch.toString()).toList();
  temPostList = state.postList.where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toString())).toList();

  if(temPostList.isEmpty){
  emit(state.copyWith(temPostList: temPostList, searchMessage: 'No date found'));

  }else {
  emit(state.copyWith(temPostList: temPostList, searchMessage: ''));

  }

  }



}
  
}