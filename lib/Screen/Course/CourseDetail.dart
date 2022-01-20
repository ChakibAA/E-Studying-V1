// ignore_for_file: file_names
import 'dart:developer';

import 'package:estudyingv1/Model/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../Service/SizeConfig.dart';
import '../../Widget/AppBar.dart';

///
// ignore: must_be_immutable
class CourseDetail extends StatefulWidget {
  CourseDetail({Key? key, required this.data, this.like = false})
      : super(key: key);

  Course data;
  bool? like;
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<CourseDetail> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    String videoId = widget.data.youtubeLink!.split('?v=').last;
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => widget.like == true
                  ? widget.data.removeLike()
                  : widget.data.like(),
              child: const Icon(
                LineIcons.heart,
                color: Colors.white,
              )),
          appBar: appBar(value: widget.data.module!.name!, context: context),
          body: ListView(
            children: [
              videoPlayer(player),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title!,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(8),
                    ),
                    Text(
                      widget.data.module!.name!,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      widget.data.description!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              widget.data.courseRar == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await widget.data.openFile(context);
                            Get.back();
                            Get.snackbar('Téléchargement',
                                'Le cours a était télécharger avec succes',
                                snackPosition: SnackPosition.BOTTOM);
                          } catch (e) {
                            Get.back();
                            Get.snackbar('Erreur',
                                'erreur dans le téléchargement de ce cours',
                                snackPosition: SnackPosition.BOTTOM);
                            // ignore: avoid_print
                            print(e);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor,
                          ),
                          elevation: MaterialStateProperty.all(0),
                          fixedSize: MaterialStateProperty.all(Size(
                              getProportionateScreenWidth(50),
                              getProportionateScreenHeight(50))),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                        ),
                        child: Text(
                          'Télécharger les ${widget.data.type!.name}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          )),
    );
  }

  Stack videoPlayer(YoutubePlayerIFrame player) {
    return Stack(
      children: [
        player,
        Positioned.fill(
          child: YoutubeValueBuilder(
            controller: _controller,
            builder: (context, value) {
              return AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Material(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          YoutubePlayerController.getThumbnail(
                            videoId: 'tcodrIK2P_I',
                            quality: ThumbnailQuality.medium,
                          ),
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                crossFadeState: value.isReady
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
