import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';
import '../../services/firestore_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FirestoreService _firestoreService;

  PostBloc(this._firestoreService) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<PostsUpdated>(_onPostsUpdated);
    on<AddPost>(_onAddPost);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) {
    emit(PostLoading());
    _firestoreService.getPosts().listen(
      (posts) {
        add(PostsUpdated(posts));
      },
    );
  }

  void _onPostsUpdated(PostsUpdated event, Emitter<PostState> emit) {
    emit(PostLoaded(event.posts));
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    try {
      await _firestoreService.savePost(event.message);
      // Optionally, you can reload posts after adding a new post
      add(LoadPosts());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
