import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key? key,
    required this.height,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  final double height;
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.43,
      child: Center(
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                color: const Color(0xFFE7768A),
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: const BoxDecoration(
                    color: Color(0xFFE7768A),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                width: double.infinity,
                child: Text(
                  name.substring(0, 1).toUpperCase() + name.substring(1),
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
