import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.updatedAt,
    required super.topics,
    super.posterName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      posterId: json['poster_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at']),
      topics: List<String>.from(json['topics'] ?? []),
      posterName: json['poster_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'poster_id': super.posterId,
      'title': super.title,
      'content': super.content,
      'image_url': super.imageUrl,
      'updated_at': super.updatedAt.toIso8601String(),
      'topics': super.topics,
    };
  }

  //copyWith method
  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? updatedAt,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? super.id,
      posterId: posterId ?? super.posterId,
      title: title ?? super.title,
      content: content ?? super.content,
      imageUrl: imageUrl ?? super.imageUrl,
      updatedAt: updatedAt ?? super.updatedAt,
      topics: topics ?? super.topics,
      posterName: posterName ?? super.posterName,
    );
  }
}
