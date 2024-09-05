import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hindi_news/controller/news_controller.dart';
import 'package:sizer/sizer.dart';

import '../data/response/status.dart';
import 'news_deatils_screen.dart';


class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({super.key});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  final newsController = Get.put(NewsController());

  @override
  void initState() {
    super.initState();
    newsController.getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top section with CarouselSlider
            Expanded(
              flex: 3,
              child: Obx(() {
                switch (newsController.requestStatus.value) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Breaking News",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                              Container(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CarouselSlider.builder(
                            itemCount:
                            newsController.newsList.value.results!.length,
                            itemBuilder: (context, index, realIndex) {
                              final news = newsController.newsList.value.results![index];
                              return GestureDetector(
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
                                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          news.imageUrl.toString(),
                                          fit: BoxFit.cover,
                                          width: 90.w,
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.7),
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      news.sourceName.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 15,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                        child: Image.network(
                                                          news.sourceIcon.toString(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  news.title.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 27.h,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                              aspectRatio: 16 / 9,
                              initialPage: 0,
                            ),
                          ),
                        ),
                      ],
                    );
                  case Status.ERROR:
                    return Center(child: Text("Error"));
                }
              }),
            ),
            // Bottom section with ListView
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recommendation",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        Container(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      switch (newsController.requestStatus.value) {
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.COMPLETED:
                          return ListView.builder(
                            itemCount:
                            newsController.newsList.value.results!.length,
                            itemBuilder: (context, index) {
                              final news = newsController.newsList.value.results![index];
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
                                          borderRadius:
                                          BorderRadius.circular(15),
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
                          return Center(child: Text("Error"));
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

