import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walldex_app/widgets/roundbutton_widget.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class OpenScreen extends StatefulWidget {
  final String url;
  final String downloadUrl;

  const OpenScreen({Key? key, required this.url, required this.downloadUrl})
      : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  String home = "HomeScreen";
  var albumName = 'WalldeX';

  void saveImage(String path, String text,int time) async {
    Future result = GallerySaver.saveImage(path, albumName: albumName);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          content: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          duration: Duration(seconds: time),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Image.network(
              widget.url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: InkWell(
              child: RoundButton(
                icoon: Icons.arrow_back_ios_new,
                bgcolor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                iconcolor: Theme.of(context).scaffoldBackgroundColor,
              ),
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_arrow,
              overlayOpacity: 0.1,
              direction: SpeedDialDirection.left,
              backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              foregroundColor: Theme.of(context).primaryColor.withOpacity(1),
              childrenButtonSize: const Size(60, 60),
              elevation: 0,
              buttonSize: const Size(60, 60),
              children: [
                SpeedDialChild(
                  child: InkWell(
                    child: Text('4K',style: GoogleFonts.audiowide(),),
                    onTap: () {
                      saveImage(widget.downloadUrl,'Downloading Large file...\n Keep browsing,See you at gallery..',5);
                    },
                  ),
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.5),
                ),
                SpeedDialChild(
                  child: InkWell(
                    child: Text('HD',style: GoogleFonts.audiowide(),),
                    onTap: () {
                      saveImage(widget.url,'Wallpaper saved',3);
                    },
                  ),
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.5),
                ),
                SpeedDialChild(
                  child: InkWell(
                    child: Icon(
                      Icons.wallpaper,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () async{
                      String url = widget.url;  // Image url
                      var cachedimage = await DefaultCacheManager().getSingleFile(url);  //image file
                      int location = WallpaperManagerFlutter.BOTH_SCREENS;  //Choose screen type
                      var result = WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
                      if(result!=null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                            content: Text(
                              'Wallpaper updated',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                  ),
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}