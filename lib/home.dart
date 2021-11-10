import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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


  TextEditingController _emailTEC = TextEditingController();

  Widget build(BuildContext context) {

    var query = MediaQuery.of(context);
    var height = query.size.height;
    var width =  query.size.width;

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

                width: MediaQuery.of(context).size.width/1.07,
                height: MediaQuery.of(context).size.height/15,
                margin: EdgeInsets.only(left: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'OpenSans',

                  ),
                  controller: _emailTEC,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.blue,
                      iconSize: 30,
                      onPressed: ()
                      {
                        var _email = _emailTEC.text;
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CategoryFragment(
                            category: _email.toLowerCase(),
                          ),
                        )
                        );
                      },
                    ),

                    // focusedBorder: OutlineInputBorder(
                    //
                    //   borderSide: BorderSide(
                    //     color: Colors.blue,
                    //     width: 3,
                    //
                    //   ),
                    //   borderRadius: BorderRadius.circular(20),
                    //
                    // ),

                    hintText: '\t\t  Search Any News',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey, // <-- Change this
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  // onChanged: (value) {
                  //   setState(() {
                  //     _email = value.trim();
                  //   });
                  // },
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.9 ,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // color: const Color(0xff7cb1b6),
                ),
              ),


              SizedBox(
                height: height / 35,
              ),



              Container(
              width: width / 1.10,
              child : Text(
                'Categories',
                style: TextStyle(

                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 27.0,
                  fontWeight: FontWeight.w500,

                ),

              ),
              ),

              Container(
                  // height: 100,
                height: height / 8,
                padding: EdgeInsets.only(left: 15),
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
                width: width / 1.10,
                child : Text(
                  'Latest',
                  style: TextStyle(

                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 27.0,
                    fontWeight: FontWeight.w500,

                  ),

                ),
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
          )
          );
        },

        child:Container(

        margin: EdgeInsets.only(right: 18),

        child: Stack(

          children: [


            // ClipRect(

            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: imageurl,
                height: 130.0,
                width: 115.0,
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


