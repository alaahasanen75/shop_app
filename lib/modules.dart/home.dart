import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/modules.dart/login_scrren.dart';
import 'package:flutter_application_1/shared_prefrance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boarder {
  late final String image;
  late final String title;
  late final String body;
  Boarder({required this.body, required this.image, required this.title});
}

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({super.key});

  @override
  State<onboardingScreen> createState() => _BoardingState();
}

class _BoardingState extends State<onboardingScreen> {
  @override
  Widget build(BuildContext context) {
    bool? islast;
    void submit() {
      CachHelper.SaveData(value: true, key: 'onBording').then((value) {
        if (value!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => Shoplogin())),
              (route) => false);
        }
      });
    }

    var boardcontroller = PageController();
    List<Boarder> board = [
      Boarder(
          body: 'on board 1 body',
          image: 'images/shop.jpg',
          title: 'on board 1 title'),
      Boarder(
          body: 'on board 2 body',
          image: 'images/shop.jpg',
          title: 'on board 2 title'),
      Boarder(
          body: 'on board 3 body',
          image: 'images/shop.jpg',
          title: 'on board 3 title')
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (value) {
                print(value);
                if (value == board.length - 1) {
                  print('last');
                  setState(
                    () {
                      islast = true;
                      print('$islast');
                    },
                  );
                } else {
                  print('Notlast');
                  setState(
                    () {
                      islast = false;
                      print('$islast');
                    },
                  );
                }
              },
              physics: BouncingScrollPhysics(),
              controller: boardcontroller,
              itemBuilder: ((context, index) => OnBoard(board[index])),
              itemCount: board.length,
            )),
            SizedBox(
              height: 45,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: board.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      activeDotColor: defaulltColor,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast == true) {
                      submit();
                    } else {
                      print('لااااء تروووووو');
                      boardcontroller.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget OnBoard(Boarder moudel) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset('${moudel.image}')),
        SizedBox(
          height: 15,
        ),
        Text(
          '${moudel.title}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${moudel.body}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
