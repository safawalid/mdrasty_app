// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/style/appbar.dart';
// import 'package:mdrasty_app/style/fontstyle.dart';

// import 'package:mdrasty_app/style/list.dart';

// import 'bottomnav.dart';


// class subjeect extends StatefulWidget {
//   const subjeect({Key? key}) : super(key: key);

//   @override
//   State<subjeect> createState() => _subjeectState();
// }

// class _subjeectState extends State<subjeect> {
//   final _controller = PageController();
//   final _notifierscroll = ValueNotifier(0.0);
//   @override
//   void _listner() {
//     _notifierscroll.value = _controller.page!;
//   }

//   void initState() {
//     _controller.addListener(_listner);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_listner);
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final bookwidth = size.width * 0.6;
//     final bookhight = size.height * 0.40;

//     return Directionality(textDirection: TextDirection.ltr,
//       child: Directionality(textDirection: TextDirection.rtl,
//         child: Scaffold(
//             appBar:CustomAppBar(title: "مدرستي",),
          
//             drawer: CustomDrawer(),
//           body: Stack(
            
//             children: [
//               ValueListenableBuilder<double>(
//                   valueListenable: _notifierscroll,
//                   builder: (context, value, _F) {
//                     return PageView.builder(
                      
//                         controller: _controller,
//                         itemCount: subj.length,
//                         itemBuilder: (context, index) {
//                           final sub = subj[index];
//                           final precentpage = index - value;
//                           final rotation = precentpage.clamp(0.0, 1.0);
//                           final fixrotatin = pow(rotation, 0.35);
                          
//                           return Padding(
//                             padding: const EdgeInsets.all(80),
                            
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
                                  
//                                    child: Stack(
//                                 children: [
//                                   Container(
//                                     height: bookhight,
//                                     width: bookwidth,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                              color: Color(0xFF354C6C),
//                                           blurRadius: 2,
//                                           // offset: Offset(5.0, 5.0),
//                                           spreadRadius: 2,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   // لف الصورة مع GestureDetector للتنقل
//                                  for (String image in imagesToPages.keys)
//                                  GestureDetector(
//                                    onTap: () {
//                                     Navigator.push(
//                                     context,
//                                      MaterialPageRoute(
//                                     builder: (context) => getWidgetForImage(sub.image),
//                                               ),
//                                                 );
//                                                     }
            
//                                     ,child: Transform(
//                                       alignment: Alignment.centerLeft,
//                                       transform: Matrix4.identity()
//                                         ..setEntry(3, 2, 0.002)
//                                         ..rotateY(1.8 * fixrotatin)
//                                         ..translate(-rotation * size.width * 0.8)
//                                         ..scale(1 + rotation),
//                                       child: Image.asset(sub.image,
//                                           fit: BoxFit.cover,
//                                           height: bookhight,
//                                           width: bookwidth),
//                                     ),
//                                    )],
//                                 )),
                              
//                                 Expanded(
//                                   flex: 5,
//                                   child: Center(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(bottom: 30),
//                                           child: Text(
//                                             sub.name,
//                                                 style:fontstyle.fontheading,
                                                
                                                                        
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         });
//                   }),
              
//             ],
//           ),
          
//         ),
//       ),
//     );
//   }
// }


