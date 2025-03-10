import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm a');
    final String formattedDate = formatter.format(post.timestamp.toDate());
    return ListTile(
      title: Text(post.username),
      subtitle: Text(post.message),
      trailing: Text(formattedDate),
    );
  }
}
