import 'package:app_mobile/processing/categories.dart';
import 'package:app_mobile/ui/pages/main/main_page.dart';
import 'package:app_mobile/ui/util/app_colors.dart';
import 'package:app_mobile/ui/widgets/main_button.dart';
import 'package:app_mobile/ui/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';

import 'controller.dart';

class StartPage extends StatelessWidget {
  
  final _questions = [
    {
      'title': 'Who are you',
      'field': 'activity',
      'names': Categories.activities.keys.map((key) => Categories.activities[key]['name'] as String).toList(),
      'values': Categories.activities.keys.toList(),
      'multiple': false
    },
    {
      'title': 'Your interests',
      'field': 'interests',
      'names': Categories.interests.keys.map((key) => Categories.interests[key]['name'] as String).toList(),
      'values': Categories.interests.keys.toList(),
      'multiple': true
    },
    //{
    //   'title': 'What culture do you like?',
    //   'field': 'culture',
    //   'names': Categories.culture.keys.map((key) => Categories.culture[key]['name']).toList(),
    //   'values': Categories.culture.keys.toList(),
    //   'multiple': true
    // },
    {
      'title': 'How do you prefer to move?',
      'field': 'driver',
      'names': Categories.drivers.keys.map((key) => Categories.drivers[key]['name'] as String).toList(),
      'values': Categories.drivers.keys.toList(),
      'multiple': false
    },
    {
      'title': 'Your money balance',
      'field': 'material',
      'names': Categories.material.keys.map((key) => Categories.material[key]['name'] as String).toList(),
      'values': Categories.material.keys.toList(),
      'multiple': false
    },
    {
      'title': 'Your age',
      'field': 'age',
      'names': Categories.ages.keys.map((key) => Categories.ages[key]['name'] as String).toList(),
      'values': Categories.ages.keys.toList(),
      'multiple': false
    },
  ];

  final int index;

  final _controller = Controller();

  StartPage(this.index) : super(key: ValueKey(index)) {
    _animate();

    // _controller.checkAll().then((value) {
    //   if (value) {
    //     Get.to(MainPage());
    //   }
    // });
  } 

  void _onNext() async {
    final question = _questions[index];
    _controller.save(question['multiple'], question['field']);
    if (index < _questions.length - 1) {
      Get.to(StartPage(index + 1), transition: Transition.fadeIn, duration: Duration(milliseconds: 300), preventDuplicates: false);
    } else {
      Get.to(MainPage(), duration: Duration(milliseconds: 300), preventDuplicates: false);
    }
  }

  void _onSelect(dynamic value) {
    print(_controller.selected.map((e) => e));
    if (_questions[index]['multiple']) {
      if (_controller.selected.contains(value)) {
        _controller.selected.remove(value);
      } else {
        _controller.selected.add(value);
      }
    } else {
      _controller.selected.clear();
      _controller.selected.add(value);
    }
  }

  void _animate() async {
    _controller.opacity.value = 0.0;
    await Future.delayed(Duration(milliseconds: 300));
    _controller.opacity.value = 1.0;
  }

  Widget _buildQuestions() {
    final names = _questions[index]['names'] as List<String>;
    final values = _questions[index]['values'] as List<String>;
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      alignment: Alignment.topCenter,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(names.length, 
          (index) {
            final selected = _controller.selected.contains(values[index]);
            return Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: InkWell(
                onTap: ()=> _onSelect(values[index]),
                child: Container(
                  width: Get.width * 0.35 - 15,
                  height: Get.width * 0.35 - 15,
                  child: QuestionCard(
                    color: selected ? AppColors.orange : Colors.white,
                    textColor: selected ? Colors.white : Colors.black,
                    text: names[index]
                  ),
                )
              ),
            );
          }
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AnimatedOpacity(
            opacity: _controller.opacity.value,
            duration: Duration(milliseconds: 300),
            child: Text(_questions[index]['title'],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: AppColors.purple,
        body: AnimatedOpacity(
          opacity: _controller.opacity.value,
          duration: Duration(milliseconds: 300),
          child: _buildQuestions(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: AnimatedOpacity(
            opacity: _controller.opacity.value,
            duration: Duration(milliseconds: 300),
            child: _controller.selected.isNotEmpty ? 
            MainButton(
              text: 'Next',
              onPressed: _onNext
            ) : Container(),
          )
        ),
      ),
    );
  }
}


  // Widget _buildQuestions(int index) {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     margin: EdgeInsets.zero,
  //     child: Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(_questions[index]['title'],
  //             style: TextStyle(
  //               fontWeight: FontWeight.w300
  //             ),
  //           ),
  //           MainButton(
  //             text: 'Next',
  //             onPressed: () {
  //               _controller.index.value++;
  //             },
  //           )
  //         ],
  //       ),
  //     )
  //   );
  // }

        // child: GestureDetector(
        //   onHorizontalDragStart: (d){},
        //   onPanStart: (d){},
        //   child: GestureDetector(
        //     onVerticalDragStart: (d){},            
        //     child: Swiper(
        //       loop: false,
        //       itemCount: _questions.length,
        //       controller: _cardController,
        //       layout: SwiperLayout.STACK,
        //       itemWidth: Get.width * 0.8,
        //       itemHeight: Get.height * 0.5,
        //       physics: NeverScrollableScrollPhysics(),
        //       itemBuilder: (BuildContext context,int index) { 
        //         return _buildQuestions(index);
        //       }
        //     )

        //   ),
        // ),