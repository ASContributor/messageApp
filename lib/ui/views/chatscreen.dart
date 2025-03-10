import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/blocs/auth/auth_bloc.dart';

import '../../blocs/post/post_bloc.dart';
import '../widgets/post_widget.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Chat Screen'), actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
          },
        ),
      ]),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthUnauthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (_) => false);
                }
              },
              builder: (context, state) {
                return BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PostLoaded) {
                      return ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return PostWidget(
                            post: state.posts[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: Text(
                              'Something went wrong! ${state.toString()}'));
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = messageController.text;
                    if (message.isNotEmpty) {
                      BlocProvider.of<PostBloc>(context).add(AddPost(message));
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
