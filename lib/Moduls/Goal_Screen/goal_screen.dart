import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controllers/goalController.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {

  List<Segment> segments = [
    Segment(value: 92, color: Colors.blue),
    Segment(value: 8, color: Colors.green),
  ];

  List<int> saving = [1875];

  final List<String> icons = [
    "Assets/Image/home.PNG",
    "Assets/Image/sedan.PNG",
    "Assets/Image/piggy-bank.PNG",
    "Assets/Image/loan.PNG",
  ];

  @override
  Widget build(BuildContext context) {
    final progressBar = PrimerProgressBar(segments: segments);

    return Scaffold(
      backgroundColor: Color.fromRGBO(209, 234, 255, 1.0),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
            ),
          ),
          child: GetBuilder(
              init: DataController(),
              builder: (controller) {
                return Column(
                  children: [
                    StreamBuilder(
                      stream: controller.fireStore,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          controller.maxIndex = snapshot.data!.docs.length;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Text(
                                      snapshot
                                          .data!
                                          .docs[controller.activeIndex ==
                                                      controller.maxIndex
                                                  ? controller.maxIndex
                                                  : controller.activeIndex]
                                              ['goalname']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 28),
                                    ),
                                    VxSwiper.builder(
                                      height: 300,
                                      itemCount: 4,
                                      autoPlay: false,
                                      aspectRatio: 14 / 5,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      enlargeCenterPage: true,
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 700),
                                      viewportFraction: 0.9,
                                      onPageChanged: controller.onPageChange,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 500,
                                          width: 500,
                                          child: SfRadialGauge(
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                minimum: 0,
                                                maximum: double.parse(snapshot
                                                    .data!
                                                    .docs[controller
                                                                .activeIndex ==
                                                            controller.maxIndex
                                                        ? controller.maxIndex
                                                        : controller
                                                            .activeIndex]['goal']
                                                    .toString()),
                                                showLabels: false,
                                                showTicks: false,
                                                radiusFactor: 0.7,
                                                axisLineStyle: AxisLineStyle(
                                                    cornerStyle:
                                                        CornerStyle.bothCurve,
                                                    color: Colors.black12,
                                                    thickness: 4),
                                                pointers: <GaugePointer>[
                                                  RangePointer(
                                                    enableAnimation: true,
                                                    value: double.parse(snapshot
                                                        .data!
                                                        .docs[
                                                            controller.activeIndex ==
                                                                    controller
                                                                        .maxIndex
                                                                ? controller
                                                                    .maxIndex
                                                                : controller
                                                                    .activeIndex]
                                                            ['progress']
                                                        .toString()),
                                                    cornerStyle:
                                                        CornerStyle.bothCurve,
                                                    width: 5,
                                                    sizeUnit: GaugeSizeUnit
                                                        .logicalPixel,
                                                  ),
                                                  MarkerPointer(
                                                      enableAnimation: true,
                                                      value: double.parse(snapshot
                                                          .data!
                                                          .docs[
                                                              controller.activeIndex ==
                                                                      controller
                                                                          .maxIndex
                                                                  ? controller
                                                                      .maxIndex
                                                                  : controller
                                                                      .activeIndex]
                                                              ['progress']
                                                          .toString()),
                                                      enableDragging: true,
                                                      onValueChanged:
                                                          (value) {},
                                                      markerHeight: 8,
                                                      markerWidth: 8,
                                                      markerType:
                                                          MarkerType.circle,
                                                      color: Colors.white,
                                                      borderWidth: 0.5,
                                                      borderColor: Colors.white)
                                                ],
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                    angle: 90,
                                                    axisValue: 4,
                                                    positionFactor: 0.2,
                                                    widget: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 60),
                                                      child: Column(
                                                        children: [

                                                          Container(
                                                            height: 60,
                                                            width: 60,
                                                            child: Image.asset(icons[index].toString()),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            '\$${snapshot.data!.docs[index]['progress']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            'You Saved',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    AnimatedSmoothIndicator(
                                      duration: Duration(seconds: 1),
                                      activeIndex: controller.activeIndex,
                                      count: snapshot.data!.docs.length,
                                      effect: WormEffect(
                                        dotHeight: 12,
                                        dotWidth: 12,
                                        activeDotColor: Colors.white,
                                        radius: 16,
                                      ),
                                      onDotClicked: (index) {
                                        controller.activeIndex = index;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 40,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          'Goal',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          snapshot
                                              .data!
                                              .docs[controller.activeIndex ==
                                                          controller.maxIndex
                                                      ? controller.maxIndex
                                                      : controller.activeIndex]
                                                  ['endgoal']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12),
                                        ),
                                        trailing: Text(
                                          "\$${snapshot.data!.docs[controller.activeIndex == controller.maxIndex ? controller.maxIndex : controller.activeIndex]['goal']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 20,
                                          bottom: 20),
                                      margin: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Need more savings',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "\$ ${snapshot.data!.docs[controller.activeIndex == controller.maxIndex ? controller.maxIndex : controller.activeIndex]['moreSaving']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Monthly Saving Projection',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "\$ ${snapshot.data!.docs[controller.activeIndex == controller.maxIndex ? controller.maxIndex : controller.activeIndex]['savingProjection']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'contribution',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            trailing: Text(
                                              'Show History',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListTile(
                                            title: progressBar,
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Monthly Salary ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Text('•',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 35,
                                                    color: Colors.indigo)),
                                            trailing: Text(
                                              "\$${snapshot.data!.docs[index]['monthlySalary']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: saving.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15,
                                                    left: 15,
                                                    bottom: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('•   ',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 35,
                                                                    color: Colors.green)),
                                                            Text(
                                                              "Manthly saving",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 18),
                                                          child: Text(
                                                            "\$${saving[index].toString()}",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('•   ',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 35,
                                                                    color: Colors.blue)),
                                                            Text(
                                                              "Manthly Expance",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 10),
                                                          child: Text(
                                                            "\$43125",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
