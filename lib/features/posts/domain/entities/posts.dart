import 'package:equatable/equatable.dart';

// هذه الطبقة التي اتعامل بها مع presentation
// هذا الملف نسخة مصغرة عن model
// دوال ال toMap & FromMap توجد في المودل
class Post extends Equatable {
  // ستكون null فقط في حالة add-post
  final int? id;
  final String title;
  final String body;

  const Post({
     this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}
