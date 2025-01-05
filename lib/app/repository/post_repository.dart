
import '../config/api_constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
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

 

}
