// TODO add dependencies
// TODO add comment.g.dart as part

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  final id; 
  final postId;
  final name;
  final email;
  final body;
  
  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  static Map<String, dynamic> toJson(Comment comment) => _$CommentToJson(comment);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class



  final uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> comments = jsonDecode(response.body);
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  } else {
    throw Exception('Failed');
  }


  return [];
}
