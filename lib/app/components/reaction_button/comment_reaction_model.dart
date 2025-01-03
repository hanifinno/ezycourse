class CommentReactionModel {
  String? id;
  String? post_id;
  String? post_single_item_id;
  String? user_id;
  String? comment_id;
  String? comment_replies_id;
  String? reaction_type;
  int? v;
  CommentReactionModel({
    this.id,
    this.post_id,
    this.post_single_item_id,
    this.user_id,
    this.comment_id,
    this.comment_replies_id,
    this.reaction_type,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post_id': post_id,
      'post_single_item_id': post_single_item_id,
      'user_id': user_id,
      'comment_id': comment_id,
      'comment_replies_id': comment_replies_id,
      'reaction_type': reaction_type,
      'v': v,
    };
  }

  factory CommentReactionModel.fromMap(Map<String, dynamic> map) {
    return CommentReactionModel(
      id: map['id'] != null ? map['id'] as String : null,
      post_id: map['post_id'] != null ? map['post_id'] as String : null,
      post_single_item_id: map['post_single_item_id'] != null
          ? map['post_single_item_id'] as String
          : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      comment_id:
          map['comment_id'] != null ? map['comment_id'] as String : null,
      comment_replies_id: map['comment_replies_id'] != null
          ? map['comment_replies_id'] as String
          : null,
      reaction_type:
          map['reaction_type'] != null ? map['reaction_type'] as String : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  @override
  String toString() {
    return 'CommentReaction(id: $id, post_id: $post_id, post_single_item_id: $post_single_item_id, user_id: $user_id, comment_id: $comment_id, comment_replies_id: $comment_replies_id, reaction_type: $reaction_type, v: $v)';
  }
}
