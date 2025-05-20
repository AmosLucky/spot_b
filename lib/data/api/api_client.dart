class ApiClient {
  String imageUrl = "https://test.spotstockinventory.com/";
  //String baseUri = "https://test.spotstockinventory.com/api/";
  // String baseUri = "https://staging.spotstockinventory.com/api/";
  String baseUri = "https://app.spotstockinventory.com/api/";
  String baseUrl;

  ApiClient() : baseUrl = "https://app.spotstockinventory.com/api/";
  // ApiClient() : baseUrl = "https://staging.spotstockinventory.com/api/";

  String appUrl = "https://test.spotstockinventory.com";

  Map<String, String> getUserToken() {
    // AuthController authController = Get.find();
    // String? token; http://gagahotels.ebeanomarket.com/
    // authController.user!.token;
    const token = null;
    if (token != null) {
      return {
        "Authorization": "Bearer " + token,
      };
    }
    return {
      "Authorization": "Bearer " + "BadToken",
    };
  }
}



// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';

// class ApiClient {
//   // Keep your existing URLs
//   String imageUrl = "https://test.s/";
//   String baseUri = "https://s.com/api/";
//   String baseUrl = "https://s/api/";
//   String appUrl = "https://test.s.com";
  
//   // Add Dio client for HTTP requests
//   final Dio _dio = Dio();
  
//   // Reference to AuthProvider
//   final AuthProvider _authProvider;
  
//   // Constructor with AuthProvider dependency
//   ApiClient(this._authProvider) {
//     // Configure Dio with base URL
//     _dio.options.baseUrl = baseUrl;
    
//     // Add request interceptor for authentication
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Get valid token before each request
//           final token = await _authProvider.getValidToken();
          
//           if (token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//           } else {
//             // No valid token available, use default header or handle as needed
//             options.headers['Authorization'] = 'Bearer BadToken';
//           }
          
//           return handler.next(options);
//         },
//         onError: (DioError error, handler) async {
//           // Handle 401 Unauthorized errors
//           if (error.response?.statusCode == 401) {
//             // Try to refresh token
//             final result = await _authProvider.refreshToken();
            
//             if (result['status'] == true) {
//               // Retry original request with new token
//               final opts = Options(
//                 method: error.requestOptions.method,
//                 headers: error.requestOptions.headers,
//               );
              
//               opts.headers!['Authorization'] = 'Bearer ${_authProvider.accessToken}';
              
//               final response = await _dio.request(
//                 error.requestOptions.path,
//                 options: opts,
//                 data: error.requestOptions.data,
//                 queryParameters: error.requestOptions.queryParameters,
//               );
              
//               return handler.resolve(response);
//             }
//           }
          
//           return handler.next(error);
//         },
//       ),
//     );
//   }
  
//   // Get user token (keep existing method but make it use AuthProvider)
//   Map<String, String> getUserToken() {
//     final token = _authProvider.accessToken;
    
//     if (token.isNotEmpty) {
//       return {
//         "Authorization": "Bearer $token",
//       };
//     }
    
//     // Fallback to existing behavior for compatibility
//     return {
//       "Authorization": "Bearer BadToken",
//     };
//   }
  
//   // Add HTTP methods with automatic token handling
  
//   // GET request
//   Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await _dio.get(
//         endpoint,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
  
//   // POST request
//   Future<dynamic> post(String endpoint, {dynamic data}) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//       );
//       return response.data;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
  
//   // PUT request
//   Future<dynamic> put(String endpoint, {dynamic data}) async {
//     try {
//       final response = await _dio.put(
//         endpoint,
//         data: data,
//       );
//       return response.data;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
  
//   // DELETE request
//   Future<dynamic> delete(String endpoint, {dynamic data}) async {
//     try {
//       final response = await _dio.delete(
//         endpoint,
//         data: data,
//       );
//       return response.data;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
  
//   // Form data POST (for file uploads)
//   Future<dynamic> postFormData(String endpoint, FormData formData) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: formData,
//       );
//       return response.data;
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }
  
//   // Error handling helper
//   void _handleError(dynamic error) {
//     if (kDebugMode) {
//       print('API Error: $error');
      
//       if (error is DioError && error.response != null) {
//         print('Status code: ${error.response?.statusCode}');
//         print('Response data: ${error.response?.data}');
//       }
//     }
//   }
  
//   // Helper method to get image URL
//   String getImageUrl(String path) {
//     if (path.startsWith('http')) {
//       return path;
//     }
//     return '$imageUrl$path';
//   }
// }
