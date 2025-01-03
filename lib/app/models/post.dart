
import 'package:ezycourse/app/components/comment/comment_model.dart';

class PostModel {
  final int? id;
  final int? schoolId;
  final int? userId;
  final int? courseId;
  final int? communityId;
  final int? groupId;
  final String? feedTxt;
  final String? status;
  final String? slug;
  final String? title;
  final String? activityType;
  final int? isPinned;
  final String? fileType;
  final List<FileModel>? files;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final int? shareId;
  final Map<String, dynamic>? metaData;
  final String? createdAt;
  final String? updatedAt;
  final String? feedPrivacy;
  final int? isBackground;
  final String? bgColor;
  final int? pollId;
  final int? lessonId;
  final int? spaceId;
  final int? videoId;
  final int? streamId;
  final int? blogId;
  final String? scheduleDate;
  final String? timezone;
  final int? isAnonymous;
  final int? meetingId;
  final int? sellerId;
  final String? publishDate;
  final bool? isFeedEdit;
  final String? name;
  final String? pic;
  final int? uid;
  final int? isPrivateChat;
  final List<LikeTypeModel>? likeType;
  final dynamic poll;
  final UserModel? user;
  final dynamic like;
  final dynamic follow;
  final dynamic group;
  final dynamic savedPosts;
  final List<CommentModel>? comments;
  final Map<String, dynamic>? meta;

  PostModel({
    this.id,
    this.schoolId,
    this.userId,
    this.courseId,
    this.communityId,
    this.groupId,
    this.feedTxt,
    this.status,
    this.slug,
    this.title,
    this.activityType,
    this.isPinned,
    this.fileType,
    this.files,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.shareId,
    this.metaData,
    this.createdAt,
    this.updatedAt,
    this.feedPrivacy,
    this.isBackground,
    this.bgColor,
    this.pollId,
    this.lessonId,
    this.spaceId,
    this.videoId,
    this.streamId,
    this.blogId,
    this.scheduleDate,
    this.timezone,
    this.isAnonymous,
    this.meetingId,
    this.sellerId,
    this.publishDate,
    this.isFeedEdit,
    this.name,
    this.pic,
    this.uid,
    this.isPrivateChat,
    this.likeType,
    this.poll,
    this.user,
    this.like,
    this.follow,
    this.group,
    this.savedPosts,
    this.comments,
    this.meta,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      schoolId: map['school_id'],
      userId: map['user_id'],
      courseId: map['course_id'],
      communityId: map['community_id'],
      groupId: map['group_id'],
      feedTxt: map['feed_txt'],
      status: map['status'],
      slug: map['slug'],
      title: map['title'],
      activityType: map['activity_type'],
      isPinned: map['is_pinned'],
      fileType: map['file_type'],
      files: (map['files'] as List<dynamic>?)
          ?.map((file) => FileModel.fromMap(file as Map<String, dynamic>))
          .toList(),
      likeCount: map['like_count'],
      commentCount: map['comment_count'],
      shareCount: map['share_count'],
      shareId: map['share_id'],
      metaData: Map<String, dynamic>.from(map['meta_data'] ?? {}),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      feedPrivacy: map['feed_privacy'],
      isBackground: map['is_background'],
      bgColor: map['bg_color'],
      pollId: map['poll_id'],
      lessonId: map['lesson_id'],
      spaceId: map['space_id'],
      videoId: map['video_id'],
      streamId: map['stream_id'],
      blogId: map['blog_id'],
      scheduleDate: map['schedule_date'],
      timezone: map['timezone'],
      isAnonymous: map['is_anonymous'],
      meetingId: map['meeting_id'],
      sellerId: map['seller_id'],
      publishDate: map['publish_date'],
      isFeedEdit: map['is_feed_edit'],
      name: map['name'],
      pic: map['pic'],
      uid: map['uid'],
      isPrivateChat: map['is_private_chat'],
        likeType: map['likeType'] != null
        ? List<LikeTypeModel>.from(
            map['likeType'].map((item) => LikeTypeModel.fromMap(item)),
          )
        : null,
      poll: map['poll'],
      user: map['user'] != null ? UserModel.fromMap(Map<String, dynamic>.from(map['user'])) : null,
      like: map['like'],
      follow: map['follow'],
      group: map['group'],
      savedPosts: map['savedPosts'],
      comments: (map['comments'] as List<dynamic>?)
          ?.map((file) => CommentModel.fromMap(file as Map<String, dynamic>))
          .toList(),
      meta: Map<String, dynamic>.from(map['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'school_id': schoolId,
      'user_id': userId,
      'course_id': courseId,
      'community_id': communityId,
      'group_id': groupId,
      'feed_txt': feedTxt,
      'status': status,
      'slug': slug,
      'title': title,
      'activity_type': activityType,
      'is_pinned': isPinned,
      'file_type': fileType,
      'files': files?.map((file) => file.toMap()).toList(),
      'like_count': likeCount,
      'comment_count': commentCount,
      'share_count': shareCount,
      'share_id': shareId,
      'meta_data': metaData,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'feed_privacy': feedPrivacy,
      'is_background': isBackground,
      'bg_color': bgColor,
      'poll_id': pollId,
      'lesson_id': lessonId,
      'space_id': spaceId,
      'video_id': videoId,
      'stream_id': streamId,
      'blog_id': blogId,
      'schedule_date': scheduleDate,
      'timezone': timezone,
      'is_anonymous': isAnonymous,
      'meeting_id': meetingId,
      'seller_id': sellerId,
      'publish_date': publishDate,
      'is_feed_edit': isFeedEdit,
      'name': name,
      'pic': pic,
      'uid': uid,
      'is_private_chat': isPrivateChat,
      'likeType': likeType?.map((item) => item.toMap()).toList(),
      'poll': poll,
      'user': user?.toMap(),
      'like': like,
      'follow': follow,
      'group': group,
      'savedPosts': savedPosts,
      'comments': comments?.map((item) => item.toMap()).toList(),
      'meta': meta,
    };
  }
}

class FileModel {
  String? fileLoc;
  String? originalName;
  String? extname;
  String? type;
  int? size;

  FileModel({
    this.fileLoc,
    this.originalName,
    this.extname,
    this.type,
    this.size,
  });

  // Factory constructor to create an instance from a map
  factory FileModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return FileModel();
    return FileModel(
      fileLoc: map['fileLoc'] as String?,
      originalName: map['originalName'] as String?,
      extname: map['extname'] as String?,
      type: map['type'] as String?,
      size: map['size'] as int?,
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'fileLoc': fileLoc,
      'originalName': originalName,
      'extname': extname,
      'type': type,
      'size': size,
    };
  }
}


class UserModel {
  final int? id;
  final String? fullName;
  final String? profilePic;
  final int? isPrivateChat;
  final String? expireDate;
  final String? status;
  final String? pauseDate;
  final String? userType;
  final Map<String, dynamic>? meta;

  UserModel({
    this.id,
    this.fullName,
    this.profilePic,
    this.isPrivateChat,
    this.expireDate,
    this.status,
    this.pauseDate,
    this.userType,
    this.meta,
  });

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return UserModel();
    return UserModel(
      id: map['id'] as int?,
      fullName: map['full_name'] as String?,
      profilePic: map['profile_pic'] as String?,
      isPrivateChat: map['is_private_chat'] as int?,
      expireDate: map['expire_date'] as String?,
      status: map['status'] as String?,
      pauseDate: map['pause_date'] as String?,
      userType: map['user_type'] as String?,
      meta: map['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'is_private_chat': isPrivateChat,
      'expire_date': expireDate,
      'status': status,
      'pause_date': pauseDate,
      'user_type': userType,
      'meta': meta,
    };
  }
}


class LikeTypeModel {
  final String? reactionType;
  final int? feedId;
  final Map<String, dynamic>? meta;

  LikeTypeModel({
    this.reactionType,
    this.feedId,
    this.meta,
  });

  factory LikeTypeModel.fromMap(Map<String, dynamic> map) {
    return LikeTypeModel(
      reactionType: map['reaction_type'] as String?,
      feedId: map['feed_id'] as int?,
      meta: map['meta'] != null ? Map<String, dynamic>.from(map['meta']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reaction_type': reactionType,
      'feed_id': feedId,
      'meta': meta,
    };
  }
}
