

import 'package:flutter/material.dart';
import 'package:mdrasty_app/parent/note.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/appbarchild.dart';
import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:mdrasty_app/style/list.dart';
// import 'package:intl/intl.dart';

// import 'drwer.dart/custom_drawer.dart';





class viewassigment extends StatefulWidget {
  @override
  _viewassigmentState createState() => _viewassigmentState();
}

class _viewassigmentState extends State<viewassigment> {
    void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar:appbarchild(title: "الواجبات"),
        
        body: ListView.builder(
          itemCount: assig.length,
          itemBuilder: (context, index) {
            final ass = assig[index];
          
    
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card( 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                    leading  : const CircleAvatar(
                      // backgroundImage:AssetImage("images/1.jpg"),
                      ),
                      title:  Align(alignment: Alignment.topRight,
                        child: Text(
                      ass.name,
                        style: fonttitlestyle.fonttitle,
                        ),
                        
                      ),
                      subtitle:    Align(alignment: Alignment.topRight,
                        child: Text(
                          // '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                          ass.data
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                          if (value == 'حذف') {
                          _deleteNotification(index);
                        }
                      },
                      itemBuilder: (context) => [
                    
                      const  PopupMenuItem<String>(
                          value: 'حذف',
                          child: Center(
                            child: Text('حذف'
                            ,style: TextStyle(color: Colors.red,fontSize: 17,  fontWeight: FontWeight.bold,),),
                          ),
                        ),
                      ],
                    ),
                      // Timestamp on the top left corner
                    
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          ass.titile,
                            style: fonttitlestyle.fonttitle
                          ),
                           SizedBox(
                            height: 5,
                          ),
                          Text(
                            ass.content,
                            style: fonttitlestyle.fonttitle),
                            SizedBox(height: 10,),
                               Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                              Text(
                              'موعد التسليم : ${ass.data2}',style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                                InkWell(
                                onTap: () {
            // عند الضغط على الزر "عرض"
            // _viewPdf(context); // استدعاء دالة عرض الملف PDF مع تمرير السياق
                                                  },
                             child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                 colors: [
                                  Colors.indigo.shade500,
                                      Colors.blue.shade300,
                                      Colors.indigo.shade800,
                                        ],
                                       ),
                                      borderRadius:const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                           ),
                                        ),
                                  child:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                 children: [
              
                                       Text(
                                         'ادراج ملف',
                                     style:fontwhite.fonttitle
                                         ),
                                          ],
              
                                       ),
                                          ),
                                         ),
                    
                             ],
                           ),
                              Text(" الدرجة: ${ass.grde}",style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      
      ),
    );
  }

  
}


