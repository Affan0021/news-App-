import 'dart:convert';
// import 'services.dart';
import 'newsmodel.dart';
import 'package:http/http.dart'as http;

class News {

  // save json data inside this
  List<ArticleModel> datatobesavedin = [];


  Future<void> getNews() async {

    // final cryptoUrl = ;
    var response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b08c863ab5be46e288ccf4f562e6b40d"));


    if (response.statusCode != 200) {

      throw Exception('Unable to fetch products from the REST API');
    }

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {

      jsonData['articles'].forEach((element) {


        if (element['urlToImage']!=null && element['description']!=null) {

          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );


          datatobesavedin.add(articleModel);


        }


      });

    }

  }

}


class CategoryNews {

  List<ArticleModel> datatobesavedin = [];


  Future<void> getNews(String category) async {

    var response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b08c863ab5be46e288ccf4f562e6b40d"));

    var jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {

      jsonData['articles'].forEach((element) {


        if (element['urlToImage']!=null && element['description']!=null) {

          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );


          datatobesavedin.add(articleModel);


        }


      });

    }




  }

}
