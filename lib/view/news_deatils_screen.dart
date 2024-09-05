import 'dart:io';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:hindi_news/main.dart';
import 'package:hindi_news/model/result_model.dart';
import 'package:hindi_news/res/components/toast.dart';
import 'package:hindi_news/service/sqlite_service.dart';
import 'package:hindi_news/view/web_view_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';

import '../model/news_model.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Results? news;
  final bool saved;
  final dynamic? newsResult;

  NewsDetailsScreen({super.key, this.news, required this.saved, this.newsResult});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  late DatabaseHelper databaseHelper ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.newsResult != null ? widget.newsResult['image_url']?.toString() : null;
    final sourceIconPath = widget.newsResult != null ? widget.newsResult['source_icon']?.toString() : null;

    return Scaffold(
      body: widget.saved ? Stack(
        children: [
          if (imagePath != null) ...[
            Container(
              width: double.infinity,
              height: 60.h,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ],
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: BlurryContainer(
                            elevation: 0.6,
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DatabaseHelper.deleteUser(widget.newsResult['id']).then((_) {
                            Navigator.pop(context, true);
                          CustomToast.show(context, "News Deleted From Saved News");
                          });
                        },
                        child: BlurryContainer(
                            elevation: 0.6,
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FittedBox(
                      child: Center(
                          child: Text(
                            widget.newsResult != null
                                ? widget.newsResult['category'].toString().replaceAll('[', '').replaceAll(']', '')
                                : widget.news!.category.toString().replaceAll('[', '').replaceAll(']', ''),
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          )),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    widget.newsResult != null
                        ? widget.newsResult['title'].toString()
                        : widget.news!.title.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(25),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: sourceIconPath != null
                                ? Image.file(
                              File(sourceIconPath),
                              fit: BoxFit.cover,
                            )
                                : Container(),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          widget.newsResult != null
                              ? widget.newsResult['source_name'].toString()
                              : widget.news!.sourceName.toString(),
                          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.newsResult != null
                          ? widget.newsResult['description'].toString()
                          : widget.news!.description.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: (){

                         Navigator.push(context, MaterialPageRoute(builder: (_)=>WebViewScreen(url:widget.newsResult['link'].toString() )));
                      },
                      child: Text(
                        "Read More....",
                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue, fontSize: 16.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ) : Stack(
        children: [
          Container(
            width: double.infinity,
            height: 60.h,
            child: Image.network(
              widget.news!.imageUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: BlurryContainer(
                            elevation: 0.6,
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
            GestureDetector(
              onTap: () async {
                var imageUrl = await downloadAndSaveImage(widget.news!.imageUrl.toString());
                var sourceIcon = await downloadAndSaveImage(widget.news!.sourceIcon.toString());
                var news = NewsResult(
                  title: widget.news!.title.toString(),
                  link: widget.news!.link.toString(),
                  description: widget.news!.description.toString(),
                  imageUrl: imageUrl!,
                  sourceName: widget.news!.sourceName.toString(),
                sourceIcon: sourceIcon!,
                  category: widget.news!.category.toString(),
                  articleId: widget.news!.articleId.toString(), // Ensure ID is set
                );

                await databaseHelper.insertUser(news);
                CustomToast.show(context, "News Saved successfully");
              },
              child: BlurryContainer(
                  elevation: 0.6,
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  )),
            ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FittedBox(
                      child: Center(
                          child: Text(
                            widget.news!.category.toString().replaceAll('[', '').replaceAll(']', ''),
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          )),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    widget.news!.title.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(25),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              widget.news!.sourceIcon.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          widget.news!.sourceName.toString(),
                          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.news!.description.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>WebViewScreen(url:widget.news!.link.toString() )));
                      },
                      child: Text(
                        "Read More....",
                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue, fontSize: 16.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> downloadAndSaveImage(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) return null;

      Dio dio = Dio();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String imageName = imageUrl.split('/').last;
      String filePath = '$tempPath/$imageName';

      await dio.download(imageUrl, filePath);

      return filePath;
    } catch (e) {
      print("Error downloading or saving image: $e");
      return null;
    }
  }
}
