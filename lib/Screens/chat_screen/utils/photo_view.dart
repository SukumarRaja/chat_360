
import 'package:chat360/Configs/Enum.dart';
import 'package:chat360/Configs/app_constants.dart';
import 'package:chat360/Utils/utils.dart';
import 'package:chat360/widgets/DownloadManager/save_image_videos_in_gallery.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWrapper extends StatelessWidget {
  PhotoViewWrapper(
      {this.imageProvider,
      this.message,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      required this.keyloader,
      required this.imageUrl,
      required this.tag});

  final String tag;
  final String? message;
  final GlobalKey keyloader;
  final ImageProvider? imageProvider;
  final Widget? loadingChild;
  final Decoration? backgroundDecoration;
  final dynamic minScale;
  final String imageUrl;
  final dynamic maxScale;

  final GlobalKey<ScaffoldState> _scaffoldd = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return chat360.getNTPWrappedWidget(Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldd,
        appBar: AppBar(
          elevation: DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: chat360White,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "dfs32231t834",
          backgroundColor: chat360LightGreen,
          onPressed: () async {
            GalleryDownloader.saveNetworkImage(
                context, imageUrl, false, "", keyloader);
          },
          child: Icon(
            Icons.file_download,
          ),
        ),
        body: Container(
            color: Colors.black,
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: PhotoView(
              loadingBuilder: (BuildContext context, var image) {
                return loadingChild ??
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(chat360Blue),
                        ),
                      ),
                    );
              },
              imageProvider: imageProvider,
              backgroundDecoration: backgroundDecoration as BoxDecoration?,
              minScale: minScale,
              maxScale: maxScale,
            ))));
  }
}
