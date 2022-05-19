import 'package:flutter/material.dart';

//封装图片加载控件，增加图片加载失败时加载默认图片
class ImageLoad extends StatefulWidget {
  final String url;
  final double w;
  final double h;
  final String defImagePath;

  const ImageLoad({required this.url, required this.w, required this.h, this.defImagePath = "assets/image/btc.png"});

  @override
  ImageLoadState createState() => ImageLoadState();
}

class ImageLoadState extends State<ImageLoad> {
  late Image _image;

  @override
  void initState() {
    super.initState();

    _image = Image.network(
      widget.url,
      width: widget.w,
      height: widget.h,
    );

    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      print("image success.");
    }, onError: (Object exception, StackTrace? stackTrace) {
      print("image failed");
        setState(() {
          _image = Image.asset(
            widget.defImagePath,
            width: widget.w,
            height: widget.h,
          );
        });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}