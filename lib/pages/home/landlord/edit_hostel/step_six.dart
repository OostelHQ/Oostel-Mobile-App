import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';


class EditStepSix extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSix({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSix> createState() => _EditStepSixState();
}

class _EditStepSixState extends State<EditStepSix> {
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
                            "Save and Exit",
                            style: context.textTheme.bodyMedium,
                          ),
                        )
                      ],
                      onSelected: (result) =>
                          saveAndExit(info: widget.info, context: context),
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
                          widget.info.media.removeAt(0);
                          widget.info.media.insert(0, response);
                          setState(() {});
                        });
                      },
                      child: widget.info.isLocal(0)
                          ? CachedNetworkImage(
                        imageUrl: widget.info.media.first,
                        errorWidget: (context, url, error) => Container(
                          width: 350.w,
                          height: 270.h,
                          color: weirdBlack50,
                        ),
                        progressIndicatorBuilder:
                            (context, url, download) => Container(
                          width: 350.w,
                          height: 270.h,
                          color: weirdBlack50,
                          alignment: Alignment.center,
                          child: loader,
                        ),
                        imageBuilder: (context, provider) => Container(
                          width: 350.w,
                          height: 270.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: provider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(
                        width: 350.w,
                        height: 270.h,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: FileImage(
                              File(widget.info.media.first.path),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
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
              onTap: () => context.router
                  .pushNamed(Pages.editStepSixHalf, extra: widget.info),
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

class EditStepSixHalf extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSixHalf({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSixHalf> createState() => _EditStepSixHalfState();
}

class _EditStepSixHalfState extends State<EditStepSixHalf> {
  late Uint8List? videoData;
  late int? videoDataIndex;

  void selectMedia() {
    if (widget.info.media.length == 5) {
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

          if (widget.info.media.length < 5) {
            widget.info.media.add(response[i]);
          }
        }

        if (videoPath.isNotEmpty) {
          videoData = await VideoThumbnail.thumbnailData(
            video: videoPath,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 350,
            maxHeight: 270,
            quality: 75,
          );

          for (int i = 0; i < widget.info.media.length; ++i) {
            if (isLocal(i) && widget.info.media[i].path == videoPath) {
              videoDataIndex = i;
            }
          }
        }

        setState(() {});
      },
    );
  }

  bool isLocal(int index) => widget.info.media[index] !is String;

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
                            "Save and Exit",
                            style: context.textTheme.bodyMedium,
                          ),
                        )
                      ],
                      onSelected: (result) =>
                          saveAndExit(info: widget.info, context: context),
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
                  if (index == widget.info.media.length - 1) {
                    return Column(
                      children: [
                        if (widget.info.media.length == 1)
                          GestureDetector(
                            onTap: selectMedia,
                            child: isLocal(index + 1)
                                ? CachedNetworkImage(
                              imageUrl: widget.info.media.first,
                              errorWidget: (context, url, error) =>
                                  Container(
                                    width: 350.w,
                                    height: 270.h,
                                    color: weirdBlack50,
                                    alignment: Alignment.center,
                                    child: loader,
                                  ),
                              progressIndicatorBuilder:
                                  (context, url, download) => Container(
                                width: 350.w,
                                height: 270.h,
                                color: weirdBlack50,
                              ),
                              imageBuilder: (context, provider) =>
                                  Container(
                                    width: 350.w,
                                    height: 270.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: provider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            )
                                : Container(
                              width: 350.w,
                              height: 270.h,
                              padding:
                              EdgeInsets.symmetric(horizontal: 25.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: widget.info.media.length == 1
                                    ? paleBlue
                                    : null,
                                image: widget.info.media.length == 1
                                    ? null
                                    : DecorationImage(
                                  image: FileImage(File(widget
                                      .info.media.first.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: widget.info.media.length == 1
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
                                    style: context
                                        .textTheme.bodyMedium!
                                        .copyWith(
                                      color: weirdBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Maximum size allowed is 2MB for images and 50MB for video",
                                    textAlign: TextAlign.center,
                                    style: context
                                        .textTheme.bodyMedium!
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
                        SizedBox(
                            height:
                            widget.info.media.length == 1 ? 32.h : 20.h),
                        if (widget.info.media.length > 1)
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

                  return GestureDetector(
                    onTap: () {
                      FileManager.single(type: FileType.image)
                          .then((response) async {
                        if (response == null) return;
                        widget.info.media.removeAt(index + 1);
                        widget.info.media.insert(index + 1, response);
                        setState(() {});
                      });
                    },
                    child: _SpecialContainer(
                      onDelete: () => setState(() {
                        widget.info.media.removeAt(index + 1);
                        if (videoDataIndex != null && index == videoDataIndex) {
                          videoDataIndex = null;
                          videoData = null;
                        }
                      }),
                      file: widget.info.media[index + 1],
                    ),
                  );
                },
                itemCount: widget.info.media.length,
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
                int total = widget.info.media.length;
                int videos = 0;
                for (int i = 0; i < total; ++i) {
                  if (!isLocal(i) && widget.info.media[i].extension == "mp4") {
                    ++videos;
                  } else if (isLocal(i) &&
                      widget.info.media[i].endsWith("mp4")) {
                    ++videos;
                  }
                }

                if (total > 5) {
                  showError("You need can only upload a maximum of 4 media");
                  return;
                }

                if (videos > 1) {
                  showError("You can only select 1 video");
                  return;
                }

                context.router
                    .pushNamed(Pages.editStepSeven, extra: widget.info);
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
  final dynamic file;
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
    return file is SingleFileResponse ?  Container(
      width: 390.w,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
      ),
      child: data != null
          ? Center(
        child: Container(
          width: 64.r,
          height: 64.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black45,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            size: 48.r,
            color: Colors.white,
          ),
        ),
      )
          : null,
    ) : CachedNetworkImage(
      imageUrl: file,
      errorWidget: (context, url, error) => Container(
        width: 390.w,
        height: 270.h,
        color: weirdBlack50,
        alignment: Alignment.center,
        child: loader,
      ),
      progressIndicatorBuilder: (context, url, download) =>
          Container(
            width: 390.w,
            height: 270.h,
            color: weirdBlack50,
          ),
      imageBuilder: (context, provider) => Container(
        width: 390.w,
        height: 270.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
