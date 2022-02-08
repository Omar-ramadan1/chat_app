import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
final String text;
final VoidCallback onpressed;
ButtonWidget(this.text,this.onpressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration( 
       // border: BorderRadius(),
         gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight, 
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.black87,
                      
                    ]
                    ),
                    ),
      
      child: FlatButton(

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  
                  onPressed: onpressed,
                  //color: Colors.black,
                  
                
                 child: Text(text,style: TextStyle(
                   color: Colors.white,
                   
                 ),
                 
                 ),
                 
                 
                 
                 ),
    );
  }
}