import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/main_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCard extends StatelessWidget {

  final double width;
  final double height;
  final String name;
  final double distance;
  final int rating;
  final String imageUrl;
  final String imagePl;

  final List<String> tags;
  
  EventCard({
    this.width,
    this.height,
    this.name,
    this.rating,
    this.distance,
    this.imageUrl,
    this.imagePl = 'assets/event.jpg',
    this.tags = const []
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //elevation: 0,
      decoration: BoxDecoration(
        //shape: RoundedRectangleBorder(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        //),
      ),
      margin: const EdgeInsets.only(left: 15),
      child: Container(
        width: width,
        child: Stack(
          children: [
            imageUrl != null ? 
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.cover,
                width: width,
                height: height,
                image: NetworkImage(imageUrl)
              ) 
            ) : ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Image(
                fit: BoxFit.cover,
                width: width,
                height: height - 80,
                image: AssetImage(imagePl)
              ) 
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.7)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.75),
                    ), 
                  ),
                  Row(
                    children: [
                      distance != null ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('${(distance / 1000).toStringAsFixed(2)} km',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                          ), 
                        ),
                      ) : Container(),
                    ],
                  ),
                  MainTag(
                    text: tags.isNotEmpty ? tags.first : 'Unknown',
                    color: AppColors.orange.withOpacity(0.75),
                  )
                ]
              )
            ),
          ],
        ),
      ),
    );
  }

}