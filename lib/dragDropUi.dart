// import 'package:flutter/material.dart';
//
// class DragPage extends StatefulWidget {
//
//   const DragPage({Key? key}) : super(key: key);
//
//   @override
//   State<DragPage> createState() => _DragPageState();
// }
//
// class _DragPageState extends State<DragPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
// void main() {
//   runApp(
//     const MaterialApp(
//       home: ExampleDragAndDrop(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }
//
// const List<Item> _items = [
//   Item(
//     name: 'Spinach Pizza',
//     totalPriceCents: 1299,
//     uid: '1',
//     imageProvider: NetworkImage(
//       'https://docs.flutter.dev'
//           '/cookbook/img-files/effects/split-check/Food1.jpg',
//     ),
//   ),
//   Item(
//     name: 'Veggie Delight',
//     totalPriceCents: 799,
//     uid: '2',
//     imageProvider: NetworkImage(
//       'https://docs.flutter.dev'
//           '/cookbook/img-files/effects/split-check/Food2.jpg',
//     ),
//   ),
//   Item(
//     name: 'Chicken Parmesan',
//     totalPriceCents: 1499,
//     uid: '3',
//     imageProvider: NetworkImage(
//       'https://docs.flutter.dev'
//           '/cookbook/img-files/effects/split-check/Food3.jpg',
//     ),
//   ),
// ];
//
// @immutable
// class ExampleDragAndDrop extends StatefulWidget {
//   const ExampleDragAndDrop({super.key});
//
//   @override
//   State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
// }
//
// class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
//     with TickerProviderStateMixin {
//   final List<Customer> _people = [
//     Customer(
//       name: 'Makayla',
//       imageProvider: const NetworkImage(
//         'https://docs.flutter.dev'
//             '/cookbook/img-files/effects/split-check/Avatar1.jpg',
//       ),
//     ),
//     Customer(
//       name: 'Nathan',
//       imageProvider: const NetworkImage(
//         'https://docs.flutter.dev'
//             '/cookbook/img-files/effects/split-check/Avatar2.jpg',
//       ),
//     ),
//     Customer(
//       name: 'Emilio',
//       imageProvider: const NetworkImage(
//         'https://docs.flutter.dev'
//             '/cookbook/img-files/effects/split-check/Avatar3.jpg',
//       ),
//     ),
//   ];
//
//   final GlobalKey _draggableKey = GlobalKey();
//
//   void _itemDroppedOnCustomerCart({
//     required Item item,
//     required Customer customer,
//   }) {
//     setState(() {
//       customer.items.add(item);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       appBar: _buildAppBar(),
//       body: _buildContent(),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Color(0xFFF64209)),
//       title: Text(
//         'Order Food',
//         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//           fontSize: 36,
//           color: const Color(0xFFF64209),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: const Color(0xFFF7F7F7),
//       elevation: 0,
//     );
//   }
//
//   Widget _buildContent() {
//     return Stack(
//       children: [
//         SafeArea(
//           child: Column(
//             children: [
//               Expanded(child: _buildMenuList()),
//               _buildPeopleRow(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMenuList() {
//     return ListView.separated(
//       padding: const EdgeInsets.all(16),
//       itemCount: _items.length,
//       separatorBuilder: (context, index) {
//         return const SizedBox(height: 12);
//       },
//       itemBuilder: (context, index) {
//         final item = _items[index];
//         return _buildMenuItem(item: item);
//       },
//     );
//   }
//
//   Widget _buildMenuItem({required Item item}) {
//     return LongPressDraggable<Item>(
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
//
//   Widget _buildPeopleRow() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
//       child: Row(children: _people.map(_buildPersonWithDropZone).toList()),
//     );
//   }
//
//   Widget _buildPersonWithDropZone(Customer customer) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6),
//         child: DragTarget<Item>(
//           builder: (context, candidateItems, rejectedItems) {
//             return CustomerCart(
//               hasItems: customer.items.isNotEmpty,
//               highlighted: candidateItems.isNotEmpty,
//               customer: customer,
//             );
//           },
//           onAcceptWithDetails: (details) {
//             _itemDroppedOnCustomerCart(item: details.data, customer: customer);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class CustomerCart extends StatelessWidget {
//   const CustomerCart({
//     super.key,
//     required this.customer,
//     this.highlighted = false,
//     this.hasItems = false,
//   });
//
//   final Customer customer;
//   final bool highlighted;
//   final bool hasItems;
//
//   @override
//   Widget build(BuildContext context) {
//     final textColor = highlighted ? Colors.white : Colors.black;
//
//     return Transform.scale(
//       scale: highlighted ? 1.075 : 1.0,
//       child: Material(
//         elevation: highlighted ? 8 : 4,
//         borderRadius: BorderRadius.circular(22),
//         color: highlighted ? const Color(0xFFF64209) : Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
//                   color: textColor,
//                   fontWeight: hasItems ? FontWeight.normal : FontWeight.bold,
//                 ),
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
//                         color: textColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                         color: textColor,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MenuListItem extends StatelessWidget {
//   const MenuListItem({
//     super.key,
//     this.name = '',
//     this.price = '',
//     required this.photoProvider,
//     this.isDepressed = false,
//   });
//
//   final String name;
//   final String price;
//   final ImageProvider photoProvider;
//   final bool isDepressed;
//
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
//                     child: Image(image: photoProvider, fit: BoxFit.cover),
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
//                     style: Theme.of(
//                       context,
//                     ).textTheme.titleMedium?.copyWith(fontSize: 18),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     price,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
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
//
// class DraggingListItem extends StatelessWidget {
//   const DraggingListItem({
//     super.key,
//     required this.dragKey,
//     required this.photoProvider,
//   });
//
//   final GlobalKey dragKey;
//   final ImageProvider photoProvider;
//
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
//             child: Image(image: photoProvider, fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
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
//
// class Customer {
//   Customer({required this.name, required this.imageProvider, List<Item>? items})
//       : items = items ?? [];
//
//   final String name;
//   final ImageProvider imageProvider;
//   final List<Item> items;
//
//   String get formattedTotalItemPrice {
//     final totalPriceCents = items.fold<int>(
//       0,
//           (prev, item) => prev + item.totalPriceCents,
//     );
//     return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
//   }
// }
import 'package:flutter/material.dart';
class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}
class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<Container> containers = [];
  List<Container> draggableItems = [];

  @override
  void initState() {
    super.initState();
    draggableItems = [
      _buildDraggableContainer(Colors.red),
      _buildDraggableContainer(Colors.blue),
      _buildDraggableContainer(Colors.green),
      _buildDraggableContainer(Colors.yellow),
      _buildDraggableContainer(Colors.orange),
    ];
  }

  Container _buildDraggableContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: const Center(
        child: Text('Drag Me', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop Example'),
      ),
      body: Row(
        children: [
          Expanded(
            child: DragTarget<Container>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: Colors.grey,
                  constraints: const BoxConstraints(minHeight: 50),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: containers
                          .map((item) => Draggable<Container>(
                        data: item,
                        feedback: item,
                        childWhenDragging: Container(),
                        child: item,
                      ))
                          .toList(),
                    ),
                  ),
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
                setState(() {
                  containers.add(data);
                });
              },
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: draggableItems
                .map((item) => DragTarget<Container>(
              builder: (context, candidateData, rejectedData) {
                return Draggable<Container>(
                  data: item,
                  feedback: item,
                  childWhenDragging: Container(),
                  child: item,
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
                setState(() {
                  containers.remove(data);
                });
              },
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}