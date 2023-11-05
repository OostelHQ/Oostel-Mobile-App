import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:my_hostel/misc/widgets.dart';

enum DisplayType { asset, file, memory, network }

class ViewInfo {
  final List<String> paths;
  final List<Uint8List> bytes;
  final int current;
  final DisplayType type;

  const ViewInfo({
    this.paths = const [],
    this.bytes = const [],
    this.current = 0,
    this.type = DisplayType.asset,
});
}


class ViewMedia extends StatefulWidget {
  final ViewInfo info;

  const ViewMedia({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<ViewMedia> createState() => _ViewMediaState();
}

class _ViewMediaState extends State<ViewMedia> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.info.current);
  }

  ImageProvider provider(int index) {
    switch(widget.info.type) {
      case DisplayType.asset: return AssetImage(widget.info.paths[index]);
      case DisplayType.network: return NetworkImage(widget.info.paths[index]);
      case DisplayType.file: return FileImage(File(widget.info.paths[index]));
      case DisplayType.memory: return MemoryImage(widget.info.bytes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: 414.w,
              height: 896.h,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (context, index) => PhotoViewGalleryPageOptions(
                  imageProvider: provider(index),
                  initialScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 3.0,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: widget.info.type == DisplayType.memory
                          ? widget.info.bytes[index].hashCode
                          : widget.info.paths[index].hashCode),
                ),
                itemCount: widget.info.type == DisplayType.memory
                    ? widget.info.bytes.length
                    : widget.info.paths.length,
                loadingBuilder: (context, event) => const Center(child: loader),
                pageController: pageController,
                backgroundDecoration: const BoxDecoration(color: Color(0xFFFBFDFF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}