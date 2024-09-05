




import '../data/network/network_api_services.dart';
import '../model/news_model.dart';
import '../res/app_url.dart';

class NewsRepository {

  final _apiService  = NetworkApiServices() ;

  Future<NewsModel> newsList({
    String query ='general',String category ='top'
}) async{

    dynamic response = await _apiService.getApi("${AppUrl.headLines}apikey=${AppUrl.api_key}&country=in&language=en&q=$query&category=$category");
    print("${AppUrl.headLines}apikey=${AppUrl.api_key}&country=in&language=hi&q=$query&category=$category");
    print("res//////////////////////////////////");
    return NewsModel.fromJson(response) ;
  }


}