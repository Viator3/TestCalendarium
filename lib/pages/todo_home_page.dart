// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:calendarium/todos_collection.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class TodoHomePage extends StatefulWidget {
//   @override
//   _TodoHomePageState createState() => _TodoHomePageState();
// }
//
// class _TodoHomePageState extends State<TodoHomePage> {
//   late final dynamic data;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             _buildTopBar(context),
//             _buildBodyContent(context),
//             _buildBottomBar(context)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Stack _buildTopBar(BuildContext context) {
//     const colorizeColors = [
//       Colors.white,
//       Colors.purple,
//       Colors.blue,
//       Colors.yellow,
//       Colors.red,
//     ];
//
//     const colorizeTextStyle = TextStyle(
//       fontSize: 46.0,
//       fontFamily: 'RobotoMono',
//       fontWeight: FontWeight.w800,
//     );
//
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity, // MediaQuery.of(context).size.width
//           height: 140,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: AssetImage('assets/bg_header.png'),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           bottom: 0,
//           child: Container(
//             height: 20.0,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0)),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 20,
//           top: 34,
//           child: SizedBox(
//             width: 250.0,
//             child: AnimatedTextKit(
//               animatedTexts: [
//                 ColorizeAnimatedText(
//                   'TODOa',
//                   textStyle: colorizeTextStyle,
//                   colors: colorizeColors,
//                   speed: const Duration(seconds: 3),
//                 ),
//               ],
//               isRepeatingAnimation: false,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBodyContent(BuildContext context) {
//     return Expanded(
//       child: StreamBuilder(
//         stream: Provider.of<TodosCollection>(context).getCollectionAsSteam(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot) {
//           if (!asyncSnapshot.hasData) {
//             return Center(
//               child: Text('Loading....'),
//             );
//           }
//
//           List<Widget> todoWidgets = [];
//           asyncSnapshot.data.docs.forEach((DocumentSnapshot docs) {
//             final id = docs.id;
//
//             bool isSelected = docs.data()!['isSelected'];
//             String title = docs.data()!['todo'];
//
//             final item = TileItem(
//               title: title,
//               isChecked: isSelected,
//               onCheckedChanges: (bool isChecked) {
//                 Provider.of<TodosCollection>(context)
//                     .updateItem(id, isSelected, title);
//               },
//             );
//
//             todoWidgets.add(item);
//           });
//
//           return ListView(
//             children: todoWidgets,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildBottomBar(BuildContext context) {
//     return BottomButton(
//         title: 'Add Item',
//         onTap: () {
//           showModalBottomSheet<void>(
//             context: context,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return Container(
//                 height: 220,
//                 color: Color(0xff757575),
//                 child: AddTaskPage(),
//               );
//             },
//           );
//         });
//   }
// }
