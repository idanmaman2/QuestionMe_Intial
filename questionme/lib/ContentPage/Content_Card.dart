import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ContentCard extends StatefulWidget {
  PageController? ctrl;
  int? index;
  ContentCard({Key? key, @required this.ctrl, @required this.index})
      : super(key: key);

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadowColor: Colors.deepOrange,
      child: Center(
        widthFactor: 1,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  "Card ${(widget.index as int) + 1}",
                  style: TextStyle(fontSize: 32),
                )),
            Expanded(
              flex: 14,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 5),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("19/2/2021"),
                                  ),
                                  Expanded(
                                    child: Container(),
                                    flex: 8,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: RiveAnimation.asset(
                                      'assets/readmessage.riv',
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 16,
                                child: Image.network(
                                    'https://picsum.photos/200/300?random=' +
                                        (widget.index as int).toString())),
                          ],
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ]),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextButton(
                          child: Icon(Icons.arrow_downward),
                          onPressed: () => setState(() {
                            (widget.ctrl as PageController).nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          }),
                        )),
                    Expanded(
                        flex: 1,
                        child: TextButton(
                          child: Icon(Icons.arrow_upward),
                          onPressed: () => setState(() {
                            (widget.ctrl as PageController).previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          }),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
