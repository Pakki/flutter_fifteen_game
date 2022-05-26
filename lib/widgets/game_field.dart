import 'package:flutter/material.dart';

class GameField extends StatefulWidget {
  GameField({Key? key}) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  List<int> _fieldNumbers = [for (int i = 1; i < 16; i++) i];
  Chip? blankPlace;
  List<Widget>? _chips;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blankPlace = Chip(
      capNumber: 0,
      capIndex: 15,
      moveCell: _moveCell,
    );
    _fieldNumbers.shuffle();
    _chips = [
      for (int i = 0; i < _fieldNumbers.length; i++)
        Chip(capNumber: _fieldNumbers[i], capIndex: i, moveCell: _moveCell)
    ];
    _chips!.add(blankPlace!);
  }

  bool _checkOrder() {
    for (int i = 0; i < _chips!.length; i++) {
      if ((_chips![i] as Chip).capNumber != i + 1) {
        return false;
      }
    }
    return true;
  }

  void _moveCell(int from, int number) {
    print(from);
    print(blankPlace!.capIndex);
    print('${(from - blankPlace!.capIndex).abs()}');
    if ((from - blankPlace!.capIndex).abs() != 1 &&
        (from - blankPlace!.capIndex).abs() != 4) {
      print('can\'t move');
      return;
    }
    if (_chips == null) {
      print('caps is null');
      return;
    }

    setState(() {
      _chips![blankPlace!.capIndex] = Chip(
          capNumber: number,
          capIndex: blankPlace!.capIndex,
          moveCell: _moveCell);
      print('current values $from ${blankPlace!.capIndex}');
      blankPlace!.capIndex = from;
      _chips![from] = blankPlace!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget gameField = Column(children: [
      Row(children: _chips!.sublist(0, 4)),
      Row(children: _chips!.sublist(4, 8)),
      Row(children: _chips!.sublist(8, 12)),
      Row(children: _chips!.sublist(12, 16)),
    ]);
    return Column(
      children: [
        gameField,
      ],
    );
  }
}

class Chip extends StatelessWidget {
  final int capNumber;
  int capIndex;
  Function moveCell;
  Chip({
    Key? key,
    required this.capNumber,
    required this.capIndex,
    required this.moveCell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pixRatio = MediaQuery.of(context).devicePixelRatio;
    final capSize =
        (MediaQuery.of(context).size.width - 80) * pixRatio / 4 as double;
    return capNumber == 0
        ? Container(
            height: capSize,
            width: capSize,
            margin: EdgeInsets.all(2),
          )
        : GestureDetector(
            onTap: () {
              moveCell(capIndex, capNumber);
            },
            child: Container(
              margin: EdgeInsets.all(2),
              height: capSize,
              width: capSize,
              //color: Color.fromARGB(255, 234, 212, 147),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 232, 173, 78).withOpacity(0.5),
                  width: 3,
                ),
                color: Color.fromARGB(255, 234, 212, 147),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 232, 173, 78).withOpacity(0.5),
                    ),
                    color: Color.fromARGB(255, 238, 233, 216),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$capNumber',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
