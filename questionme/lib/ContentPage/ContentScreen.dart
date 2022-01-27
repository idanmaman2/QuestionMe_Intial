import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:questionme/ContentPage/Content_Card.dart';

import 'Content_Card.dart';

class Content extends StatefulWidget {
  Content({Key? key}) : super(key: key);

  @override
  _Content createState() => _Content();
}

class _Content extends State<Content> {
  int _index = 0;

  final _controller = new PageController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.95,
        widthFactor: 1, // card height
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          onPageChanged: (int index) => setState(() => _index = index),
          controller: _controller,
          itemBuilder: (_, i) {
            return ContentCard(ctrl: _controller, index: _index);
          },
        ),
      ),
    );
  }
}
