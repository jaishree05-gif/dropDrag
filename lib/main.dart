import 'package:draganddrop/dragDropUi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
      home: ExampleDragAndDrop(),
  debugShowCheckedModeBanner: false,
  ),);

}

const List<Items> _item = [
  Items(
    qus: 'Drag the tag to identify each component',
    totalPriceCents: "Chassis",
    uid: '1',
    imageProvider: AssetImage(
      'assets/car_structure.png',
    ),
    partsName: [
      {"id":"1",
      "name":"Body"},
      {"id":"1",
        "name":"Chassis"},
      {"id":"1",
        "name":"Motor"},


    ]
  ),
  Items(
      qus: 'Drag the tag to identify each component',
      totalPriceCents: "Chassis",
      uid: '2',
      imageProvider: AssetImage(
        'assets/engine.png',
      ),
      partsName: [
        {"id":"1",
          "name":"Piston"},
        {"id":"2",
          "name":"Cylinder"},
        {"id":"3",
          "name":"Crankshaft"},
        {"id":"4",
          "name":"Rotor"},
        {"id":"5",
          "name":"Sator"},
        {"id":"6",
          "name":"Motorshaft"},


      ]
  ),
  Items(
      qus: 'Drag the tag to identify each Image',
      totalPriceCents: "Chassis",
      uid: '3',
      imageProvider: AssetImage(
        'assets/transimission.png',
      ),
      partsName: [
        {"id":"1",
          "name":"EPA"},
        {"id":"2",
          "name":"EV Charging Station"},
        {"id":"3",
          "name":"EV Battery"},
        {"id":"4",
          "name":"E-85 Fuel"},
        {"id":"5",
          "name":"Transmission"},


      ]
  ),

];

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {

  final List<MachineParts> _machineParts = [
    MachineParts(
      name: 'Makayla',

      // totalPriceCents: "Chassis",

    ),

  ];

  final GlobalKey _draggableKey = GlobalKey();



void _itemDroppedOnMachineCart({
required Items item,
required MachineParts machineParts,

}) {
setState(() {
machineParts.items.add(item as Items);
});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  //appbar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Complete the labelling activity on all three slides',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }
  Color caughtColor = Colors.red;
  Widget _buildContent() {
    return SafeArea(
      child: _buildFbList(),
    );
  }




  Widget _buildFbList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: _item.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final item = _item[index];

        return _buildMenuItems(item: item);
      },
    );
  }

  //Dragable widget//
  Widget _buildMenuItems({required Items item}) {
    return LongPressDraggable<Items>(

      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback:DraggingListItem(
        dragKey: _draggableKey,
        words: item.uid,
        partsName: item.partsName,
      ),
      child: MenuListItem(
        name: item.qus,
        price: item.totalPriceCents,
        photoProvider: item.imageProvider,
        id: item.uid,
        partsName: item.partsName,

      ),
      onDragStarted: () {
        print('Drag started');
      },
      onDragCompleted: () {
        print('Drag completed');
      },
      onDraggableCanceled: (velocity, offset) {
        print('Drag canceled');
      },

    );
  }



  // Widget _buildBodyParts() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
  //     child: Row(children: _machineParts.map(_buildPartWithDropZone).toList()),
  //   );
  // }

// Widget _buildPartWithDropZone(MachineParts parts) {
//   return Expanded(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: DragTarget<Items>(
//         builder: (context, candidateItems, rejectedItems) {
//           return MachineCart(
//             hasItems: parts.items.isNotEmpty,
//             highlighted: candidateItems.isNotEmpty,
//             parts: parts,
//             // customer: parts,
//           );
//         },
//         onAcceptWithDetails: (details) {
//           _itemDroppedOnMachineCart(item: details.data, machineParts: parts);
//         },
//       ),
//     ),
//   );
// }
}


// class MachineCart extends StatelessWidget {
//   const MachineCart({
//     super.key,
//     required this.parts,
//     this.highlighted = false,
//     this.hasItems = false,
//   });
//
//   final MachineParts parts;
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
//               ListView.builder(
//                 itemCount: parts.items.length,
//                 scrollDirection: Axis.vertical,
//                 physics: AlwaysScrollableScrollPhysics(),
//                 shrinkWrap: true,
//
//                 itemBuilder: (context, index) {
//                   final item = parts.items[index];
//                   return  Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5 ),
//                     decoration: const BoxDecoration(
//                       color: Colors.grey,
//
//                     ),
//                     child: Text(
//                       item,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//
//                         fontSize: 12,
//                       ),
//                     ),
//                   );
//                 },),
//               // Text(
//               //   parts.totalPriceCents,
//               //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//               //     color: textColor,
//               //     fontWeight: hasItems ? FontWeight.normal : FontWeight.bold,
//               //   ),
//               // ),
//               Visibility(
//                 visible: hasItems,
//                 maintainState: true,
//                 maintainAnimation: true,
//                 maintainSize: true,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 4),
//                     Text(
//                       parts.items as String,
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: textColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${parts.items.length} item${parts.items.length != 1 ? 's' : ''}',
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


class MenuListItem extends StatelessWidget {
   MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    this.id = '',
    partsName ,
    required this.photoProvider,
    this.isDepressed = false,
  }): partsName = partsName ?? [];

  final String name;
  final String price;
  final String  id;
  final ImageProvider photoProvider;
  final bool isDepressed;
   List? partsName;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(2),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "$id. $name",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 14,fontWeight: FontWeight.bold,),
                    ),
                  ),
                  const SizedBox(height: 10),

                 if(partsName!.length != null) ListView.builder(
                   itemCount: partsName!.length,
                   scrollDirection: Axis.vertical,
                   physics: AlwaysScrollableScrollPhysics(),
                   shrinkWrap: true,

                   itemBuilder: (context, index) {
                   // final item = partsName![index];
                   return  Container(
                     padding: EdgeInsets.all(10),
                     margin: EdgeInsets.symmetric(vertical: 5 ),
                     decoration: const BoxDecoration(
                       color: Colors.grey,

                     ),
                     child: Text(
                       partsName![index]['name'],
                       style: Theme.of(context).textTheme.titleMedium?.copyWith(

                         fontSize: 12,
                       ),
                     ),
                   );
                 },),

                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                          height: isDepressed ? 115 : 120,
                          width: isDepressed ? 115 : 120,
                          child: Image(image: photoProvider, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5 ),
                      decoration: const BoxDecoration(
                        color: Colors.grey,

                      ),
                      child: Text(
                        "Enter",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(

                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
   DraggingListItem({
    super.key,
    required this.dragKey,
    required this.words,
    partsName

  }): partsName = partsName ?? [];

  final GlobalKey dragKey;
  final String words;
  final List? partsName;


  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
          Text(
                        words,
            // partsName![index]['name'],
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 14,fontWeight: FontWeight.bold,),
                      ),
    //         ListView.builder(
    // itemCount: partsName!.length,
    // scrollDirection: Axis.vertical,
    // physics: AlwaysScrollableScrollPhysics(),
    // shrinkWrap: true,
    //
    // itemBuilder: (context, index) {
    //             return Text(
    //               partsName![index]['name'],
    //               style: Theme.of(
    //                 context,
    //               ).textTheme.titleMedium?.copyWith(fontSize: 14,fontWeight: FontWeight.bold,),
    //             );
    //           }
    //         ),


          ],
        ),
      ),
    );
  }
}

@immutable


class Items {
  const Items({
    required this.totalPriceCents,
    required this.qus,
    required this.uid,
    required this.partsName,
    required this.imageProvider,
  });
  final String totalPriceCents;
  final String qus;
  final String uid;

  final List? partsName;
  final ImageProvider imageProvider;

}
class MachineParts {
  MachineParts({required this.name,
    // required this.totalPriceCents,
    List<Items>? item})
      : items = item ?? [];

  final String name;
  // final String totalPriceCents;

  final List<Items> items;
  // final List partsName;


}



