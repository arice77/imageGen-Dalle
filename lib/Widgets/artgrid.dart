import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ArtGrid extends StatelessWidget {
  String artSrc;
  String artName;
  ArtGrid({required this.artName, required this.artSrc, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: 150,
        child: Column(
          children: [
            Expanded(
                child: Image.network(
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              artSrc,
              fit: BoxFit.cover,
            )),
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFE7768A),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              width: double.infinity,
              child: Text(
                artName,
                style: const TextStyle(color: Colors.white, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
