import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/main_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueCard extends StatelessWidget {

  final double width;
  final double height;
  final String name;
  final String address;
  final double distance;
  final int rating;
  final String imageUrl;
  final String imagePl;
  final List<String> tags;
  
  VenueCard({
    this.width,
    this.height,
    this.name,
    this.address,
    this.rating,
    this.distance,
    this.imageUrl,
    this.imagePl = 'assets/rest.jpg',
    this.tags = const []
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 15),
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != null ? ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Image(
                fit: BoxFit.cover,
                width: width,
                height: height - 80,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13
                    ), 
                  ),
                  address != null ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(address,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 12
                      ), 
                    ),
                  ) : Container(),
                  Row(
                    children: [
                      distance != null ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('${(distance / 1000).toStringAsFixed(2)} km',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                          ), 
                        ),
                      ) : Container(),
                      // distance != null ? Padding(
                      //   padding: const EdgeInsets.only(top: 5, left: 5),
                      //   child: Text('${(distance / 1000).toStringAsFixed(2)} km',
                      //     maxLines: 1,
                      //     style: TextStyle(
                      //       color: Colors.black.withOpacity(0.5),
                      //       fontWeight: FontWeight.w300,
                      //       fontSize: 12
                      //     ), 
                      //   ),
                      // ) : Container(),
                    ],
                  ),
                  MainTag(
                    text: tags.first,
                    color: AppColors.purple,
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