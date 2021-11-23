import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Diamond extends StatefulWidget {
  const Diamond(this.userInput, {Key? key}) : super(key: key);
  final int userInput;
  @override
  _DiamondState createState() => _DiamondState();
}

class _DiamondState extends State<Diamond> {
  late int boxes;
  late int row;
  late int input;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;

  @override
  void initState() {
    row = (2 * widget.userInput) - 1;
// boxes = pow(row, 2).toInt();
    super.initState();
    _scrollController1 = ScrollController();
    _scrollController = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController1.jumpTo(
        (_scrollController.position.maxScrollExtent / 2.3),
      );
      _scrollController.jumpTo(
        (_scrollController.position.maxScrollExtent / 2.3),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.redAccent,
            body: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.purple,
                child: SingleChildScrollView(
                    controller: _scrollController1,
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: row * 50,
                      width: row * 50,
                      child: GridView.count(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: row,
                        children: pattern(widget.userInput),
                      ),
                    )),
              ),
            )));
  }

  List<Widget> pattern(int userInput) {
    var listWidget = <Widget>[];
    int size = row;
    int start, end, mid;
    int containerText = 0;
    start = end = mid = size ~/ 2;
    for (int row = 0; row < size; row++) {

      for (int col = 0; col < size; col++) {
        if (col >= start && col <= end) {
          if (col <= (start + end) / 2) {
            containerText++;
          } else {
            containerText--;
          }
          listWidget.add(
              (col <= (start + end) / 2)
              ? FadeInDown(
            duration: Duration(
                milliseconds: (row + 1) >= userInput
                    ? 300 * ((userInput * 2) - row)
                    : 300 * row
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                '$containerText',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
              : FadeInUp(
            duration: Duration(
                milliseconds: (row + 1) >= userInput
                    ? 300 * ((userInput * 2) - row)
                    : 300 * row
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                '$containerText',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ));
        } else {
          listWidget.add(const SizedBox());
        }
      }
      if (row < mid) {
        start--;
        end++;
      } else {
        start++;
        end--;
      }
      containerText = 0;
    }
// print(listWidget.length);
// print(boxes);
    return listWidget;
  }
}