
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';

import 'package:mdrasty_app/parent/children.dart';
import 'package:mdrasty_app/parent/profile.dart';

import 'package:mdrasty_app/student/viewnotification.dart';

import 'notivications.dart';




 

 

class tabsparent extends StatefulWidget { 
  @override 
  tabsparentState createState() => tabsparentState(); 
} 
 
class tabsparentState extends State<tabsparent> { 
  var currentIndex = 0; 
 
   
   
 
   
  void onTabChange(int index) { 
    setState(() { 
      currentIndex = index; 
    }); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    double displayWidth = MediaQuery.of(context).size.width; 
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold( 
      
        body: IndexedStack( 
          index: currentIndex, 
          children: [ 
            
      
        children(),
        notificationparent(),  
        Profileparent(),
        
        
        
         
            
             
          ], 
        ), 
        bottomNavigationBar: Container( 
          margin: EdgeInsets.all(displayWidth * .05), 
          height: displayWidth * .155, 
          decoration: BoxDecoration( 
            color: Colors.white, 
            boxShadow: [ 
              BoxShadow( 
                color: Colors.black.withOpacity(.1), 
                blurRadius: 30, 
                offset: Offset(0, 10), 
              ), 
            ], 
            borderRadius: BorderRadius.circular(50), 
          ), 
          child: ListView.builder( 
            itemCount: 3, 
            scrollDirection: Axis.horizontal, 
            padding: EdgeInsets.symmetric(horizontal: displayWidth * .02), 
            itemBuilder: (context, index) => InkWell( 
              onTap: () { 
                onTabChange(index); // Call the custom onTabChange method 
                HapticFeedback.lightImpact(); 
              }, 
              splashColor: Colors.transparent, 
              highlightColor: Colors.transparent, 
              child: Stack( 
                children: [ 
                  AnimatedContainer( 
                    duration: Duration(seconds: 1), 
                    curve: Curves.fastLinearToSlowEaseIn, 
                    width: index == currentIndex 
                        ? displayWidth * .32 
                        : displayWidth * .18, 
                    alignment: Alignment.center, 
                    child: AnimatedContainer( 
                      duration: Duration(seconds: 1), 
                      curve: Curves.fastLinearToSlowEaseIn, 
                      height: index == currentIndex ? displayWidth * .12 : 0, 
                      width: index == currentIndex ? displayWidth * .32 : 0, 
                      decoration: BoxDecoration( 
                        color :Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(50), 
                      ), 
                    ), 
                  ), 
                  AnimatedContainer( 
                    duration: Duration(seconds: 1), 
                    curve: Curves.fastLinearToSlowEaseIn, 
                    width: index == currentIndex 
                        ? displayWidth * .31 
                        : displayWidth * .18, 
                    alignment: Alignment.center, 
                    child: Stack( 
                      children: [ 
                        Row( 
                          children: [ 
                            AnimatedContainer( 
                              duration: Duration(seconds: 1), 
                              curve: Curves.fastLinearToSlowEaseIn, 
                              width: 
                                  index == currentIndex ? displayWidth
    * .13 : 0, 
                            ), 
                            AnimatedOpacity( 
                              opacity: index == currentIndex ? 1 : 0, 
                              duration: Duration(seconds: 1), 
                              curve: Curves.fastLinearToSlowEaseIn, 
                              child: Text( 
                                index == currentIndex 
                                    ? '${listOfStrings[index]}' 
                                    : '', 
                                style: TextStyle( 
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w600, 
                                  fontSize: 15, 
                                ), 
                              ), 
                            ), 
                          ], 
                        ), 
                        Row( 
                          children: [ 
                            AnimatedContainer( 
                              duration: Duration(seconds: 1), 
                              curve: Curves.fastLinearToSlowEaseIn, 
                              width: 
                                  index == currentIndex ? displayWidth * .03 : 20, 
                            ), 
                            Icon( 
                              listOfIcons[index], 
                              size: displayWidth * .076, 
                              color: index == currentIndex 
                                  ? Colors.white 
                                  : Colors.black26, 
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
        ), 
      ),
    ); 
  } 
 
  List<IconData> listOfIcons = [ 
    Icons.child_care,
    Icons.notifications, 
    Icons.person, 
  ]; 
 
  List<String> listOfStrings = [ 
    
    'الابناء', 
    'الاشعارات', 
    ' حسابي', 
  ]; 
}