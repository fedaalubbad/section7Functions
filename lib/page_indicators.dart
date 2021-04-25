import 'package:flutter/material.dart';
class PageIndicator extends StatelessWidget{
 final int _index;

  const PageIndicator(this._index);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          buildContainer(0),
          buildContainer(1),
          buildContainer(2),
          buildContainer(3),
          buildContainer(4),
          buildContainer(5),

        ],
    );
  }

  Widget buildContainer(int index){
    return
      index !=_index?
     Container(
      margin: EdgeInsets.all(2),
      height:12,
      width: 12,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
      ),
    )
    :
    Icon(Icons.favorite,size:18 ,color: Colors.red,);

  }
}