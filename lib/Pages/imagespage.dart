import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/Api%20Services/api_services.dart';
import 'package:image/Pages/download_page.dart';
import 'package:image/Pages/homepage.dart';
import 'package:image/Widgets/imagedisplay.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagesPage extends StatefulWidget {
  static const String routeName = '/images-page';

  const ImagesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  List<String> _imagesDes = [];
  List<String> _imagesName = [];
  final ApiServices _apiServices = ApiServices();
  String _imageUrl = '';
  String _name = '';
  String _pathh = '';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _loadImage();
    });
    _setListOfimages();
  }

  _setListOfimages() async {
    _prefs = await SharedPreferences.getInstance();
    _imagesDes = _prefs.getStringList('list') ?? [];
    _imagesName = _prefs.getStringList('name') ?? [];
  }

  _loadImage() async {
    final args = ModalRoute.of(context)!.settings.arguments as ArtInfo;
    _name = args.artinfo;
    List url = await _apiServices.imageCall('$_name style');
    _imageUrl = await url[0]['url'];
    if (mounted) {
      setState(() {
        _imageUrl = _imageUrl;
      });
    }
  }

  _downloadImage() async {
    String? destination = await ImageDownloader.downloadImage(
      _imageUrl,
    );
    if (destination != null) {
      String? path = await ImageDownloader.findPath(destination);
      _pathh = path.toString();
    }
    _imagesDes.add(_pathh);
    _imagesName.add(
      _name.substring(0, 1).toUpperCase() + _name.substring(1),
    );
    await _prefs.setStringList('list', _imagesDes);
    await _prefs.setStringList('name', _imagesName);
    await ImageDownloader.open(_pathh);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 234),
      appBar: AppBar(
        title: const Text('AI-Gen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DownloadPage.routeName);
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ))
        ],
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: const Color(0xFFE7768A),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_imageUrl.trim().isEmpty)
                const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFE7768A),
                ))
              else
                ImageDisplay(height: height, imageUrl: _imageUrl, name: _name),
              const SizedBox(
                height: 20,
              ),
              if (_imageUrl.trim().isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                          backgroundColor: const Color(0xFFE7768A),
                        ),
                        onPressed: () {
                          _downloadImage();
                        },
                        label: const Text('Download'),
                        icon: const Icon(Icons.download_rounded),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                          backgroundColor: const Color(0xFFE7768A),
                        ),
                        onPressed: () {
                          setState(() {
                            _imageUrl = '';
                          });
                          _loadImage();
                        },
                        label: const Text('Try Again'),
                        icon: const Icon(Icons.refresh_sharp),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
