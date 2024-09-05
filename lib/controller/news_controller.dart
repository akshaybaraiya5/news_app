



import 'package:get/get.dart';
import 'package:hindi_news/model/news_model.dart';
import 'package:hindi_news/repository/news_repository.dart';


import '../data/response/status.dart';


class NewsController extends GetxController {

  final _api = NewsRepository();


  final requestStatus = Status.LOADING.obs;

  final newsList = NewsModel().obs;

  RxString error = ''.obs;





  void setRequestStatus(Status _value) => requestStatus.value = _value;

  void setUserList(NewsModel _value) => newsList.value = _value;

  void setError(String _value) => error.value = _value;


  void getNewsList() {
    //  setRxRequestStatus(Status.LOADING);

    _api.newsList().then((value) {
      setRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error.toString());
      setRequestStatus(Status.ERROR);
    });
  }
  //
  void refreshApi(String query ,String category) {
    setRequestStatus(Status.LOADING);
    if (query ==''){
      query = 'general';
    }

    _api.newsList(query: query,category: category).then((value) {
      setRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRequestStatus(Status.ERROR);
    });
  }
}