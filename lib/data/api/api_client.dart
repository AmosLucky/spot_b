class ApiClient {
  String imageUrl = "https://test.spotstockinventory.com/";
  String baseUri = "https://test.spotstockinventory.com/api/";
  String baseUrl;

  ApiClient() : baseUrl = "https://test.spotstockinventory.com/api/";

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
