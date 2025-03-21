part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {}

class PostsUpdated extends PostEvent {
  final List<Post> posts;

  const PostsUpdated(this.posts);

  @override
  List<Object> get props => [posts];
}

class AddPost extends PostEvent {
  final String message;

  const AddPost(this.message);

  @override
  List<Object> get props => [message];
}
