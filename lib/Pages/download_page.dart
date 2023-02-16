import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});
  static const routeName = 'download';

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<String> _imagesDes = [];
  List<String> _imagesNames = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setImages();
  }

  setImages() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    _imagesDes = prefs.getStringList('list') ?? [];
    setState(() {
      loading = false;
    });
    _imagesNames = prefs.getStringList('name') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 234),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE7768A),
        title: const Text('Downloads'),
      ),
      body: Column(
        children: [
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: _imagesDes.length,
                  itemBuilder: (context, index) {
                    if (!File(_imagesDes[index]).existsSync()) {
                      return const SizedBox();
                    }
                    return Container(
                      margin: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 200, 210),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 200, 210),
                              width: 3)),
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          await ImageDownloader.open(_imagesDes[index]);
                        },
                        title: Text(
                          _imagesNames[index],
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40,
                            child: Image.file(File(_imagesDes[index]))),
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
