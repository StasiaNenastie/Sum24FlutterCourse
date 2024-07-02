// TODO add dependencies +
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });


  factory Post.fromJson(Map<String, dynamic> json) {
    final userId = json['userId'] as int;
    final id = json['id'] as int;
    final title = json['title'] as String;
    final body = json['body'] as String;
    return Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
    }
  

  factory Post.toJson(Post post) {
    return Post(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class

  final uri = Uri.parse('http://jsonplaceholder.typicode.com/posts');
  final response = await http.get(uri);


  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    return posts.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed');
  }

  return [];
}
