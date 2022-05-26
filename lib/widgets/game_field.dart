import 'package:flutter/material.dart';

class GameField extends StatefulWidget {
  GameField({Key? key}) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  List<int> _fieldNumbers = [];
  Chip? blankPlace;
  List<Chip>? _chips;
  var _roundFinished = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newGame();
  }

  bool _checkOrder() {
    for (int i = 0; i < _chips!.length; i++) {
      if (_chips![i].capNumber != i + 1) {
        return false;
      }
    }
    print('sorted');
    return true;
  }

  void _newGame() {
    blankPlace = Chip(
      capNumber: 16,
      capIndex: 15,
      moveCell: _moveCell,
    );
    _fieldNumbers = [for (int i = 1; i < 16; i++) i];
    _fieldNumbers.shuffle();

    setState(() {
      _chips = [
        for (int i = 0; i < _fieldNumbers.length; i++)
          Chip(capNumber: _fieldNumbers[i], capIndex: i, moveCell: _moveCell)
      ];
      _chips!.add(blankPlace!);
      _roundFinished = false;
    });
  }

  void _moveCell(int from, int number) {
    var condition = ((from - blankPlace!.capIndex).abs() != 1 &&
        (from - blankPlace!.capIndex).abs() != 4);
    //print('from $from to ${blankPlace!.capIndex} condition is - ${condition}');
    if ((from - blankPlace!.capIndex).abs() != 1 &&
        (from - blankPlace!.capIndex).abs() != 4) {
      return;
    }
    if (_chips == null) {
      return;
    }

    setState(() {
      _chips![blankPlace!.capIndex] = Chip(
          capNumber: number,
          capIndex: blankPlace!.capIndex,
          moveCell: _moveCell);

      blankPlace!.capIndex = from;
      _chips![from] = blankPlace!;
    });
    if (!_checkOrder()) {
      return;
    }

    setState(() {
      _roundFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget gameField = Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _chips!.sublist(0, 4)),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _chips!.sublist(4, 8)),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _chips!.sublist(8, 12)),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _chips!.sublist(12, 16)),
    ]);
    return _roundFinished
        ? Center(
            child: Column(
              children: [
                Text('You won!'),
                ElevatedButton(onPressed: _newGame, child: Text('New game')),
              ],
            ),
          )
        : Center(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _chips!.sort(
                              ((a, b) => a.capNumber.compareTo(b.capNumber)));
                          for (int i = 0; i < _chips!.length; i++) {
                            _chips![i].capIndex = i;
                          }
                        });
                        _checkOrder();
                      },
                      child: Text('sort')),*/

                  gameField,
                ],
              ),
            ),
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
    final minSize = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    final capSize = (minSize - 40) / 4 as double;

    return capNumber == 16
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
