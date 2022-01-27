import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePageDeisgn extends StatefulWidget {
  ProfilePageDeisgn({Key? key}) : super(key: key);

  @override
  State<ProfilePageDeisgn> createState() => _ProfilePageDeisgnState();
}

class _ProfilePageDeisgnState extends State<ProfilePageDeisgn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              FittedBox(
                child: Text("QuestionMe",
                    style: TextStyle(fontFamily: 'Title', fontSize: 30)),
                fit: BoxFit.contain,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: InkWell(
                child: FittedBox(
                  child: CircleAvatar(
                    child: Center(
                      child: FittedBox(child: Icon(Icons.add)),
                    ),
                  ),
                  fit: BoxFit.contain,
                ),
                onTap: () => print("Happy"),
              ),
              flex: 2,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(child: Text("Name: ")),
                  Expanded(child: TextField(), flex: 3),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(child: Text("Bio: ")),
                  Expanded(child: TextField(), flex: 3),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 0.3,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  child: Text("Confirm"),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 2,
            )
          ],
        ));
  }
}
