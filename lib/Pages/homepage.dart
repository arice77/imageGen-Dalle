import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/Model/model.dart';
import 'package:image/Pages/download_page.dart';
import 'package:image/Pages/imagespage.dart';
import 'package:image/Widgets/artgrid.dart';

class ArtInfo {
  String artinfo;
  ArtInfo({required this.artinfo});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSelected = false;
  String _selectedArtName = '';
  String _selectedArtSrc = '';
  String _selectedArtStyle = '';

  final List<ArtStyle> _listArt = [
    ArtStyle(
        artName: 'Realism',
        artSrc:
            'https://images.unsplash.com/photo-1426604966848-d7adac402bff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
    ArtStyle(
        artName: 'Pixelated',
        artSrc:
            'https://images.pexels.com/photos/1670977/pexels-photo-1670977.jpeg?auto=compress&cs=tinysrgb&w=600'),
    ArtStyle(
        artName: '3D ',
        artSrc:
            'https://cdn.pixabay.com/photo/2014/02/03/16/52/bowl-257493__340.png'),
    ArtStyle(
        artName: 'Oil Painting',
        artSrc:
            'https://cdn.pixabay.com/photo/2014/10/23/19/52/oil-painting-500147__340.jpg'),
    ArtStyle(
        artName: 'Futuristic',
        artSrc:
            'https://cdn.pixabay.com/photo/2016/08/16/17/20/elevators-1598431__340.jpg'),
    ArtStyle(
        artName: 'Digital Art',
        artSrc:
            'https://cdn.pixabay.com/photo/2015/03/05/01/46/sailing-ship-659758__340.jpg'),
  ];

  final TextEditingController _imagdescController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 237, 234),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
          title: const Text('AI-Gen'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 246, 245),
                        border: Border.all(
                          color: const Color(0xFFE7768A),
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                        controller: _imagdescController,
                        onSubmitted: (value) {},
                        cursorColor: const Color(0xFFE7768A),
                        style: const TextStyle(decoration: TextDecoration.none),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Image Description')),
                  ),
                  if (!_isSelected)
                    SizedBox(
                      height: 250,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _listArt.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              _selectedArtName = _listArt[index].artName;
                              _selectedArtSrc = _listArt[index].artSrc;
                              _selectedArtStyle = _selectedArtName;
                              setState(() {
                                _isSelected = true;
                              });
                            }),
                            child: ArtGrid(
                                artName: _listArt[index].artName,
                                artSrc: _listArt[index].artSrc),
                          );
                        },
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: ArtGrid(
                          artName: _selectedArtName, artSrc: _selectedArtSrc),
                    ),
                  if (_isSelected)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.refresh,
                              color: Color.fromARGB(230, 238, 66, 98)),
                          label: const Text(
                            'Change',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(230, 238, 66, 98)),
                          ),
                          onPressed: () {
                            _selectedArtStyle = '';
                            setState(() {
                              _isSelected = false;
                            });
                          },
                        ),
                      ],
                    ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_imagdescController.text.trim().isEmpty) {
                          const snackBar = SnackBar(
                            content: Text('Enter Image Description'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (_selectedArtStyle.trim().isEmpty) {
                          const snackBar = SnackBar(
                            content: Text('Select an Art Form'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          _isSelected = false;
                          Navigator.pushNamed(context, ImagesPage.routeName,
                              arguments: ArtInfo(
                                  artinfo:
                                      '${_imagdescController.text} $_selectedArtStyle'));
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side:
                                          const BorderSide(color: Colors.red))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFE7768A))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  })
                ]),
          ),
        ),
      ),
    );
  }
}
