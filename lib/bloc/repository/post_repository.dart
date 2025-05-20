import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practice/bloc/Model/post_model.dart';

class PostRepository {

  Future<List<PostModel>> fetchPost() async {
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if(response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        return body.map((e){
          return PostModel(
            postId: e['postId'] as int,
            body: e['body'] as String,
            email: e['email'] as String,
            id: e['id'] as int,
            name: e['name'] as String,
          );
        }).toList();
      }


    } on SocketException {
    throw Exception('error while fetching data');

    }
    on TimeoutException {
    throw Exception('error while fetching data');

    }
    throw Exception('error while fetching data');
  }

}