import 'dart:io'; // Import this to work with File
import 'package:flutter/material.dart';
import 'package:hindi_news/model/result_model.dart';
import 'package:hindi_news/service/sqlite_service.dart';
import 'package:sizer/sizer.dart';

import 'news_deatils_screen.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  List newsList = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    newsList = await DatabaseHelper.getTask();
    print("news list is /////////////////////////////$newsList");
    setState(() {}); // Call setState to refresh the UI
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newsList.isEmpty?Center(child: Text("No Saved News"),): ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          final imagePath = news['image_url'].toString();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailsScreen(
                      newsResult: news,
                      saved: true,
                    ),
                  ),
                );

                if (result == true) {
                  // Data was deleted, refresh the list
                  getNews();
                }
              },
              child: Container(

                height: 15.h,
              width:   double.infinity,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 30.w,
                        height: 15.h,
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news['category'].toString().replaceAll('[', '').replaceAll(']', ''),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Color(0xff948686),
                            ),
                          ),
                          Text(
                            news['title'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.5.sp,
                            ),
                            maxLines: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                news['source_name'].toString(),
                                style: TextStyle(
                                  color: Color(0xff948686),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              CircleAvatar(
                                radius: 13,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    File(news['source_icon'].toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
