// api.dart
import 'dart:convert';
import 'package:CoachZiad/model/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  Future<List<BlogPost>> fetchBlogPosts(int page, {String? token}) async {
    final Uri url =
        Uri.parse('http://3.223.187.125:8022/api/v1/trainee/blog?page=$page');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print('response.statusCode blog ${response.statusCode}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> postsJson = data['data'];
      print('kjkkkkkkkkkkkkkkkkkkkk');
      print(postsJson);
      return postsJson.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }
}
