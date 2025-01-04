
import '../config/api_constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
import '../models/video_campaign_model.dart';
import '../services/api_communication.dart';

class PostRepository {
  final ApiCommunication _apiCommunication = ApiCommunication();

  Future<ApiResponse> fetchCommunityPosts({
    required int pageNo,
    required int pageSize,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'app/teacher/community/getFeed?status=feed&',
      requestData: {
        'community_id': 2914,
        'space_id': 5883,
        'more': null
      }
    );

    if (apiResponse.isSuccessful) {
      postList = (((apiResponse.data as List<dynamic>)) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass =
          apiResponse.copyWith( data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }

  Future<ApiResponse> getIndividualPosts({
    required int pageNo,
    required int pageSize,
    required String userName,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint:
            'get-all-users-posts-individual-for-app?pageNo=$pageNo&pageSize=$pageSize',
        requestData: {
          'username': userName,
        });

    if (apiResponse.isSuccessful) {
      int pageCount = (apiResponse.data as Map<String, dynamic>)['pageCount'];
      postList = (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass =
          apiResponse.copyWith(pageCount: pageCount, data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }

  Future<ApiResponse> getGroupPosts({
    required String groupId,
    required int pageNo,
    required int pageSize,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'get-group-posts?pageNo=$pageNo&pageSize=$pageSize',
        requestData: {
          'group_id': groupId,
        });

    if (apiResponse.isSuccessful) {
      int? pageCount = (apiResponse.data as Map<String, dynamic>)['pageCount'];
      postList = (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass =
          apiResponse.copyWith(pageCount: pageCount, data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }

  Future<ApiResponse> getGroupFeedPosts({
    required int pageNo,
    required int pageSize,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-groups-post?pageNo=$pageNo&pageSize=$pageSize',
      // requestData: {
      //   'group_id': groupId,
      // }
    );

    if (apiResponse.isSuccessful) {
      int? pageCount = (apiResponse.data as Map<String, dynamic>)['pageCount'];
      postList = (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass =
          apiResponse.copyWith(pageCount: pageCount, data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }

  Future<ApiResponse> getAdsPagePosts({
    required int pageNo,
    required int pageSize,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'campaign/get-center-side-ads-as-post',
      // requestData: {
      //   'group_id': groupId,
      // }
    );

    if (apiResponse.isSuccessful) {
      // int? pageCount = (apiResponse.data as Map<String, dynamic>)['pageCount'];
      postList = (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass = apiResponse.copyWith(data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }

}
