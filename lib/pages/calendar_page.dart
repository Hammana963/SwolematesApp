// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import '../components/calendar_box.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var boxStatus = [];

  final int calendarBoxCount = 7 * 18;
  final int calendarBoxInEachRow = 7;
  var userTimes = []; // 0 if time unselected, 1 if time is selected

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < calendarBoxCount; i++) {
      boxStatus.add(false);
      userTimes.add(0);
    }

    // print(boxStatus);
    // print(boxStatus.length);
    // print(userTimes);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectBox(int index) {
    setState(() {
      boxStatus[index] = !(boxStatus[index]);
      userTimes[index] = 1;
    });
  }

  String setTimes(int index) {
    int time = (index + 5) % 12 + 1;
    String amOrpm = (index + 5) < 11 || (index + 5) > 22 ? "am" : "pm";
    return "$time $amOrpm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Top page text
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        "When can you",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "Go to the gym?",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "It will help us find",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "the right partner for you",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Unavailable",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    const Text(
                      "Available",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Tap to toggle",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            //grid
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 415,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 19,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(1.3),
                                child: Text(
                                  setTimes(index),
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.right,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(width: 10),
                        Text(
                          "Sun",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Mon",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Tue",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Wed",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Thu",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 17),
                        Text(
                          "Fri",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 17),
                        Text(
                          "Sat",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                    SizedBox(
                      width: 290,
                      height: 415,
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: calendarBoxCount,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            crossAxisCount: calendarBoxInEachRow,
                            childAspectRatio: (20 / 10),
                          ),
                          itemBuilder: (context, index) {
                            return CalendarBox(
                              child: index,
                              selected: boxStatus[index],
                              function: () {
                                //pointer detected on box turns box green
                                selectBox(index);
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void scheduleRebuild() => setState(() {});
}
