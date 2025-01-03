// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';


import 'educational_work_place.dart';
import 'email_list_model.dart';
import 'gender.dart';
import 'phone_list_model.dart';
import 'privacy_model.dart';
import 'user_work_place.dart';
import 'websites.dart';

class ProfileModel {
  String? id;
  String? first_name;
  String? last_name;
  String? present_town;
  String? username;
  String? email;
  String? phone;
  String? password;
  String? profile_pic;
  String? cover_pic;
  String? user_status;
  GenderModel? gender;
  String? religion;
  String? date_of_birth;
  String? user_bio;
  String? passport;
  String? last_login;
  String? user_2fa_status;
  String? secondary_email;
  String? recovery_email;
  String? relation_status;
  String? home_town;
  String? birth_place;
  String? blood_group;
  String? reset_password_token;
  String? reset_password_token_expires;
  String? user_role;
  String? status;
  String? ip_address;
  String? created_by;
  String? update_by;
  String? createdAt;
  String? updatedAt;
  String? v;
  String? lock_profile;
  List<EmailListModel>? email_list = [];
  List<PhoneListModel>? phone_list = [];
  List<LanguageModel>? language = [];
  List<Websites>? websites = [];
  String? user_about;
  String? user_nickname;
  List<EducationalWorkPlace>? educationWorkplaces = [];
  List<UserWorkPlaceModel>? userWorkplaces = [];
  String? fullName;
  int? postsCount;
  int? followersCount;
  int? followingCount;
  PrivacyModel? privacy;
  bool? isFriend;
  bool? hasSentRequest;
  bool? isFollower;

  ProfileModel({
    this.id,
    this.first_name,
    this.last_name,
    this.present_town,
    this.username,
    this.email,
    this.phone,
    this.password,
    this.profile_pic,
    this.cover_pic,
    this.user_status,
    this.gender,
    this.religion,
    this.date_of_birth,
    this.user_bio,
    this.passport,
    this.last_login,
    this.user_2fa_status,
    this.secondary_email,
    this.recovery_email,
    this.relation_status,
    this.home_town,
    this.birth_place,
    this.blood_group,
    this.reset_password_token,
    this.reset_password_token_expires,
    this.user_role,
    this.status,
    this.ip_address,
    this.created_by,
    this.update_by,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lock_profile,
    this.email_list,
    this.phone_list,
    this.language,
    this.websites,
    this.user_about,
    this.user_nickname,
    this.educationWorkplaces,
    this.userWorkplaces,
    this.fullName,
    this.postsCount,
    this.followersCount,
    this.followingCount,
    this.privacy,
    this.isFriend,
    this.hasSentRequest,
    this.isFollower,
  });

  ProfileModel copyWith({
    String? id,
    String? first_name,
    String? last_name,
    String? present_town,
    String? username,
    String? email,
    String? phone,
    String? password,
    String? profile_pic,
    String? cover_pic,
    String? user_status,
    GenderModel? gender,
    String? religion,
    String? date_of_birth,
    String? user_bio,
    String? passport,
    String? last_login,
    String? user_2fa_status,
    String? secondary_email,
    String? recovery_email,
    String? relation_status,
    String? home_town,
    String? birth_place,
    String? blood_group,
    String? reset_password_token,
    String? reset_password_token_expires,
    String? user_role,
    String? status,
    String? ip_address,
    String? created_by,
    String? update_by,
    String? createdAt,
    String? updatedAt,
    String? v,
    String? lock_profile,
    List<EmailListModel>? email_list,
    List<PhoneListModel>? phone_list,
    List<LanguageModel>? language,
    List<Websites>? websites,
    String? user_about,
    String? user_nickname,
    List<EducationalWorkPlace>? educationWorkplaces,
    List<UserWorkPlaceModel>? userWorkplaces,
    String? fullName,
    int? postsCount,
    int? followersCount,
    int? followingCount,
    PrivacyModel? privacy,
    bool? isFriend,
    bool? hasSentRequest,
    bool? isFollower,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      present_town: present_town ?? this.present_town,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      profile_pic: profile_pic ?? this.profile_pic,
      cover_pic: cover_pic ?? this.cover_pic,
      user_status: user_status ?? this.user_status,
      gender: gender ?? this.gender,
      religion: religion ?? this.religion,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      user_bio: user_bio ?? this.user_bio,
      passport: passport ?? this.passport,
      last_login: last_login ?? this.last_login,
      user_2fa_status: user_2fa_status ?? this.user_2fa_status,
      secondary_email: secondary_email ?? this.secondary_email,
      recovery_email: recovery_email ?? this.recovery_email,
      relation_status: relation_status ?? this.relation_status,
      home_town: home_town ?? this.home_town,
      birth_place: birth_place ?? this.birth_place,
      blood_group: blood_group ?? this.blood_group,
      reset_password_token: reset_password_token ?? this.reset_password_token,
      reset_password_token_expires:
          reset_password_token_expires ?? this.reset_password_token_expires,
      user_role: user_role ?? this.user_role,
      status: status ?? this.status,
      ip_address: ip_address ?? this.ip_address,
      created_by: created_by ?? this.created_by,
      update_by: update_by ?? this.update_by,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      lock_profile: lock_profile ?? this.lock_profile,
      email_list: email_list ?? this.email_list,
      phone_list: phone_list ?? this.phone_list,
      language: language ?? this.language,
      websites: websites ?? this.websites,
      user_about: user_about ?? this.user_about,
      user_nickname: user_nickname ?? this.user_nickname,
      educationWorkplaces: educationWorkplaces ?? this.educationWorkplaces,
      userWorkplaces: userWorkplaces ?? this.userWorkplaces,
      fullName: fullName ?? this.fullName,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      privacy: privacy ?? this.privacy,
      isFriend: isFriend ?? this.isFriend,
      hasSentRequest: hasSentRequest ?? this.hasSentRequest,
      isFollower: isFollower ?? this.isFollower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'first_name': first_name,
      'last_name': last_name,
      'present_town': present_town,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'profile_pic': profile_pic,
      'cover_pic': cover_pic,
      'user_status': user_status,
      'gender': gender?.toMap(),
      'religion': religion,
      'date_of_birth': date_of_birth,
      'user_bio': user_bio,
      'passport': passport,
      'last_login': last_login,
      'user_2fa_status': user_2fa_status,
      'secondary_email': secondary_email,
      'recovery_email': recovery_email,
      'relation_status': relation_status,
      'home_town': home_town,
      'birth_place': birth_place,
      'blood_group': blood_group,
      'reset_password_token': reset_password_token,
      'reset_password_token_expires': reset_password_token_expires,
      'user_role': user_role,
      'status': status,
      'ip_address': ip_address,
      'created_by': created_by,
      'update_by': update_by,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'lock_profile': lock_profile,
      'email_list': email_list?.map((x) => x.toMap()).toList(),
      'phone_list': phone_list?.map((x) => x.toMap()).toList(),
      'language': language?.map((x) => x.toMap()).toList(),
      'websites': websites?.map((x) => x.toMap()).toList(),
      'user_about': user_about,
      'user_nickname': user_nickname,
      'educationWorkplaces':
          educationWorkplaces?.map((x) => x.toMap()).toList(),
      'userWorkplaces': userWorkplaces?.map((x) => x.toMap()).toList(),
      'fullName': fullName,
      'postsCount': postsCount,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'privacy': privacy?.toMap(),
      'isFriend': isFriend,
      'hasSentRequest': hasSentRequest,
      'isFollower': isFollower,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      present_town:
          map['present_town'] != null ? map['present_town'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profile_pic:
          map['profile_pic'] != null ? map['profile_pic'] as String : null,
      cover_pic: map['cover_pic'] != null ? map['cover_pic'] as String : null,
      user_status:
          map['user_status'] != null ? map['user_status'] as String : null,
      gender: map['gender'] != null
          ? GenderModel.fromMap(map['gender'] as Map<String, dynamic>)
          : null,
      religion: map['religion'] != null ? map['religion'] as String : null,
      date_of_birth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      user_bio: map['user_bio'] != null ? map['user_bio'] as String : null,
      passport: map['passport'] != null ? map['passport'] as String : null,
      last_login:
          map['last_login'] != null ? map['last_login'] as String : null,
      user_2fa_status: map['user_2fa_status'] != null
          ? map['user_2fa_status'] as String
          : null,
      secondary_email: map['secondary_email'] != null
          ? map['secondary_email'] as String
          : null,
      recovery_email: map['recovery_email'] != null
          ? map['recovery_email'] as String
          : null,
      relation_status: map['relation_status'] != null
          ? map['relation_status'] as String
          : null,
      home_town: map['home_town'] != null ? map['home_town'] as String : null,
      birth_place:
          map['birth_place'] != null ? map['birth_place'] as String : null,
      blood_group:
          map['blood_group'] != null ? map['blood_group'] as String : null,
      reset_password_token: map['reset_password_token'] != null
          ? map['reset_password_token'] as String
          : null,
      reset_password_token_expires: map['reset_password_token_expires'] != null
          ? map['reset_password_token_expires'] as String
          : null,
      user_role: map['user_role'] != null ? map['user_role'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      ip_address:
          map['ip_address'] != null ? map['ip_address'] as String : null,
      created_by:
          map['created_by'] != null ? map['created_by'] as String : null,
      update_by: map['update_by'] != null ? map['update_by'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      v: map['v'] != null ? map['v'] as String : null,
      lock_profile:
          map['lock_profile'] != null ? map['lock_profile'] as String : null,
      email_list: map['email_list'] != null
          ? (map['email_list'] as List)
              .map((e) => EmailListModel.fromMap(e))
              .toList()
          : null,
      phone_list: map['phone_list'] != null
          ? (map['phone_list'] as List)
              .map((e) => PhoneListModel.fromMap(e))
              .toList()
          : null,
      language: map['language'] != null
          ? (map['language'] as List)
              .map((e) => LanguageModel.fromMap(e))
              .toList()
          : null,
      websites: map['websites'] != null
          ? (map['websites'] as List).map((e) => Websites.fromMap(e)).toList()
          : null,
      user_about:
          map['user_about'] != null ? map['user_about'] as String : null,
      user_nickname:
          map['user_nickname'] != null ? map['user_nickname'] as String : null,
      educationWorkplaces: map['educationWorkplaces'] != null
          ? (map['educationWorkplaces'] as List)
              .map((e) => EducationalWorkPlace.fromMap(e))
              .toList()
          : null,
      userWorkplaces: map['userWorkplaces'] != null
          ? (map['userWorkplaces'] as List)
              .map((e) => UserWorkPlaceModel.fromMap(e))
              .toList()
          : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      postsCount: map['postsCount'] != null ? map['postsCount'] as int : null,
      followersCount:
          map['followersCount'] != null ? map['followersCount'] as int : null,
      followingCount:
          map['followingCount'] != null ? map['followingCount'] as int : null,
      privacy: map['privacy'] != null
          ? PrivacyModel.fromMap(map['privacy'] as Map<String, dynamic>)
          : null,
      isFriend: map['isFriend'] != null ? map['isFriend'] as bool : null,
      hasSentRequest:
          map['hasSentRequest'] != null ? map['hasSentRequest'] as bool : null,
      isFollower: map['isFollower'] != null ? map['isFollower'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(_id: $id, first_name: $first_name, last_name: $last_name, present_town: $present_town, username: $username, email: $email, phone: $phone, password: $password, profile_pic: $profile_pic, cover_pic: $cover_pic, user_status: $user_status, gender: $gender, religion: $religion, date_of_birth: $date_of_birth, user_bio: $user_bio, passport: $passport, last_login: $last_login, user_2fa_status: $user_2fa_status, secondary_email: $secondary_email, recovery_email: $recovery_email, relation_status: $relation_status, home_town: $home_town, birth_place: $birth_place, blood_group: $blood_group, reset_password_token: $reset_password_token, reset_password_token_expires: $reset_password_token_expires, user_role: $user_role, status: $status, ip_address: $ip_address, created_by: $created_by, update_by: $update_by, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, lock_profile: $lock_profile, email_list: $email_list, phone_list: $phone_list, language: $language, websites: $websites, user_about: $user_about, user_nickname: $user_nickname, educationWorkplaces: $educationWorkplaces, userWorkplaces: $userWorkplaces, fullName: $fullName, postsCount: $postsCount, followersCount: $followersCount, followingCount: $followingCount, privacy: $privacy)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.present_town == present_town &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.profile_pic == profile_pic &&
        other.cover_pic == cover_pic &&
        other.user_status == user_status &&
        other.gender == gender &&
        other.religion == religion &&
        other.date_of_birth == date_of_birth &&
        other.user_bio == user_bio &&
        other.passport == passport &&
        other.last_login == last_login &&
        other.user_2fa_status == user_2fa_status &&
        other.secondary_email == secondary_email &&
        other.recovery_email == recovery_email &&
        other.relation_status == relation_status &&
        other.home_town == home_town &&
        other.birth_place == birth_place &&
        other.blood_group == blood_group &&
        other.reset_password_token == reset_password_token &&
        other.reset_password_token_expires == reset_password_token_expires &&
        other.user_role == user_role &&
        other.status == status &&
        other.ip_address == ip_address &&
        other.created_by == created_by &&
        other.update_by == update_by &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v &&
        other.lock_profile == lock_profile &&
        listEquals(other.email_list, email_list) &&
        listEquals(other.phone_list, phone_list) &&
        listEquals(other.language, language) &&
        listEquals(other.websites, websites) &&
        other.user_about == user_about &&
        other.user_nickname == user_nickname &&
        listEquals(other.educationWorkplaces, educationWorkplaces) &&
        listEquals(other.userWorkplaces, userWorkplaces) &&
        other.fullName == fullName &&
        other.postsCount == postsCount &&
        other.followersCount == followersCount &&
        other.followingCount == followingCount &&
        other.privacy == privacy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        present_town.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        profile_pic.hashCode ^
        cover_pic.hashCode ^
        user_status.hashCode ^
        gender.hashCode ^
        religion.hashCode ^
        date_of_birth.hashCode ^
        user_bio.hashCode ^
        passport.hashCode ^
        last_login.hashCode ^
        user_2fa_status.hashCode ^
        secondary_email.hashCode ^
        recovery_email.hashCode ^
        relation_status.hashCode ^
        home_town.hashCode ^
        birth_place.hashCode ^
        blood_group.hashCode ^
        reset_password_token.hashCode ^
        reset_password_token_expires.hashCode ^
        user_role.hashCode ^
        status.hashCode ^
        ip_address.hashCode ^
        created_by.hashCode ^
        update_by.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode ^
        lock_profile.hashCode ^
        email_list.hashCode ^
        phone_list.hashCode ^
        language.hashCode ^
        websites.hashCode ^
        user_about.hashCode ^
        user_nickname.hashCode ^
        educationWorkplaces.hashCode ^
        userWorkplaces.hashCode ^
        fullName.hashCode ^
        postsCount.hashCode ^
        followersCount.hashCode ^
        followingCount.hashCode ^
        privacy.hashCode;
  }
}

class LanguageModel {
  String? id;
  String? user_id;
  String? privacy;
  String? language;
  bool? is_language_verified;
  String? created_by;
  String? update_by;
  String? createdAt;
  String? updatedAt;
  int? v;
  LanguageModel({
    this.id,
    this.user_id,
    this.privacy,
    this.language,
    this.is_language_verified,
    this.created_by,
    this.update_by,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  LanguageModel copyWith({
    String? id,
    String? user_id,
    String? privacy,
    String? language,
    bool? is_language_verified,
    String? created_by,
    String? update_by,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      privacy: privacy ?? this.privacy,
      language: language ?? this.language,
      is_language_verified: is_language_verified ?? this.is_language_verified,
      created_by: created_by ?? this.created_by,
      update_by: update_by ?? this.update_by,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'user_id': user_id,
      'privacy': privacy,
      'language': language,
      'is_language_verified': is_language_verified,
      'created_by': created_by,
      'update_by': update_by,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'v': v,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      privacy: map['privacy'] != null ? map['privacy'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      is_language_verified: map['is_language_verified'] != null
          ? map['is_language_verified'] as bool
          : null,
      created_by:
          map['created_by'] != null ? map['created_by'] as String : null,
      update_by: map['update_by'] != null ? map['update_by'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) =>
      LanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LanguageModel(id: $id, user_id: $user_id, privacy: $privacy, language: $language, is_language_verified: $is_language_verified, created_by: $created_by, update_by: $update_by, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(covariant LanguageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.privacy == privacy &&
        other.language == language &&
        other.is_language_verified == is_language_verified &&
        other.created_by == created_by &&
        other.update_by == update_by &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        privacy.hashCode ^
        language.hashCode ^
        is_language_verified.hashCode ^
        created_by.hashCode ^
        update_by.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }
}
