
import 'package:ezycourse/app/components/reaction_button/comment_reaction_model.dart';
import 'package:ezycourse/app/models/post.dart';

class CommentModel {
  final int? id;
  final int? schoolId;
  final int? feedId;
  final int? userId;
  final int? replyCount;
  final int? likeCount;
  final String? commentText;
  final int? parentId;
  final String? createdAt;
  final String? updatedAt;
  final String? file;
  final int? privateUserId;
  final bool? isAuthorAndAnonymous;
  final String? gift;
  final int? sellerId;
  final int? giftedCoins;
  final List<CommentModel>? replies;
  final UserModel? user;
  final UserModel? privateUser;
  final List<dynamic>? totalLikes;
  final dynamic commentLike;
  final List<CommentReactionModel>? reactionTypes;

  CommentModel({
    this.id,
    this.schoolId,
    this.feedId,
    this.userId,
    this.replyCount,
    this.likeCount,
    this.commentText,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.privateUserId,
    this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    this.replies,
    this.user,
    this.privateUser,
    this.totalLikes,
    this.commentLike,
    this.reactionTypes,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int?,
      schoolId: map['school_id'] as int?,
      feedId: map['feed_id'] as int?,
      userId: map['user_id'] as int?,
      replyCount: map['reply_count'] as int?,
      likeCount: map['like_count'] as int?,
      commentText: map['comment_txt'] as String?,
      parentId: map['parrent_id'] as int?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      file: map['file'] as String?,
      privateUserId: map['private_user_id'] as int?,
      isAuthorAndAnonymous: (map['is_author_and_anonymous'] as int?) == 1,
      gift: map['gift'] as String?,
      sellerId: map['seller_id'] as int?,
      giftedCoins: map['gifted_coins'] as int?,
      replies: map['replies'] != null
          ? List<CommentModel>.from(
              map['replies'].map((item) => CommentModel.fromMap(item)),
            )
          : null,
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      privateUser:
          map['private_user'] != null ? UserModel.fromMap(map['private_user']) : null,
      totalLikes: map['totalLikes'] as List<dynamic>?,
      commentLike: map['commentlike'],
      reactionTypes: map['reaction_types'] != null
          ? List<CommentReactionModel>.from(
              map['reaction_types'].map((item) => CommentReactionModel.fromMap(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'school_id': schoolId,
      'feed_id': feedId,
      'user_id': userId,
      'reply_count': replyCount,
      'like_count': likeCount,
      'comment_txt': commentText,
      'parrent_id': parentId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'file': file,
      'private_user_id': privateUserId,
      'is_author_and_anonymous': isAuthorAndAnonymous == true ? 1 : 0,
      'gift': gift,
      'seller_id': sellerId,
      'gifted_coins': giftedCoins,
      'replies': replies?.map((item) => item.toMap()).toList(),
      'user': user?.toMap(),
      'private_user': privateUser?.toMap(),
      'totalLikes': totalLikes,
      'commentlike': commentLike,
      'reaction_types': replies?.map((item) => item.toMap()).toList(),
    };
  }
}
