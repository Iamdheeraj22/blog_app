import 'package:blog_app/features/blog/data/model/blog_hive_box_model.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});

  List<BlogModel> getLocalBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final BlogHiveBoxModel blogsBox;

  BlogLocalDataSourceImpl({required this.blogsBox});

  @override
  List<BlogModel> getLocalBlogs() {
    List<BlogModel> blogs = [];

    blogsBox.box.read(() {
      for (int i = 0; i < blogsBox.box.length; i++) {
        blogs.add(
          BlogModel.fromJson(
            blogsBox.box.get(
              i.toString(),
            ),
          ),
        );
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    blogsBox.box.clear();
    blogsBox.box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        blogsBox.box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
