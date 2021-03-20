import 'package:Postly/features/posts/domain/models/post_model.dart';

const PostModel postModel = PostModel(
  userId: 1,
  id: 2,
  title: 'qui est esse',
  body: 'est rerum tempore vitae',
);

const postJson = <String, dynamic>{
  "userId": 1,
  "id": 2,
  "title": "qui est esse",
  "body": "est rerum tempore vitae",
};

const List<PostModel> postsSample = [
  PostModel(id: 1, userId: 1, title: '1', body: '1'),
  PostModel(id: 2, userId: 2, title: '2', body: '2'),
];