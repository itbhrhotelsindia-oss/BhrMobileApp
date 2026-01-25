import 'package:bhrhotel/core/api_client.dart';
import '../model/blog_model.dart';

class BlogRepository {
  final ApiClient api;

  BlogRepository(this.api);

  Future<BlogModel> loadBlogs() async {
    final res = await api.get("/api/blog");
    return BlogModel.fromJson(res);
  }
}
