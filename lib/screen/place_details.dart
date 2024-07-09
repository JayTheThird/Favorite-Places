import 'package:favorite_places/model/place_model.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
// Center(
//         child: Text(
//           place.id,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
//                 color: Colors.black,
//               ),
//         ),
//       ),

    return Scaffold(
      appBar: AppBar(
        title: Text(place.place),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
