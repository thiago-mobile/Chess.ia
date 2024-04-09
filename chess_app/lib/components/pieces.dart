enum ChessPieceType { pawn, rook, knight, bishop, queen, king }

class ChessPiece {
  final ChessPieceType type;
  final bool iswhite;
  final String imagePath;

  ChessPiece(
      {required this.imagePath, required this.iswhite, required this.type});
}
