import 'package:flutter/material.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Components/functions.dart';
import '../models/onboard.dart';
import 'Loginpage.dart';

class onboard extends StatefulWidget {
  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  List<onboardmodel> boarding = [
    onboardmodel(
      image: 'assets/mylib.png',
      title: 'Welcome To Our Library Application',
    ),
    onboardmodel(
      image: 'assets/sell.png',
      title: 'Sell And Display All Of Your Lib Books',
    ),
    onboardmodel(
      image: 'assets/buy.png',
      title: 'Explore And Buy Any Book You Need',
    ),
  ];

  var bordcon = PageController();
  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,

        actions: [
          TextButton(
            onPressed: () {
              cashhelper.savedata(key: 'onbord', value: true);
              navandfin(context, loginpage());

            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color:  Colors.white,
        ),
        height: double.infinity,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: bordcon,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildborditem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: bordcon,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.amberAccent,
                      dotColor: Colors.blueGrey,
                      dotHeight: 20,
                      spacing: 5.0,
                      expansionFactor: 4,
                    ),
                  ),
                  Spacer(),

                   FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        cashhelper.savedata(key: 'onbord', value: true);
                        navandfin(context, loginpage());
                      } else {
                        bordcon.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                    child: Icon(Icons.arrow_forward_ios_outlined),
                    backgroundColor: Colors.amberAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildborditem(onboardmodel model) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              '${model.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.lightGreen,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
}
