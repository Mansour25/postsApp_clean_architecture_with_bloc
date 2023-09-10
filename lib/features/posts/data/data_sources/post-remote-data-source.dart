import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/core/error/exeption.dart';
import 'package:posts_clean_arcitecture/features/posts/data/models/post-model.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/posts.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const baseUrl = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImp extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp(this.client);

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response =
        await client.post(Uri.parse('$baseUrl/posts/'), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client
        .delete(Uri.parse('$baseUrl/posts/${id.toString()}'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson.map<PostModel>(
        (postModel) {
          // Post post = Post(
          //     title: postModel['title'],
          //     body: postModel['body'],
          //     id: postModel['id']);
          // return post ;
          print(postModel['id']);
          return PostModel.fromJson(postModel);
        },
      ).toList();
      print('%%%%%%%%%%%%');
      print(postModels);
      return postModels;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();

    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response = await client.patch(
      Uri.parse('$baseUrl/pots/$postId'),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }
}
