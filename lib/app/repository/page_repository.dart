
import '../config/api_constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
import '../services/api_communication.dart';

class PageRepository {
  final ApiCommunication _apiCommunication = ApiCommunication();

  Future<ApiResponse> getPosts({
    required int pageNo,
    required int pageSize,
    required String pageId,
    required String userRole,
  }) async {
    List<PostModel> postList = [];
    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'get-pages-posts?pageNo=$pageNo&pageSize=$pageSize',
        requestData: {
          'page_id': pageId,
          'user_role': userRole,
          'pageNo': pageNo,
          'pageSize': pageSize
        });

    if (apiResponse.isSuccessful) {
      // int pageCount = (apiResponse.data as Map<String, dynamic>)['pageCount'];
      postList = (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
          .map((element) => PostModel.fromMap(element))
          .toList();
      ApiResponse apiResponseToPass =
          apiResponse.copyWith(pageCount: 1, data: postList);
      return apiResponseToPass;
    } else {
      return apiResponse;
    }
  }
}
