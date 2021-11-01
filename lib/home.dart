import 'package:flutter/material.dart';
import 'categ.dart';
import 'data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override


  List<Model> categories = [];

  void initState() {
    super.initState();
    categories = getCategories();
    // getNews();

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
      body: Container(



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




          ],),



      ),



    );
  }
}


class CategoryTile extends StatelessWidget {

  @override
  final String name , imageurl;

  CategoryTile( { required this.imageurl , required this.name});



  Widget build(BuildContext context) {
    return Container(

        child: Stack(

          children: [

            CachedNetworkImage(

              imageUrl: imageurl,
              width: 110,
              height: 110,
            )
          ],



        )




    );
  }
}



