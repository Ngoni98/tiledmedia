import 'package:flutter/material.dart';
import 'package:tiledmedia/data/models/encode.model.dart';
import 'package:tiledmedia/screens/schedule/step_choose/index.dart';
import 'package:tiledmedia/screens/schedule/step_encode/index.dart';
import 'package:tiledmedia/screens/schedule/step_schedule/index.dart';
import 'package:tiledmedia/screens/schedule/step_video/index.dart';
import 'package:tiledmedia/screens/schedule/step_video/step_video.dart';
import 'package:tiledmedia/widgets/appbar_layout/index.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key}) : super(key: key);

  @override
  _ScheduleState createState() => new _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  int current = 0;
  List<Step> spr = <Step>[];
  Encode encode;

  List<Step> _getSteps(BuildContext context) {
    spr = <Step>[
      Step(
        title: const Text('Choose Profile'),
        content: new StepChoose(
          encode: encode,
          onNext: _moveNext,
          onPrev: _movePrev,
        ),
        state: _getState(0),
        isActive: true,
      ),
      Step(
        title: const Text('Encode Setting'),
        content: new StepEncode(
          encode: encode,
          onNext: _moveNext,
          onPrev: _movePrev,
        ),
        state: _getState(1),
        isActive: true,
      ),
      Step(
        title: const Text('Video Setting'),
        content: new StepVideo(
          encode: encode,
          onNext: _moveNext,
          onPrev: _movePrev,
        ),
        state: _getState(2),
        isActive: true,
      ),
      Step(
        title: const Text('Schedule'),
        content: new StepSchedule(
          encode: encode,
          onNext: _moveNext,
          onPrev: _movePrev,
        ),
        state: _getState(3),
        isActive: true,
      ),
    ];
    return spr;
  }

  void _moveNext() {
    if (current < _getSteps(context).length - 1) {
      setState(() {
        current++;
      });
    }
  }

  void _movePrev() {
    if (current > 0) {
      setState(() {
        current--;
      });
    }
  }

  StepState _getState(int i) {
    if (current > i) {
      return StepState.complete;
    } else if (current == i) {
      return StepState.editing;
    } else {
      return StepState.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (encode == null) {
      setState(() {
        encode = new Encode();
      });
    }
    return new Scaffold(
      appBar: new AppBarLayout(appBarTitle: 'Schedule Video', context: context),
      body: new Container(
        child: new Stepper(
          steps: _getSteps(context),
          type: StepperType.horizontal,
          currentStep: current,
          controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) => Container(),
        ),
      ),
    );
  }
}
