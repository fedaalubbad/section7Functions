import 'dart:async';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:section7/main.dart';
import 'package:section7/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PView extends StatefulWidget{
  @override
  _PViewState createState() => _PViewState();

}
class _PViewState extends State<PView> {
 final List <Data> pagesList=[
    Data(title:'fedaa lubbad',description:'acfskdashvbkdsj\nsahdbvja',imgUrl:'assets/images/s2.jpg',iconData:Icons.add_a_photo),
    Data(title:'kjsdvfkhsdbv',description:'fndskjndf',imgUrl:'assets/images/s3.jpg',iconData:Icons.add_circle_outline),
    Data(title:'kjsdvfkhsdbv',description:'fndskjndf',imgUrl:'assets/images/q1.jpg',iconData:Icons.add_call),
    Data(title:'kjsdvfkhsdbv',description:'fndskjndf',imgUrl:'assets/images/q2.jpg',iconData:Icons.video_library),
   Data(title:'hello world',description:'ffff kfhvk s,dnds',imgUrl:'assets/images/s1.jpg',iconData:Icons.photo_filter),
   Data(title:'kjsdvfkhsdbv',description:'fndskjndf',imgUrl:'assets/images/q3.jpg',iconData:Icons.check_circle_outline),
  ];
 int _currentIndex=0;
 PageController _pageController=PageController(initialPage: 1);
@override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      if(_currentIndex<5){
        _currentIndex++;
        _pageController.animateToPage(_currentIndex, duration: Duration(microseconds: 3000), curve: Curves.easeIn);
      }
    });
  }
 // static const length = pagesList.length;
 final pageIndexNotifier = ValueNotifier<int>(0);
 @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/a': (ctx) => MyHomePage(),
      '/b': (ctx) => MainSplashScreen(),
    },
    home: Scaffold(
      body: Stack(
        alignment: Alignment(0,0.7),
        children:[
          Builder(
            builder:(mCtx)=> Align(
              alignment: Alignment.center,
              child: PageView(
                onPageChanged: (index){
                  pageIndexNotifier.value=index;
                  setState(() {
                    _currentIndex=index;
                    if(_currentIndex==5) {
                      Future.delayed(Duration(seconds:2),()=>Navigator.of(mCtx).pushReplacementNamed('/b'));
                    }
                  });
                },
                controller:_pageController,
                children: [
                  ...pagesList.map((page) {
                    return Container(
                      decoration:BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage(page.imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(page.iconData,size: 80,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(page.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 10,),
                          Text(page.description,style: TextStyle(color: Colors.lightBlue,fontSize: 18,),),
                        ],

                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

          ),
             // _buildExample1(),
             // _buildExample2(),
             _buildExample3(),

          // PageIndicator(_currentIndex),
        Builder(
          builder: (ctx)=>Align(
          alignment: Alignment(0.0,0.93),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: RaisedButton (
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('Go home page!',style: TextStyle(fontSize: 18),),
              onPressed: () async{
                SharedPreferences prefs= await SharedPreferences.getInstance();
                prefs.setBool('x', true);
                Navigator.of(ctx).pushReplacementNamed('/b');

              },
            ),
          ),
          ),
        ),
        ],
      ),
    ),
  );
  }
 PageViewIndicator _buildExample1() {
   return PageViewIndicator(
     pageIndexNotifier: pageIndexNotifier,
     length: pagesList.length,
     normalBuilder: (animationController, index) => Circle(//inactive
       size: 8.0,
       color: Colors.black87,
     ),
     highlightedBuilder: (animationController, index) => ScaleTransition(//active
       scale: CurvedAnimation(
         parent: animationController,
         curve: Curves.ease,
       ),
       child: Circle(
         size: 12.0,
         color: Colors.accents.elementAt((index + 3) * 3),
       ),
     ),
   );
 }

 PageViewIndicator _buildExample2() {
   return PageViewIndicator(
     pageIndexNotifier: pageIndexNotifier,
     length: pagesList.length,
     normalBuilder: (animationController, index) => Circle(
       size: 8.0,
       color: Colors.black87,
     ),
     highlightedBuilder: (animationController, index) => ScaleTransition(
       scale: CurvedAnimation(
         parent: animationController,
         curve: Curves.ease,
       ),
       child: Circle(
         size: 8.0,
         color: Colors.white,
       ),
     ),
   );
 }

 PageViewIndicator _buildExample3() {
   return PageViewIndicator(
     pageIndexNotifier: pageIndexNotifier,
     length: pagesList.length,
     normalBuilder: (animationController, index) => ScaleTransition(
       scale: CurvedAnimation(
         parent: animationController,
         curve: Curves.ease,
       ),
       child: Icon(Icons.favorite, color: Colors.black87),
     ),
     highlightedBuilder: (animationController, index) => ScaleTransition(
       scale: CurvedAnimation(
         parent: animationController,
         curve: Curves.ease,
       ),
       child: Icon(Icons.star, color: Colors.white),
     ),
   );
 }
}
class Data {
  final String title;
  final String description;
  final String imgUrl;
  final IconData iconData;

  Data({@required this.title,@required this.description,@required this.imgUrl,@required this.iconData});




}