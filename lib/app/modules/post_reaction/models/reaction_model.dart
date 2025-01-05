class ReactionModel {
  int? totalLikes;
  String? reactionType;
  Map<String, dynamic>? meta;

  ReactionModel({
    this.totalLikes,
    this.reactionType,
    this.meta,
  });

  // fromMap method
  factory ReactionModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return ReactionModel();

    return ReactionModel(
      totalLikes: map['total_likes'] as int?,
      reactionType: map['reaction_type'] as String?,
      meta: map['meta'] as Map<String, dynamic>?,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'total_likes': totalLikes,
      'reaction_type': reactionType,
      'meta': meta,
    };
  }
}
