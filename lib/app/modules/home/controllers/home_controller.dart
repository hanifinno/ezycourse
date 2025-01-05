import 'package:ezycourse/app/components/comment/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../data/post.dart';
import '../../../models/MediaTypeModel.dart';
import '../../../models/api_response.dart';
import '../../../models/post.dart';
import '../../../repository/post_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/post_utlis.dart';
import '../../../utils/snackbar.dart';

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
  Rx<List<PostModel>> postList = Rx([]);
  Rx<List<CommentModel>> commentList = Rx([]);

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

  var selectedIndex = 0.obs;



 
//===============Tab Change==============//
  void changeTab(int index) {
    if (index == 1) {
      print("Logout tapped");
    } else {
      selectedIndex.value = index;
    }
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

//============================= Fetch Post comments =========================================//
  Future<void> fetchPostComments(int postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'app/student/comment/getComment/$postId?more=null',
    );
    if (apiResponse.isSuccessful) {
      commentList.value =
          (apiResponse.data as List).map((e) => CommentModel.fromMap(e)).toList();
      // postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }
//============================= Fetch Post replies =========================================//
  Future<void> fetchPostReply(int postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'app/student/comment/getReply/$postId?more=null',
    );
    if (apiResponse.isSuccessful) {
      commentList.value =
          (apiResponse.data as List).map((e) => CommentModel.fromMap(e)).toList();
      // postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }
//============================= Create Post comments =========================================//
  Future<void> createPostComments(int postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'app/student/comment/createComment',
      requestData: {
        'feed_id':postId,
        'feed_user_id':'',
        'comment_txt':commentController.text,
        'commentSource':'COMMUNITY'
      }
    );
    if (apiResponse.isSuccessful) {
      fetchPostComments(postId, index);
      commentController.clear();
      // commentList.value =
      //     (apiResponse.data as List).map((e) => CommentModel.fromMap(e)).toList();
      // // postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }
//============================= Create Reply on comments =========================================//
  Future<void> createPostReplyComments(int postId, int index, String commentId) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'app/student/comment/createComment',
      requestData: {
        'feed_id':postId,
        'feed_user_id':'',
        'parent_id':int.parse(commentId),
        'comment_txt':commentController.text,
        'commentSource':'COMMUNITY'
      }
    );
    if (apiResponse.isSuccessful) {
      fetchPostComments(postId, index);
      commentReplyController.clear();
      // commentList.value =
      //     (apiResponse.data as List).map((e) => CommentModel.fromMap(e)).toList();
      // // postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }



//============================= React on Posts =========================================//

  Future<void> reactOnPost({
    required PostModel postModel,
    required String reaction,
    required int index,
    required String action
  }) async {
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'app/teacher/community/createLike?=&=&=&=',
      requestData: {

        'reaction_type': reaction,
        'feed_id': postModel.id,
        'reactionSource': 'COMMUNITY',
        'action': action
      },
    );

    if (apiResponse.isSuccessful) {
      
      // postList.refresh();
      postList.value.clear();
      fetchCommunityPosts();
     
      debugPrint(apiResponse.message);
      // updatePostList(postModel.id ?? '', index);
    } else {
      debugPrint(apiResponse.message);
    }
  }
void logout() {
    loginCredential.clearLoginCredential();
    Get.offAllNamed(Routes.LOGIN);
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
    await fetchCommunityPosts();

    // await getAdsPagePosts();
    // generateRandomIndicesForPosts();

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

    super.onClose();
  }
}
