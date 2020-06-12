import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>
      [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage("assets/actual.png"),
                  fit: BoxFit.contain
              )
          ),
        ),

        SizedBox(height: 40,),

        Text(
          "Title",
          style: TextStyle(
            fontSize: 22,
          ),
        ),

      ],
    );
  }
}
