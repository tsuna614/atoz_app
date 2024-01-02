// // // // // // import 'package:atoz_app/src/widgets/animated_button_1.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:atoz_app/src/data/questions.dart';
// // // // // // import 'package:atoz_app/src/providers/question_provider.dart';
// // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // // import 'package:dio/dio.dart';

// // // // // // final dio = Dio();

// // // // // // class TestWidget extends ConsumerWidget {
// // // // // //   const TestWidget({super.key});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // // // //     final questions = ref.watch(questionsProvider);
// // // // // //     var userEmail;

// // // // // //     void getRequest() async {
// // // // // //       Response response;
// // // // // //       response = await dio.get("http://localhost:3000/v1/user/getAllUsers");
// // // // // //       print(response.data.toString());
// // // // // //       userEmail = response.data[0]["email"].toString();
// // // // // //     }

// // // // // //     getRequest();

// // // // // //     // return Scaffold(
// // // // // //     //   body: Container(
// // // // // //     //     child: Column(
// // // // // //     //       children: [
// // // // // //     //         SizedBox(
// // // // // //     //           height: 100,
// // // // // //     //         ),
// // // // // //     //         Text(userEmail.toString()),
// // // // // //     //         // Expanded(child: Container()),
// // // // // //     //         // ElevatedButton(onPressed: () {}, child: const Text('Continue'))
// // // // // //     //       ],
// // // // // //     //     ),
// // // // // //     //   ),
// // // // // //     // );
// // // // // //     return Scaffold(
// // // // // //       body: Center(
// // // // // //         child: AnimatedButton1(buttonText: 'buttonText', voidFunction: () {}),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // import 'package:awesome_dialog/awesome_dialog.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';

// // class TestWidget extends StatelessWidget {
// //   const TestWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // backgroundColor: Colors.lightBlue,
// //       body: Stack(
// //         children: [
// //           // Center(
// //           //   child: ElevatedButton(
// //           //       onPressed: () {
// //           //         AwesomeDialog(
// //           //           context: context,
// //           //           dialogType: DialogType.error,
// //           //           animType: AnimType.rightSlide,
// //           //           title: 'Dialog Title',
// //           //           desc: 'Dialog description here.............',
// //           //           btnOkText: 'Next',
// //           //           btnCancelOnPress: () {},
// //           //         ).show();
// //           //       },
// //           //       child: Text('Press')),
// //           // )
// //           ClipPath(
// //             clipper: CustomClipPathBlue(),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                   // gradient: LinearGradient(
// //                   //   begin: Alignment.topLeft,
// //                   //   end: Alignment.bottomRight,
// //                   //   colors: [
// //                   //     Colors.purple,
// //                   //     Colors.lightBlue,
// //                   //   ],
// //                   // ),
// //                   color: Colors.blue),
// //               child: Center(
// //                 child: Text('Clip path'),
// //               ),
// //             ),
// //           ),
// //           // ClipPath(
// //           //   clipper: CustomClipPathPurple(),
// //           //   child: Container(
// //           //     decoration: BoxDecoration(
// //           //       gradient: LinearGradient(
// //           //         begin: Alignment.topLeft,
// //           //         end: Alignment.bottomRight,
// //           //         colors: [
// //           //           Colors.purple,
// //           //           Colors.lightBlue,
// //           //         ],
// //           //       ),
// //           //     ),
// //           //     child: Center(
// //           //       child: Text('Clip path'),
// //           //     ),
// //           //   ),
// //           // ),
// //           // ClipPath(
// //           //   clipper: CustomClipPathWhite(),
// //           //   child: Container(
// //           //     decoration: BoxDecoration(
// //           //         // gradient: LinearGradient(
// //           //         //   begin: Alignment.topLeft,
// //           //         //   end: Alignment.bottomRight,
// //           //         //   colors: [
// //           //         //     Colors.purple,
// //           //         //     Colors.lightBlue,
// //           //         //   ],
// //           //         // ),
// //           //         color: Colors.white),
// //           //     child: Center(
// //           //       child: Text('Clip path'),
// //           //     ),
// //           //   ),
// //           // ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CustomClipPathBlue extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     print(size);
// //     double w = size.width;
// //     double h = size.height;

// //     final path = Path();

// //     path.moveTo(0, 0);
// //     path.lineTo(0, h * 0.2);
// //     // create a s shaped line to x = w, y = h * 0.2
// //     path.quadraticBezierTo(w * 0.1, h * 0.15, w * 0.5, h * 0.2);
// //     path.quadraticBezierTo(w * 0.8, h * 0.25, w, h * 0.2);
// //     // path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.3);
// //     path.lineTo(w, 0);
// //     path.close();

// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) {
// //     return false;
// //   }
// // }

// // class CustomClipPathPurple extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     print(size);
// //     double w = size.width;
// //     double h = size.height;

// //     final path = Path();

// //     path.moveTo(0, 0);
// //     path.lineTo(0, h * 0.2);
// //     path.quadraticBezierTo(w * 0.25, h * 0.25, w * 0.5, h * 0.2);
// //     path.quadraticBezierTo(w * 0.5, h * 0.15, w, h * 0.15);
// //     path.lineTo(w, 0);
// //     path.close();

// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) {
// //     return false;
// //   }
// // }

// // class CustomClipPathWhite extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     print(size);
// //     double w = size.width;
// //     double h = size.height;

// //     final path = Path();

// //     path.moveTo(0, 0);
// //     path.lineTo(0, h * 0.1);
// //     path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.1);
// //     path.lineTo(w, 0);
// //     path.close();

// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) {
// //     return false;
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/src/widgets/framework.dart';
// // // import 'package:flutter/src/widgets/placeholder.dart';

// // // class TestWidget extends StatelessWidget {
// // //   const TestWidget({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(),
// // //       body: Center(
// // //         child: Draggable(
// // //             child: textContainer('Drag me', Colors.blue),
// // //             feedback: Material(child: textContainer('Dragged', Colors.red))),
// // //       ),
// // //     );
// // //   }

// // //   Widget textContainer(String text, Color color) {
// // //     return Container(
// // //       width: 160,
// // //       height: 100,
// // //       color: color,
// // //       child: Text(text),
// // //     );
// // //   }
// // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/src/widgets/framework.dart';
// // // // import 'package:flutter/src/widgets/placeholder.dart';

// // // // class TestWidget extends StatelessWidget {
// // // //   const TestWidget({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(body: AnimatedPositionedExample());
// // // //   }
// // // // }

// // // // class AnimatedPositionedExample extends StatefulWidget {
// // // //   const AnimatedPositionedExample({super.key});

// // // //   @override
// // // //   State<AnimatedPositionedExample> createState() =>
// // // //       _AnimatedPositionedExampleState();
// // // // }

// // // // class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
// // // //   bool selected = false;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SizedBox(
// // // //       width: 200,
// // // //       height: 350,
// // // //       child: Stack(
// // // //         children: <Widget>[
// // // //           AnimatedPositioned(
// // // //             width: selected ? 200.0 : 50.0,
// // // //             height: selected ? 50.0 : 200.0,
// // // //             top: selected ? 50.0 : 150.0,
// // // //             duration: const Duration(milliseconds: 500),
// // // //             curve: Curves.fastOutSlowIn,
// // // //             child: GestureDetector(
// // // //               onTap: () {
// // // //                 setState(() {
// // // //                   selected = !selected;
// // // //                 });
// // // //               },
// // // //               child: const ColoredBox(
// // // //                 color: Colors.blue,
// // // //                 child: Center(child: Text('Tap me')),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/src/widgets/framework.dart';
// // // import 'package:flutter/src/widgets/placeholder.dart';
// // // import 'package:reorderables/reorderables.dart';

// // // class TestWidget extends StatelessWidget {
// // //   const TestWidget({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: SafeArea(
// // //           child: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: WrapExample(),
// // //       )),
// // //     );
// // //   }
// // // }

// // // class WrapExample extends StatefulWidget {
// // //   const WrapExample({super.key});

// // //   @override
// // //   State<WrapExample> createState() => _WrapExampleState();
// // // }

// // // class _WrapExampleState extends State<WrapExample> {
// // //   final double _iconSize = 90;
// // //   late List<Widget> _tiles;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _tiles = <Widget>[
// // //       MultipleChoiceButton(answer: 'This'),
// // //       MultipleChoiceButton(answer: 'is'),
// // //       MultipleChoiceButton(answer: 'the'),
// // //       MultipleChoiceButton(answer: 'test'),
// // //       MultipleChoiceButton(answer: 'sentence'),
// // //     ];
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     void _onReorder(int oldIndex, int newIndex) {
// // //       setState(() {
// // //         Widget row = _tiles.removeAt(oldIndex);
// // //         _tiles.insert(newIndex, row);
// // //       });
// // //     }

// // //     return ReorderableWrap(
// // //         spacing: 8.0,
// // //         runSpacing: 4.0,
// // //         padding: const EdgeInsets.all(8),
// // //         children: _tiles,
// // //         onReorder: _onReorder,
// // //         onNoReorder: (int index) {
// // //           //this callback is optional
// // //           debugPrint(
// // //               '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
// // //         },
// // //         onReorderStarted: (int index) {
// // //           //this callback is optional
// // //           debugPrint(
// // //               '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
// // //         });
// // //   }
// // // }

// // // class MultipleChoiceButton extends StatefulWidget {
// // //   const MultipleChoiceButton({
// // //     super.key,
// // //     required this.answer,
// // //   });

// // //   final String answer;

// // //   @override
// // //   State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
// // // }

// // // class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
// // //   double _padding = 6;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTapDown: (_) {
// // //         setState(() {
// // //           _padding = 0;
// // //         });
// // //       },
// // //       onTapCancel: () {
// // //         setState(() {
// // //           _padding = 6;
// // //         });
// // //       },
// // //       onTapUp: (_) {
// // //         setState(() {
// // //           _padding = 6;
// // //         });
// // //       },
// // //       child: AnimatedContainer(
// // //         padding: EdgeInsets.only(bottom: _padding),
// // //         margin: EdgeInsets.only(top: -(_padding - 6)),
// // //         decoration: BoxDecoration(
// // //           color: Colors.blue,
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         duration: Duration(milliseconds: 50),
// // //         child: Container(
// // //           height: 40,
// // //           decoration: BoxDecoration(
// // //             color: Colors.white,
// // //             border: Border.all(color: Colors.blue),
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //           child: FittedBox(
// // //             fit: BoxFit.fill,
// // //             child: Padding(
// // //               padding: EdgeInsets.all(8),
// // //               child: Text(
// // //                 widget.answer,
// // //                 style: TextStyle(
// // //                   fontSize: 12,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Colors.blue,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';
// // import 'package:atoz_app/main.dart';
// // import 'package:provider/provider.dart';

// // class TestWidget extends StatelessWidget {
// //   const TestWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Page 2'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             FloatingActionButton(
// //               heroTag: "btn1",
// //               key: const Key('increment_floatingActionButton'),

// //               /// Calls `context.read` instead of `context.watch` so that it does not rebuild
// //               /// when [Counter] changes.
// //               onPressed: () => context.read<Counter>().increment(),
// //               tooltip: 'Increment',
// //               child: const Icon(Icons.add),
// //             ),
// //             Text('You have pushed the button this many times:'),
// //             Count(),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         heroTag: "btn2",
// //         onPressed: () {
// //           Navigator.pop(context);
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class TestWidget extends StatelessWidget {
//   const TestWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ExampleDragAndDrop();
//   }
// }

// const List<Item> _items = [
//   Item(
//     name: 'Spinach Pizza',
//     totalPriceCents: 1299,
//     uid: '1',
//     imageProvider: NetworkImage('https://flutter'
//         '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg'),
//   ),
//   Item(
//     name: 'Veggie Delight',
//     totalPriceCents: 799,
//     uid: '2',
//     imageProvider: NetworkImage('https://flutter'
//         '.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg'),
//   ),
//   Item(
//     name: 'Chicken Parmesan',
//     totalPriceCents: 1499,
//     uid: '3',
//     imageProvider: NetworkImage('https://flutter'
//         '.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg'),
//   ),
// ];

// class ExampleDragAndDrop extends StatefulWidget {
//   const ExampleDragAndDrop({super.key});

//   @override
//   State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
// }

// class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
//     with TickerProviderStateMixin {
//   final List<Customer> _people = [
//     Customer(
//       name: 'Makayla',
//       imageProvider: const NetworkImage('https://flutter'
//           '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
//     ),
//     Customer(
//       name: 'Nathan',
//       imageProvider: const NetworkImage('https://flutter'
//           '.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg'),
//     ),
//     Customer(
//       name: 'Emilio',
//       imageProvider: const NetworkImage('https://flutter'
//           '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
//     ),
//   ];

//   final GlobalKey _draggableKey = GlobalKey();

//   void _itemDroppedOnCustomerCart({
//     required Item item,
//     required Customer customer,
//   }) {
//     setState(() {
//       customer.items.add(item);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       appBar: _buildAppBar(),
//       body: _buildContent(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Color(0xFFF64209)),
//       title: Text(
//         'Order Food',
//         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//               fontSize: 36,
//               color: const Color(0xFFF64209),
//               fontWeight: FontWeight.bold,
//             ),
//       ),
//       backgroundColor: const Color(0xFFF7F7F7),
//       elevation: 0,
//     );
//   }

//   Widget _buildContent() {
//     return Stack(
//       children: [
//         SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: _buildMenuList(),
//               ),
//               _buildPeopleRow(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMenuList() {
//     return ListView.separated(
//       padding: const EdgeInsets.all(16),
//       itemCount: _items.length,
//       separatorBuilder: (context, index) {
//         return const SizedBox(
//           height: 12,
//         );
//       },
//       itemBuilder: (context, index) {
//         final item = _items[index];
//         return _buildMenuItem(
//           item: item,
//         );
//       },
//     );
//   }

//   Widget _buildMenuItem({
//     required Item item,
//   }) {
//     return Draggable<Item>(
//       data: item,
//       dragAnchorStrategy: pointerDragAnchorStrategy,
//       feedback: DraggingListItem(
//         dragKey: _draggableKey,
//         photoProvider: item.imageProvider,
//       ),
//       child: MenuListItem(
//         name: item.name,
//         price: item.formattedTotalItemPrice,
//         photoProvider: item.imageProvider,
//       ),
//     );
//   }

//   Widget _buildPeopleRow() {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 8,
//         vertical: 20,
//       ),
//       child: Row(
//         children: _people.map(_buildPersonWithDropZone).toList(),
//       ),
//     );
//   }

//   Widget _buildPersonWithDropZone(Customer customer) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 6,
//         ),
//         child: DragTarget<Item>(
//           builder: (context, candidateItems, rejectedItems) {
//             return CustomerCart(
//               hasItems: customer.items.isNotEmpty,
//               highlighted: candidateItems.isNotEmpty,
//               customer: customer,
//             );
//           },
//           onAccept: (item) {
//             _itemDroppedOnCustomerCart(
//               item: item,
//               customer: customer,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class CustomerCart extends StatelessWidget {
//   const CustomerCart({
//     super.key,
//     required this.customer,
//     this.highlighted = false,
//     this.hasItems = false,
//   });

//   final Customer customer;
//   final bool highlighted;
//   final bool hasItems;

//   @override
//   Widget build(BuildContext context) {
//     final textColor = highlighted ? Colors.white : Colors.black;

//     return Transform.scale(
//       scale: highlighted ? 1.075 : 1.0,
//       child: Material(
//         elevation: highlighted ? 8 : 4,
//         borderRadius: BorderRadius.circular(22),
//         color: highlighted ? const Color(0xFFF64209) : Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 24,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipOval(
//                 child: SizedBox(
//                   width: 46,
//                   height: 46,
//                   child: Image(
//                     image: customer.imageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 customer.name,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: textColor,
//                       fontWeight:
//                           hasItems ? FontWeight.normal : FontWeight.bold,
//                     ),
//               ),
//               Visibility(
//                 visible: hasItems,
//                 maintainState: true,
//                 maintainAnimation: true,
//                 maintainSize: true,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 4),
//                     Text(
//                       customer.formattedTotalItemPrice,
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: textColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             color: textColor,
//                             fontSize: 12,
//                           ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MenuListItem extends StatelessWidget {
//   const MenuListItem({
//     super.key,
//     this.name = '',
//     this.price = '',
//     required this.photoProvider,
//     this.isDepressed = false,
//   });

//   final String name;
//   final String price;
//   final ImageProvider photoProvider;
//   final bool isDepressed;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 12,
//       borderRadius: BorderRadius.circular(20),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: SizedBox(
//                 width: 120,
//                 height: 120,
//                 child: Center(
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 100),
//                     curve: Curves.easeInOut,
//                     height: isDepressed ? 115 : 120,
//                     width: isDepressed ? 115 : 120,
//                     child: Image(
//                       image: photoProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 30),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontSize: 18,
//                         ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     price,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DraggingListItem extends StatelessWidget {
//   const DraggingListItem({
//     super.key,
//     required this.dragKey,
//     required this.photoProvider,
//   });

//   final GlobalKey dragKey;
//   final ImageProvider photoProvider;

//   @override
//   Widget build(BuildContext context) {
//     return FractionalTranslation(
//       translation: const Offset(-0.5, -0.5),
//       child: ClipRRect(
//         key: dragKey,
//         borderRadius: BorderRadius.circular(12),
//         child: SizedBox(
//           height: 150,
//           width: 150,
//           child: Opacity(
//             opacity: 0.85,
//             child: Image(
//               image: photoProvider,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// @immutable
// class Item {
//   const Item({
//     required this.totalPriceCents,
//     required this.name,
//     required this.uid,
//     required this.imageProvider,
//   });
//   final int totalPriceCents;
//   final String name;
//   final String uid;
//   final ImageProvider imageProvider;
//   String get formattedTotalItemPrice =>
//       '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
// }

// class Customer {
//   Customer({
//     required this.name,
//     required this.imageProvider,
//     List<Item>? items,
//   }) : items = items ?? [];

//   final String name;
//   final ImageProvider imageProvider;
//   final List<Item> items;

//   String get formattedTotalItemPrice {
//     final totalPriceCents =
//         items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
//     return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Animal {
  const Animal({
    required this.name,
    required this.imageURL,
  });

  final String name;
  final String imageURL;
}

final List<Animal> dummyAnimals = [
  Animal(
    name: 'Cat',
    imageURL:
        'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
  ),
  Animal(
    name: 'Dog',
    imageURL:
        'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg',
  ),
  Animal(
    name: 'Rabbit',
    imageURL:
        'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg',
  ),
];

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DraggableWidget(animal: dummyAnimals[0]),
            DraggableWidget(animal: dummyAnimals[1]),
            DraggableWidget(animal: dummyAnimals[2]),
            DragTarget<Animal>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                );
              },
              onAccept: (item) {
                print(item.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({super.key, required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Draggable<Animal>(
      data: animal,
      child: buildImage(),
      feedback: buildImage(),
    );
  }

  Widget buildImage() {
    return Container(
      height: 200,
      child: Image.network(animal.imageURL),
    );
  }
}
