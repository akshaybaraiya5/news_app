import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:hindi_news/view/home_screen.dart';
import 'package:hindi_news/view/news_deatils_screen.dart';
import 'package:sizer/sizer.dart';

import '../controller/news_controller.dart';
import '../data/response/status.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NewsController newsController = Get.find();

  final category = [
    'business',
    'crime',
    'domestic',
    'education',
    'entertainment',
    'environment',
    'food',
    'health',
    'lifestyle',
    'other',
    'politics',
    'science',
    'sports',
    'technology',
    'top',
    'tourism',
    'world'
  ];
  int tabIndex = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Discover",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "News From All Around Word",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff948686)),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffdeeaf1),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  height: 6.5.h,
                  child: Center(
                    child: TextFormField(
                      onFieldSubmitted: (val) {
                        newsController.refreshApi(val.toString(), 'top');
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: Color(0xff948686),
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Transform.rotate(
                              angle: 90 * 3.14 / 180,
                              child: Icon(
                                  Icons.settings_input_component_rounded,
                                  color: Color(0xff948686))),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 5.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              tabIndex = i;
                            });
                            newsController.refreshApi('', category[i]);
                          },
                          child: tabIndex == i
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                      child: Text(
                                    category[i],
                                    style: TextStyle(color: Colors.white),
                                  )))
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffdeeaf1),
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                      child: Text(
                                    category[i],
                                    style: TextStyle(color: Color(0xff948686)),
                                  ))),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 63.h,
                child: Center(
                  child: Obx(() {
                    switch (newsController.requestStatus.value) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        return ListView.builder(
                          itemCount:
                              newsController.newsList.value.results!.length,
                          itemBuilder: (context, index) {
                            final news =
                                newsController.newsList.value.results![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => NewsDetailsScreen(
                                                news: news,
                                                saved: false,
                                              )));
                                },
                                child: Container(
                                  height: 15.h,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          width: 30.w,
                                          height: 15.h,
                                          child: Image.network(
                                            news.imageUrl.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              news.category
                                                  .toString()
                                                  .replaceAll('[', '')
                                                  .replaceAll(']', ''),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: Color(0xff948686)),
                                            ),
                                            Text(
                                              news.title.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.5.sp),
                                              maxLines: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  news.sourceName.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff948686),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                CircleAvatar(
                                                  radius: 13,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image.network(
                                                      news.sourceIcon
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      case Status.ERROR:
                        return Center(child: Text("error"));
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
