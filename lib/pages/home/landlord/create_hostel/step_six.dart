import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:get_thumbnail_video/index.dart';
// import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';


class StepSix extends StatefulWidget {
  final Map<String, dynamic> info;

  const StepSix({
    super.key,
    required this.info,
  });

  @override
  State<StepSix> createState() => _StepSixState();
}

class _StepSixState extends State<StepSix> {
  late List<SingleFileResponse> media;
  bool noFirstValue = true;

  @override
  void initState() {
    super.initState();
    media = toDataList(widget.info["medias"]);
    widget.info["medias"] = media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: true,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: 6 / totalPages,
                      color: appBlue,
                      minHeight: 1.5.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: "Reset",
                          child: Text(
                            "Reset",
                            style: context.textTheme.bodyMedium,
                          ),
                        )
                      ],
                      onSelected: (result) => setState(() {
                        if (!noFirstValue) {
                          media.removeAt(0);
                        }

                        noFirstValue = true;
                      }),
                    ),
                  ),
                  SizedBox(height: 18.h),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP 6",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Hostel Picture",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Upload a clear front view image of your hostel building "
                          "to attract tenants with a welcoming facade",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                    GestureDetector(
                      onTap: () {
                        FileManager.single(type: FileType.image)
                            .then((response) async {
                          if (response == null) return;
                          setState(() {
                            if (noFirstValue) {
                              media.insert(0, response);
                            } else {
                              media[0] = response;
                            }

                            noFirstValue = false;
                          });
                        });
                      },
                      child: Container(
                        width: 350.w,
                        height: 270.h,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: noFirstValue ? paleBlue : null,
                          image: noFirstValue
                              ? null
                              : DecorationImage(
                            image: FileImage(File(media.first.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: noFirstValue
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/Hostel Image.svg",
                              width: 40.r,
                              height: 40.r,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Upload a front-view picture of your hostel",
                              textAlign: TextAlign.center,
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Maximum size allowed is 2MB of png and jpg format",
                              textAlign: TextAlign.center,
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: appBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_rounded,
                        color: appBlue, size: 26.r),
                    SizedBox(width: 5.w),
                    Text(
                      "Go back",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (noFirstValue) {
                  showError(
                      "Please choose an image for your hostel front view");
                  return;
                }
                context.router.pushNamed(Pages.stepSixHalf, extra: widget.info);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 26.r)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepSixHalf extends StatefulWidget {
  final Map<String, dynamic> info;

  const StepSixHalf({
    super.key,
    required this.info,
  });

  @override
  State<StepSixHalf> createState() => _StepSixHalfState();
}

class _StepSixHalfState extends State<StepSixHalf> {
  late List<SingleFileResponse> media;
  late Uint8List? videoData;
  late int? videoDataIndex;

  @override
  void initState() {
    super.initState();
    media = toDataList(widget.info["medias"]);
    media = media.sublist(1);
  }

  void selectMedia() {
    if (media.length == 4) {
      showError("You cannot select more than 4 media");
      return;
    }

    FileManager.multiple(
        type: FileType.custom, extensions: ["mp4", "jpg", "png", "jpeg"]).then(
          (response) async {
        String videoPath = "";
        for (int i = 0; i < response.length; ++i) {
          if (response[i].extension == "mp4") {
            videoPath = response[i].path;
          }

          if (media.length < 4) {
            media.add(response[i]);
          }
        }

        if (videoPath.isNotEmpty) {
          // videoData = await VideoThumbnail.thumbnailData(
          //   video: videoPath,
          //   imageFormat: ImageFormat.JPEG,
          //   maxWidth: 350,
          //   maxHeight: 270,
          //   quality: 75,
          // );
          //
          // for (int i = 0; i < media.length; ++i) {
          //   if (media[i].path == videoPath) {
          //     videoDataIndex = i;
          //   }
          // }
        }

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: true,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: 7 / totalPages,
                      color: appBlue,
                      minHeight: 1.5.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: "Reset",
                          child: Text(
                            "Reset",
                            style: context.textTheme.bodyMedium,
                          ),
                        )
                      ],
                      onSelected: (result) => setState(() {
                        SingleFileResponse first = media.removeAt(0);
                        media.clear();
                        media.add(first);
                      }),
                    ),
                  ),
                  SizedBox(height: 18.h),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP 7",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Environment Picture",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Capture the essence of your hostel environment in pictures. "
                          "Showcase the surroundings to attract potential tenants.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList.separated(
                itemBuilder: (_, index) {
                  if (index == media.length) {
                    return Column(
                      children: [
                        if (media.isEmpty)
                          GestureDetector(
                            onTap: selectMedia,
                            child: Container(
                              width: 350.w,
                              height: 270.h,
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: media.isEmpty ? paleBlue : null,
                                image: media.isEmpty
                                    ? null
                                    : DecorationImage(
                                  image:
                                  FileImage(File(media.first.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: media.isEmpty
                                  ? Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/Hostel Image.svg",
                                    width: 40.r,
                                    height: 40.r,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "Upload a video (optional) or images of your hostel",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                      color: weirdBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Maximum size allowed is 2MB for images and 50MB for video",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                                  : null,
                            ),
                          ),
                        SizedBox(height: media.isEmpty ? 32.h : 20.h),
                        if (media.isNotEmpty)
                          GestureDetector(
                            onTap: selectMedia,
                            child: Container(
                              width: 160.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: paleBlue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline,
                                      color: appBlue, size: 16),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Add media",
                                    textAlign: TextAlign.center,
                                    style:
                                    context.textTheme.bodyMedium!.copyWith(
                                      color: appBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 32.h),
                      ],
                    );
                  }

                  return _SpecialContainer(
                    onDelete: () => setState(() {
                      media.removeAt(index);
                      if (videoDataIndex != null && index == videoDataIndex) {
                        videoDataIndex = null;
                        videoData = null;
                      }
                    }),
                    file: media[index],
                  );
                },
                itemCount: media.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 20.h),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: appBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_rounded,
                        color: appBlue, size: 26.r),
                    SizedBox(width: 5.w),
                    Text(
                      "Go back",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                int total = media.length;
                int videos = 0;
                for (var resp in media) {
                  if (resp.extension == "mp4") {
                    ++videos;
                  }
                }

                if (total > 4) {
                  showError("You need can only upload a maximum of 4 media");
                  return;
                }

                if (videos > 1) {
                  showError("You can only select 1 video");
                  return;
                }

                SingleFileResponse first = widget.info["medias"].first;
                widget.info["medias"].clear();
                widget.info["medias"].add(first);
                widget.info["medias"].addAll(media);
                context.router.pushNamed(Pages.stepSeven, extra: widget.info);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 26.r)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialContainer extends StatelessWidget {
  final SingleFileResponse file;
  final Uint8List? data;
  final VoidCallback onDelete;

  const _SpecialContainer({
    this.data,
    required this.file,
    required this.onDelete,
  });

  ImageProvider<Object> get provider {
    if (data != null) {
      return MemoryImage(data!);
    }

    return FileImage(File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 390.w,
            height: 270.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black45,
            ),
            child: data != null
                ? Center(
              child: Icon(
                Icons.play_arrow_rounded,
                size: 48.r,
                color: Colors.white,
              ),
            )
                : null,
          ),
          Positioned(
            top: 5.h,
            right: 0,
            child: IconButton(
              icon: const Icon(Boxicons.bx_x, color: Colors.white),
              iconSize: 28.r,
              onPressed: onDelete,
            ),
          )
        ],
      ),
    );
  }
}



