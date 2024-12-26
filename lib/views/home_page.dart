import 'package:flutter/material.dart';
import 'package:gnews/models/news_model.dart';
import 'package:gnews/utils/helper/news_api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ResultModel>?> getData;

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apiHelper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Feed")),
      body: FutureBuilder<List<ResultModel>?>(
        future: getData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR: ${snapshot.error}',
                  style: TextStyle(fontSize: 18)),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            List<ResultModel> data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            data[index].title ?? 'No Title',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data[index].image_Url != null)
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(data[index].image_Url!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            data[index].description ??
                                'No description available',
                            style: TextStyle(fontSize: 16),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // If no data is available, show a message
          return Center(
            child: Text('No data available', style: TextStyle(fontSize: 18)),
          );
        },
      ),
    );
  }
}
