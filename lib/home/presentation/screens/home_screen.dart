import 'package:daldart/home/presentation/controller/home_controller.dart';
import 'package:daldart/home/presentation/widgets/tab_view_body.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List tabs = const ['Hot', 'new', 'Rising'];

  @override
  void initState() {
    Get.find<HomeController>().tabController =
        TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('/r/FlutterDev'),
        bottom: TabBar(
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: Get.find<HomeController>().tabController,
            onTap: (i) {
              Get.find<HomeController>().checkIsPageInitalized(i);
            },
            tabs: List.generate(
                3,
                (index) => Text(
                      tabs[index],
                      style:const TextStyle(color: Colors.black),
                    ))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TabBarView(
            controller: Get.find<HomeController>().tabController,
            children:tabs.map((e) =>const TabViewBody()).toList() ,
          ),
        ),
      ),
    );
  }
}
