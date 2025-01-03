import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../data/post.dart';
import '../../../models/MediaTypeModel.dart';
import '../../../models/api_response.dart';
import '../../../models/comment_model.dart';
import '../../../models/post.dart';
import '../../../models/video_campaign_model.dart';
import '../../../repository/post_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/post_utlis.dart';
import '../../../utils/snackbar.dart';
import '../components/generate_random_indices.dart';

class HomeController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential loginCredential;
  late UserModel userModel;
  //Repository
  final PostRepository postRepository = PostRepository();

  late TextEditingController descriptionController;

  RxBool isCommentReactionLoading = true.obs;
  RxBool isReplyReactionLoading = true.obs;
  RxInt storyCaroselInitialIndex = 0.obs;
  var currentAdIndex = 0.obs;

  RxString dropdownValue = privacyList.first.obs;
  RxString postPrivacy = 'public'.obs;

  Rx<List<XFile>> xfiles = Rx([]);

  RxString commentsID = ''.obs;
  RxString postID = ''.obs;

  RxBool isLoadingNewsFeed = true.obs;
  RxBool isLoadingUserPages = true.obs;
  RxBool isLoadingStory = true.obs;
  Rx<List<PostModel>> postList = Rx([]);

  late ScrollController postScrollController;

  int pageNo = 1;
  final int pageSize = 20;
  int totalPageCount = 0;
  RxBool isNextPage = false.obs;
  late TextEditingController commentController;
  late TextEditingController commentReplyController;
  RxBool isReply = false.obs;
  RxBool isLoading = false.obs;
  Rx<List<MediaTypeModel>> imageFromNetwork = Rx([]);

//pepople you may know
  RxList<int> randomIndices = <int>[].obs;
  RandomIndexGenerator randomNumberGenertor = RandomIndexGenerator();
  RxString selectedReportId = ''.obs;
  RxString selectedReportType = ''.obs;
  late TextEditingController reportDescription;

  void generateRandomIndicesForPosts() {
    // Ensure postList is not empty before generating indices
    if (postList.value.isNotEmpty) {
      // postList.value.clear();
      randomIndices.assignAll(randomNumberGenertor.generateRandomIndices(
          postList.value.length, 10));
    }
  }

  //============================= Pick Media Files =========================================//

  Future<void> pickMediaFiles() async {
    isLoading.value = true;
    final ImagePicker picker = ImagePicker();
    xfiles.value = await picker.pickMultipleMedia();
    for (int index = 0; index < xfiles.value.length; index++) {
      imageFromNetwork.value.add(
          MediaTypeModel(imagePath: xfiles.value[index].path, isFile: true));

      isLoading.value = false;
    }
    onTapCreatePost();
  }

  //======================================================== Post Related Functions ===============================================//
  void onTapCreatePost() async {
    await Get.toNamed(Routes.CREAT_POST, arguments: {
      // 'group_id': allGroupModel.value,
      'media_files': xfiles.value
    });
    isLoadingNewsFeed.value = true;
    pageNo = 1;
    totalPageCount = 0;
    postList.value.clear();
    fetchCommunityPosts();
    isLoadingNewsFeed.value = false;
  }

  void onTapEditPost(PostModel model) async {
    await Get.toNamed(Routes.EDIT_POST, arguments: model);
    postList.value.clear();
    fetchCommunityPosts();
  }
//============================= Get Posts =========================================//

  Future<void> fetchCommunityPosts() async {
    isLoadingNewsFeed.value = true;

    final ApiResponse apiResponse = await postRepository.fetchCommunityPosts(
        pageNo: pageNo, pageSize: pageSize);
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      totalPageCount = apiResponse.pageCount ?? 1;

      List<PostModel> fetchedPosts = apiResponse.data as List<PostModel>;

      postList.value.addAll(fetchedPosts);

      // Refresh the postList
      postList.refresh();
    } else {
      // Handle error response
    }
  }

//============================= Get Ads Posts =========================================//
  Rx<List<PostModel>> adsPostList = Rx([]); // Store ads posts separately

  Future<void> getAdsPagePosts() async {
    isLoadingNewsFeed.value = true;

    final ApiResponse apiResponse = await postRepository.getAdsPagePosts(
      pageNo: pageNo,
      pageSize: pageSize,
    );
    isLoadingNewsFeed.value = false;
    if (apiResponse.isSuccessful) {
      adsPostList.value.addAll(
          apiResponse.data as List<PostModel>); // Store the ads separately
      adsPostList.refresh(); // Refresh the ads list
    } else {
      // Handle Error
    }
  }
//============================= Get Video Ads =========================================//



// Video ad Index Dynamic

  // Future<void> getAdsPagePosts() async {
  //   isLoadingNewsFeed.value = true;

  //   final ApiResponse apiResponse = await postRepository.getAdsPagePosts(
  //     pageNo: pageNo,
  //     pageSize: pageSize,
  //   );
  //   isLoadingNewsFeed.value = false;
  //   if (apiResponse.isSuccessful) {
  //     // totalPageCount = apiResponse.pageCount ?? 1;
  //     postList.value.addAll(apiResponse.data as List<PostModel>);

  //     postList.refresh();
  //     generateRandomIndicesForPosts();
  //     // getPeopleMayYouKnow();
  //   } else {
  //     //Error Response
  //   }
  // }
//============================= React on Posts =========================================//

  Future<void> reactOnPost({
    required PostModel postModel,
    required String reaction,
    required int index,
  }) async {
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'save-reaction-main-post',
      requestData: {
        'reaction_type': reaction,
        'post_id': postModel.id,
        'post_single_item_id': null,
      },
    );

    if (apiResponse.isSuccessful) {
      // updateReactionLocally(
      //     index: index, postId: postModel.id ?? '', reaction: reaction);
      debugPrint(apiResponse.message);
      // updatePostList(postModel.id ?? '', index);
    } else {
      debugPrint(apiResponse.message);
    }
  }
//============================= Report on Posts =========================================//

  Future<void> reportAPost({
    required String post_id,
    required String report_type,
    required String description,
    required String report_type_id,
  }) async {
    debugPrint('=================Report Start==========================');

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'save-post-report',
      enableLoading: true,
      requestData: {
        'post_id': post_id,
        'report_type': report_type,
        'description': description,
        'report_type_id': report_type_id
      },
    );

    debugPrint(
        '=================Report Api call end==========================');
    debugPrint(
        '=================Report Api status Code ${apiResponse.message}==========================');
    debugPrint(
        '=================Report Api success ${apiResponse.isSuccessful}==========================');

    if (apiResponse.isSuccessful) {
      debugPrint(
          '=================Report Successful==========================');

      Get.back();
      Get.back();
      Get.back();
      reportDescription.clear();

      showSuccessSnackkbar(message: 'Post reported successfully');
    } else {}
  }

//============================= Update Posts =========================================//
  Future<void> updatePostList(String postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'view-single-main-post-with-comments/$postId',
      responseDataKey: 'post',
    );
    if (apiResponse.isSuccessful) {
      List<PostModel> postmodelList =
          (apiResponse.data as List).map((e) => PostModel.fromMap(e)).toList();
      postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }
//============================= Hide Posts =========================================//

  Future<void> hidePost(int status, String postId, int postIndex) async {
    ApiResponse apiResponse = await _apiCommunication
        .doPostRequest(apiEndPoint: 'hide-unhide-post', requestData: {
      'status': status,
      'post_id': postId,
    });

    if (apiResponse.isSuccessful) {
      postList.value.removeAt(postIndex);
      postList.refresh();
      Get.back();
    }
  }
//============================= Bookmark Posts =========================================//

  Future<void> bookmarkPost(
      String postId, String postPrivacy, int index) async {
    ApiResponse apiResponse = await _apiCommunication
        .doPostRequest(apiEndPoint: 'save-post-bookmark', requestData: {
      'post_privacy': postPrivacy,
      'post_id': postId,
    });

    updatePostList(postId, index);
    postList.refresh();

    if (apiResponse.isSuccessful) {
      Get.back();
      showSuccessSnackkbar(message: 'Post bookmark successfully');
    }
  }
//============================= Remove Bookmarks Posts =========================================//

  Future<void> removeBookmarkPost(
      String postId, String bookMarkId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doDeleteRequest(
      apiEndPoint: 'remove-post-bookmark/$bookMarkId',
    );

    if (apiResponse.isSuccessful) {
      Get.back();
      updatePostList(postId, index);
      postList.refresh();
      showSuccessSnackkbar(message: 'remove bookmark');
    }
  }

  //======================================================== Comment Related Functions ===============================================//

  Future<List<CommentModel>> getSinglePostsComments(String postID) async {
    isLoadingNewsFeed.value = true;

    Rx<List<CommentModel>> commentList = Rx([]);

    debugPrint(
        '==================get SinglePosts Comments=========Start==========================');

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-comments-direct-post/$postID',
    );
    isLoadingNewsFeed.value = false;

    debugPrint('ivalid user code$apiResponse');

    debugPrint(
        '==================get SinglePosts Comments=========Api Call done==========================');

    if (apiResponse.isSuccessful) {
      debugPrint(
          '==================get SinglePosts Comments=========${apiResponse.data}==========================');

      commentList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['comments']) as List)
              .map((element) => CommentModel.fromMap(element))
              .toList());

      debugPrint(
          '===================get SinglePosts Commentsn=================${commentList.value}===');

      commentList.refresh();
      return commentList.value;
    } else {
      return [];
    }
  }

  Future commentOnPost(int index, PostModel postModel) async {
    debugPrint('Comment API Called============================');
    if (commentController.text.isNotEmpty || xfiles.value.isNotEmpty) {
      final ApiResponse apiResponse = await _apiCommunication.doPostRequest(
          apiEndPoint: 'save-user-comment-by-post',
          isFormData: true,
          enableLoading: true,
          requestData: {
            // 'user_id': postModel.user_id?.id,
            'post_id': postModel.id,
            'comment_name': commentController.text,
            'link': null,
            'link_title': null,
            'link_description': null,
            'link_image': null
          },
          fileKey: 'image_or_video',
          mediaXFiles: xfiles.value,
          responseDataKey: 'posts');

      if (apiResponse.isSuccessful) {
        if (postList.value[index].comments != null) {
          // updatePostList(postModel.id ?? '', index);
          commentController.clear();
          debugPrint('Hello');
          xfiles.value.clear();
        }
      } else {
        debugPrint('Failure');
      }
    } else {
      debugPrint('Can not do empty comment');
    }
  }

  void commentReply({
    required String comment_id,
    required String replies_comment_name,
    required String post_id,
    required int postIndex,
  }) async {
    if (replies_comment_name.isNotEmpty || xfiles.value.isNotEmpty) {
      ApiResponse apiResponse = await _apiCommunication.doPostRequest(
          apiEndPoint: 'reply-comment-by-direct-post',
          enableLoading: true,
          isFormData: true,
          requestData: {
            'comment_id': comment_id,
            'replies_user_id': userModel.id,
            'replies_comment_name': replies_comment_name,
            'post_id': post_id,
          },
          fileKey: 'image_or_video',
          mediaXFiles: xfiles.value);

      if (apiResponse.isSuccessful) {
        updatePostList(post_id, postIndex);
        commentReplyController.text = '';

        xfiles.value.clear();
      }
    } else {
      debugPrint('Can not do empty replay comment');
    }
  }

  void commentReaction({
    required int postIndex,
    required String reaction_type,
    required String post_id,
    required String comment_id,
  }) async {
    debugPrint('===================================reaction function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-comment-reaction-of-direct-post',
        requestData: {
          'reaction_type': reaction_type,
          'post_id': post_id,
          'comment_id': comment_id
        });

    if (apiResponse.isSuccessful) {
      List<CommentModel> comments = await getSinglePostsComments(post_id);
      // postList.value[postIndex].comments = comments;
      postList.refresh();
    }
  }

  void commentReplyReaction(
    int postIndex,
    String reactionType,
    String postId,
    String commentId,
    String commentRepliesId,
  ) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-comment-reaction-of-direct-post',
        requestData: {
          'reaction_type': reactionType,
          'user_id': userModel.id,
          'post_id': postId,
          'comment_id': commentId,
          'comment_replies_id': commentRepliesId,
        });

    if (apiResponse.isSuccessful) {
      List<CommentModel> comments = await getSinglePostsComments(postId);
      // postList.value[postIndex].comments = comments;
      postList.refresh();
    }
  }

  void commentDelete(String commentId, String postId, int postIndex) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'delete-single-comment',
        requestData: {
          'comment_id': commentId,
          'post_id': postId,
          'type': 'main_comment'
        });

    if (apiResponse.isSuccessful) {
      updatePostList(postId, postIndex);
    }
  }

  void replyDelete(String replyId, String postId, int postIndex) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'delete-single-comment',
        requestData: {
          'comment_id': replyId,
          'post_id': postId,
          'type': 'reply_comment'
        });

    if (apiResponse.isSuccessful) {
      updatePostList(postId, postIndex);
    }
  }

  Future<void> pickFiles() async {
    debugPrint('=================X file Value start====================');

    final ImagePicker picker = ImagePicker();
    xfiles.value = await picker.pickMultipleMedia();

    debugPrint(
        '=================X file Value====================${xfiles.value}');
  }

  Future<void> onTapCreatePhotoComment(String userId, String postId) async {
    debugPrint('===================Photo comment Start=====================');

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-user-comment-by-post',
      isFormData: true,
      enableLoading: true,
      requestData: {
        'user_id': userId, //postModel.user_id?.id,
        'post_id': postId, //postModel.id,
        'comment_name': commentController.text,
        'image_or_video': null,
        'link': null,
        'link_title': null,
        'link_description': null,
        'link_image': null
      },
      // fileKey: 'image_or_video',
      mediaXFiles: xfiles.value,
    );

    if (response.isSuccessful) {
      debugPrint(
          '===================Photo comment ${response.statusCode}=====================');
    } else {
      debugPrint('');
    }
  }

  //======================================================== Story Related Functions ===============================================//

  //=========================================== For Scrolling List View

  Future<void> _scrollListener() async {
    if (postScrollController.position.pixels ==
        postScrollController.position.maxScrollExtent) {
      if (pageNo != totalPageCount) {
        pageNo += 1;
        await fetchCommunityPosts();
      }
    }
  }

  /////////////////////////////////////////////////////////////////////

  Future<void> shareUserPost(String sharePostId) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-share-post-with-caption',
        requestData: {
          'share_post_id': sharePostId,
          'description': descriptionController.text.toString(),
          'privacy': (getPostPrivacyValue(postPrivacy.value)),
        });

    debugPrint(
        'Update model status code.............${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: 'Your post has been shared');
      pageNo = 1;
      totalPageCount = 0;
      postList.value.clear();
      fetchCommunityPosts();
    } else {}
  }

  sharePost(String text) {
    Share.share(text);
  }

  void launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
        browserConfiguration: const BrowserConfiguration(showTitle: true),
      );
    } else {
      throw 'Could not launch $urlString';
    }
  }

  ////////////////////////////////////////////////////////////////////

  @override
  void onInit() async {
    _apiCommunication = ApiCommunication();
    postScrollController = ScrollController();
    loginCredential = LoginCredential();
    userModel = loginCredential.getUserData();
    commentController = TextEditingController();
    commentReplyController = TextEditingController();
    descriptionController = TextEditingController();
    reportDescription = TextEditingController();
    await fetchCommunityPosts();

    await getAdsPagePosts();
    generateRandomIndicesForPosts();

    super.onInit();
  }

  @override
  void onReady() {
    postScrollController.addListener(_scrollListener);
    super.onReady();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    reportDescription.clear();

    super.onClose();
  }
}
