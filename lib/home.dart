import 'package:flutter/material.dart';
import 'categ.dart';
import 'categorypage.dart';
import 'data.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'newsdata.dart';
import 'newsmodel.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override



  // get our newslist first

  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });


  }






  List<Model> categories = [];

  void initState() {
    super.initState();
    categories = getCategories();
     getNews();

  }




  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0.0,


        title: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            Text('Flutter',

              style: TextStyle(

                color: Colors.black,
                fontSize: 20,

              ),



            ),


            Text('News',

              style: TextStyle(

                color: Colors.blue,
                fontSize: 20,

              ),



            ),




          ],),


      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(

        ),

      ): SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [

              Container(
                  height: 70,

                  child : ListView.builder(

                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)
                      {
                        return CategoryTile(

                          imageurl: categories[index].imageurl,
                          name: categories[index].name,


                        );
                      }

                  )
              ),
              Container(
                child: ListView.builder(
                  itemCount:  articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true, // add this otherwise an error
                  itemBuilder: (context, index) {

                    return NewsTemplate(
                      urlToImage: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                      url: articles[index].url,

                    );


                  } ,
                ),
              ),





            ],),



        ),
      ),



    );
  }
}


class CategoryTile extends StatelessWidget {

  @override
  final String name , imageurl;

  CategoryTile( { required this.imageurl , required this.name});



  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryFragment(
              category: name.toLowerCase(),
            ),
          ));

        },
        child:Container(

        margin: EdgeInsets.only(right: 18),

        child: Stack(

          children: [


            // ClipRect(

            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: CachedNetworkImage(
                imageUrl: imageurl,
                height: 100.0,
                width: 90.0,
              ),
            ),
            Container(

                alignment: Alignment.center,
                width: 100,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.transparent,


                ),
              child : Text(
                name,
                style: TextStyle(
                color:Colors.white,
                  fontSize: 15,
                ),


              )

            )


          ],



        )



)
    );
  }
}


class NewsTemplate extends StatelessWidget {

  String title, description,url,   urlToImage;
  NewsTemplate({required this.title,required this.description,required this.urlToImage,required this.url });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),

      child: Column(

        children: <Widget>[

          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: urlToImage, width: 380, height: 200, fit: BoxFit.cover,)),

          SizedBox(height: 8),

          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),),

          SizedBox(height: 8),

          Text(description, style: TextStyle( fontSize: 15.0, color: Colors.grey[800]),),



        ],



      ),
    );
  }
}


