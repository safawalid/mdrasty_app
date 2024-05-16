
import 'package:flutter/material.dart';
import 'package:mdrasty_app/parent/note.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/appbarchild.dart';
import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:mdrasty_app/style/list.dart';
// import 'package:intl/intl.dart';






class viewnotification2 extends StatefulWidget {
  @override
  _viewnotification2State createState() => _viewnotification2State();
}

class _viewnotification2State extends State<viewnotification2> {
    void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar: appbarchild(title: "الاشعارات"),
      
        body: ListView.builder(
          itemCount: noti.length,
          itemBuilder: (context, index) {
            final notifi = noti[index];
          
    
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
                      notifi.name,
                        style: fonttitlestyle.fonttitle,
                        ),
                        
                      ),
                      subtitle:    Align(alignment: Alignment.topRight,
                        child: Text(
                          // '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                          notifi.data
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
                          notifi.titile,
                            style: fontstyle.fontheading
                          ),
                           SizedBox(
                            height: 20,
                          ),
                          Text(
                            notifi.content,
                            style: fonttitlestyle.fonttitle)
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

// class AddNotificationDialog extends StatefulWidget {


  

//   @override
//   _AddNotificationDialogState createState() => _AddNotificationDialogState();
// }

// class _AddNotificationDialogState extends State<AddNotificationDialog> {


  

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(30),
//       height: MediaQuery.of(context).size.height * 0.75,
//       decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.blueGrey.shade200,
//                   Colors.blue.shade800,
                  
//                   Colors.blue.shade900,
//                 ],
//               ),
//           borderRadius: BorderRadius.circular(16)
//             ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Text(
//               widget.notification == null ? 'اشعار جديد' : 'تعديل الاشعار',
//               textAlign: TextAlign.center,
//               style:fontwhite.fonttitle
//             ),
//           ),
//           Expanded(
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Divider(
//                       thickness: 1.2,
//                       color: Colors.grey.shade200,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   const  Padding(
//                        padding:  EdgeInsets.only(right: 15),
//                       child:  Text(
//                         "العنوان ",
                      
//                         style: fontwhite.fonttitle)
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: TextFormField(
//                         controller: _titleController,
//                         textAlign: TextAlign.right,
//                         decoration: InputDecoration(
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
                          
//                         ),
//                         maxLines: 1,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return '';
//                           }
//                           return null; // Input is valid
//                         },
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                 const    Padding(
//                      padding:  EdgeInsets.only(right: 15),
//                       child: Text(
//                         "الاشعار",
                  
//                         style:fontwhite.fonttitle
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: TextFormField(
//                           textAlign: TextAlign.right,
//                           controller: _contentController,
//                           decoration: const InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                               alignLabelWithHint: true,
                          
//                           ),
//                           maxLines: 5,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return '';
//                             }
//                             return null; // Input is valid
//                           },
//                         )),
                  
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextButton(
//                           child: const Text('الغاء'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         TextButton(
//                           child: Text(widget.notification != null
//                               ? 'تعديل'
//                               : 'ارسال'),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _submit();
//                             }
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
