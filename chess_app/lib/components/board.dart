import 'package:chess_app/components/pieces.dart';
import 'package:chess_app/values/colors.dart';
import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  final bool iswhite;
  final ChessPiece? piece;
  final bool isselect;
  final bool isValidMove;
  final void Function()? onTap;
  const Board(
      {super.key,
      required this.iswhite,
      required this.piece,
      required this.isselect,
      required this.onTap,
      required this.isValidMove});

  @override
  Widget build(BuildContext context) {
    Color? boardColor;

    if (isselect) {
      boardColor = Color(0xFFBDC736);
    } else if (isValidMove) {
      boardColor = Color(0xFFBDC736);
    } else {
      boardColor = iswhite ? Color(0xEBEFF0D5) : Color(0xEB5FA504);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: boardColor,
        margin: EdgeInsets.all(isValidMove ? 8 : 0),
        child: piece != null
            ? Image.asset(
                piece!.imagePath,
                color: piece!.iswhite ? Colors.white : Colors.black,
              )
            : null,
      ),
    );
  }
}
