// ignore_for_file: file_names

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';

import '../Controller/NavController.dart';
import 'DL/DL.dart';
import 'Like.dart';
import 'Search/Search.dart';
import 'Setting.dart';

// ignore: must_be_immutable
class Navigation extends StatelessWidget {
  Navigation({Key? key, t, this.screenIndex = 0}) : super(key: key);

  int? screenIndex;
  final screen = [Search(), const Like(), const DL(), const Setting()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
        init: NavController(index: screenIndex?.obs),
        builder: (c) => Scaffold(
              body: screen[c.index!.value],
              extendBody: true,
              bottomNavigationBar: DotNavigationBar(
                backgroundColor: Theme.of(context).bottomAppBarColor,
                currentIndex: c.index!.value,
                selectedItemColor: Theme.of(context).primaryColor,
                onTap: (index) {
                  c.increment(index);
                },
                items: [
                  DotNavigationBarItem(
                    icon: const Icon(LineIcons.search),
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                  DotNavigationBarItem(
                    icon: Icon(c.index!.value == 1
                        ? LineIcons.heartAlt
                        : LineIcons.heart),
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                  DotNavigationBarItem(
                    icon: const Icon(LineIcons.fileDownload),
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                  DotNavigationBarItem(
                    icon: Icon(c.index!.value == 3
                        ? LineIcons.userAlt
                        : LineIcons.user),
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ));
  }
}
