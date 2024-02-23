import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:hovering/hovering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/blocks_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/footer_widget.dart';
part 'home_page.g.dart';

@riverpod
class MerchTypeState extends _$MerchTypeState {
  @override
  bool build() => true;

  void changeState(bool newState) {
    state = newState;
  }
}

@riverpod
class CardDimensionState extends _$CardDimensionState {
  @override
  List build() => [false, false, false];

  void changeState(int index) {
    state = state
        .asMap()
        .map<int, bool>((currentIndex, value) {
          if (currentIndex == index) {
            return MapEntry(currentIndex, !value);
          } else {
            return MapEntry(currentIndex, value);
          }
        })
        .values
        .toList();
  }
}

class MyAnimationProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final MyAnimationProvider animationProvider = MyAnimationProvider();
  // bool checkState
  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/artists_data.json');
    var data = await json.decode(response);
    List<dynamic> artists = data['artists'];
    List<dynamic> featuredArtists = artists.where((item) {
      return item['featured'] == true;
    }).toList();
    print(featuredArtists);
    return featuredArtists;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isNewReleases = ref.watch(merchTypeStateProvider);
    List dimensions = ref.watch(cardDimensionStateProvider);
    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: animationProvider);
    var animation = new CurvedAnimation(
        parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    bool isDesktop = MediaQuery.sizeOf(context).width < 786;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double firstFoldHeight = MediaQuery.of(context).size.height * 0.75;
          ScrollController scrollController = ScrollController();
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: firstFoldHeight + 105,
                  child: Stack(
                    children: [
                      Container(
                        height: firstFoldHeight + 80,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment
                                  .centerRight, // Align the image to the right
                              child: ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: GFAnimation(
                                  turnsAnimation: animation,
                                  controller: controller,
                                  type: GFAnimationType.scaleTransition,
                                  child: Image.asset(
                                    'assets/people_adventure.jpeg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment
                                  .centerLeft, // Align the text to the left
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50), // Adjust padding as needed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to start
                                  children: [
                                    const Text(
                                      "ALTR YOUR LIFESTYLE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 55,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 500,
                                      child: Text(
                                        "Discover your perfect high with over 100 curated strains, personalized recommendations, and precise weight by the gram - elevating your experience to new heights. Cambridge, Vermont Dispensary EST 2022",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        softWrap: true,
                                        textAlign: TextAlign
                                            .left, // Align text to left
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    SizedBox(
                                        width: 380,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, // Align buttons to start
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size(180, 50),
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100))),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Shop Menu",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            const SizedBox(
                                                width:
                                                    20), // Add spacing between buttons
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    minimumSize:
                                                        const Size(180, 50),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            3, 255, 153, 0),
                                                    shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100))),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Get Directions",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: RippleAnimation(
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         scrollController.animateTo(
                      //             scrollController.offset + 730,
                      //             duration: const Duration(seconds: 1),
                      //             curve: Curves.easeInOut);
                      //       },
                      //       child: const CircleAvatar(
                      //         backgroundColor: Color.fromARGB(173, 65, 64, 64),
                      //         radius: 20,
                      //         child: Center(
                      //           child: Icon(
                      //             Icons.keyboard_arrow_down_rounded,
                      //             color: Colors.white,
                      //             size: 30,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     color: const Color.fromARGB(178, 30, 231, 100),
                      //     delay: const Duration(milliseconds: 500),
                      //     repeat: true,
                      //     minRadius: 30,
                      //     ripplesCount: 0,
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Explore our products",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                // const SizedBox(
                //   height: 60,
                // ),
                !isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 40,
                              // ),
                              Image.asset(
                                'assets/prod 1.png',
                                fit: BoxFit.contain,
                                width: 450,
                                height: 200,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Edibles",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/prod 2.png',
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: const Text(
                                    "Moonrocks",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 40,
                              // ),
                              Image.asset(
                                'assets/prod 3.png',
                                fit: BoxFit.contain,
                                width: 250,
                                height: 200,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Resins",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 40,
                              // ),
                              Image.asset(
                                'assets/prod 4.png',
                                fit: BoxFit.contain,
                                width: 250,
                                height: 200,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Thundersticks",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 40,
                              // ),
                              Image.asset(
                                'assets/prod 5.png',
                                fit: BoxFit.contain,
                                width: 450,
                                height: 200,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Moonrocks",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 450,
                            width: 290,
                            decoration: BoxDecoration(
                                color: Color(0xffe4e3ce),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Image.asset(
                                  'assets/prod 1.png',
                                  fit: BoxFit.contain,
                                  height: 450,
                                  width: 290,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Edibles",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              height: 400,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color(0xffe4e3ce),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Image.asset(
                                    'assets/prod 2.png',
                                    fit: BoxFit.contain,
                                    width: 250,
                                    height: 200,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: const Text(
                                      "Moonrocks",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // TextButton(
                                  //     style: TextButton.styleFrom(
                                  //         minimumSize: Size(170, 45),
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(100)),
                                  //         backgroundColor: Color(0xff22362b)),
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //       "Shop Now",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 400,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/prod 3.png',
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Resins",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 400,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 6, 6, 6),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/prod 4.png',
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Thundersticks",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 100,
                ),
                const Divider(
                  color: Color.fromARGB(112, 255, 255, 255),
                ),
                const SizedBox(
                  height: 100,
                ),
                !isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/stiizy.jpeg',
                            fit: BoxFit.cover,
                            width:
                                0.4861111111 * MediaQuery.sizeOf(context).width,
                            height: 0.4294478528 *
                                MediaQuery.sizeOf(context).height,
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "WHAT IS ALTRD?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                  softWrap: true,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width:
                                      0.41 * MediaQuery.sizeOf(context).width,
                                  child: const Text(
                                    "Started in a garage, ALTRD embodies the spirit of picking yourself up and following opportunity. STIIIZY's proprietary pod system has garnered a cult-like following since its launch and has emerged as a leading lifestyle brand in cannabis.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                              //style="background-image: url(https://altrdcannabis.com/wp-content/uploads/2021/11/Asset-23@2x-100-783x1024.jpg);"
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/stiizy.jpeg',
                            fit: BoxFit.cover,
                            width:
                                0.4861111111 * MediaQuery.sizeOf(context).width,
                            height: 0.4294478528 *
                                MediaQuery.sizeOf(context).height,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "WHAT IS ALTRD?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                  softWrap: true,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width:
                                      0.41 * MediaQuery.sizeOf(context).width,
                                  child: const Text(
                                    "Started in a garage, ALTRD embodies the spirit of picking yourself up and following opportunity. STIIIZY's proprietary pod system has garnered a cult-like following since its launch and has emerged as a leading lifestyle brand in cannabis.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 100,
                ),
                const Divider(
                  color: Color.fromARGB(112, 255, 255, 255),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Merch",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ref
                              .read(merchTypeStateProvider.notifier)
                              .changeState(true);
                        },
                        child: const Text(
                          "New Releases",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(
                      width: 100,
                    ),
                    TextButton(
                        onPressed: () {
                          ref
                              .read(merchTypeStateProvider.notifier)
                              .changeState(false);
                        },
                        child: const Text("Accessories",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                isNewReleases
                    ? !isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 5",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 6",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 4",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 5",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 6",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                            ],
                          )
                    : !isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 8",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 9",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 7",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 8",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://www.stiiizy.com/cdn/shop/files/BACK-04_3d1f77b4-f216-4daf-b986-6d2f75d16565_1800x1800.png?v=1700083875',
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Prod 9",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                height: 300,
                                width: 250,
                              ),
                            ],
                          ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "View All",
                    )),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  height: firstFoldHeight + 180,
                  color: Colors.black,
                  child: GFAnimation(
                    turnsAnimation: animation,
                    controller: controller,
                    type: GFAnimationType.scaleTransition,
                    child: Image.network(
                      'https://media1.tenor.com/m/Yc8wjmfgknsAAAAC/party-party-animal.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Blogs",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: readJson(),
                    builder: (context, snapshot) {
                      return BuildBlockGrid(
                        girdData: snapshot.data!,
                        isRectangular: false,
                        isEvent: false,
                      );
                    }),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Trusted By',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      CarouselSlider(
                        items: [
                          'assets/press1.png',
                          'assets/press2.png',
                          'assets/press3.png',
                          'assets/press1.png',
                          'assets/press2.png',
                          'assets/press3.png',
                        ].map((pressImagePath) {
                          return Image.asset(pressImagePath);
                        }).toList(),
                        options: CarouselOptions(
                          height: constraints.maxWidth <= 600
                              ? firstFoldHeight * 0.2
                              : firstFoldHeight * 0.2,
                          autoPlay: true,
                          viewportFraction:
                              constraints.maxWidth <= 600 ? 0.2 : 0.2,
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
