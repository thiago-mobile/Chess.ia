import 'dart:async';

import 'package:chess_app/components/board.dart';
import 'package:chess_app/components/dead_pieces.dart';
import 'package:chess_app/components/pieces.dart';
import 'package:chess_app/helper/helper_methods.dart';
import 'package:chess_app/menu.dart';
import 'package:chess_app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameBoard extends StatefulWidget {
  final int timeSelected;
  const GameBoard({Key? key, required this.timeSelected}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late List<List<ChessPiece?>> board;

  ChessPiece? selectedPiece;

  int selectedRow = -1;
  int selectedCol = -1;
  int whiteTimeRemaining = 0; // 10 minutos en segundos
  int blackTimeRemaining = 0;
  late Timer timer; // 10 minutos en segundos

  List<List<int>> validMoves = [];

  //lista de piezas que puede agarrar el jugador de negra
  List<ChessPiece> whitePiecesTaken = [];
  //lista de piezas que puede agarrar el jugador de blancas
  List<ChessPiece> blackPiecesTaken = [];

  bool iswhiteturn = true;

  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
  bool checkStatus = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    whiteTimeRemaining = widget.timeSelected;
    blackTimeRemaining = widget.timeSelected;
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (iswhiteturn) {
        setState(() {
          whiteTimeRemaining--;
        });
        if (whiteTimeRemaining <= 0) {
          endGame();
        }
      } else {
        setState(() {
          blackTimeRemaining--;
        });
        if (blackTimeRemaining <= 0) {
          endGame();
        }
      }
    });
  }

  void endGame() {
    timer.cancel();
    // Mostrar diálogo de fin de juego
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¡Fin del tiempo!"),
        content: Text("Se acabó el tiempo para uno de los jugadores."),
        actions: [
          TextButton(
            onPressed: resetGame,
            child: Text("Reiniciar"),
          ),
        ],
      ),
    );
    // Reiniciar el juego aquí si es necesario
  }

// Después de que un jugador mueva su pieza, llamar a esta función para cambiar el turno
  void switchTurn() {
    iswhiteturn = !iswhiteturn;
    // Cancelar el temporizador actual y comenzar el temporizador para el próximo turno
    timer.cancel();
    startTimer();
  }

  //inicializar tabla
  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));
// pieza random para probar
    // newBoard[3][3] = ChessPiece(
    //     imagePath: 'assets/reina.png',
    //     iswhite: false,
    //     type: ChessPieceType.queen);

    //seccion peon
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
          imagePath: 'assets/peon.png',
          iswhite: false,
          type: ChessPieceType.pawn);
      newBoard[6][i] = ChessPiece(
          imagePath: 'assets/peon.png',
          iswhite: true,
          type: ChessPieceType.pawn);
    }

    //place torres
    newBoard[0][0] = ChessPiece(
        imagePath: 'assets/torre.png',
        iswhite: false,
        type: ChessPieceType.rook);
    newBoard[0][7] = ChessPiece(
        imagePath: 'assets/torre.png',
        iswhite: false,
        type: ChessPieceType.rook);
    newBoard[7][0] = ChessPiece(
        imagePath: 'assets/torre.png',
        iswhite: true,
        type: ChessPieceType.rook);
    newBoard[7][7] = ChessPiece(
        imagePath: 'assets/torre.png',
        iswhite: true,
        type: ChessPieceType.rook);

    //place CABALLOS

    newBoard[0][1] = ChessPiece(
        imagePath: 'assets/caballo.png',
        iswhite: false,
        type: ChessPieceType.knight);
    newBoard[0][6] = ChessPiece(
        imagePath: 'assets/caballo.png',
        iswhite: false,
        type: ChessPieceType.knight);
    newBoard[7][1] = ChessPiece(
        imagePath: 'assets/caballo.png',
        iswhite: true,
        type: ChessPieceType.knight);
    newBoard[7][6] = ChessPiece(
        imagePath: 'assets/caballo.png',
        iswhite: true,
        type: ChessPieceType.knight);

    //place alfil
    newBoard[0][2] = ChessPiece(
        imagePath: 'assets/alfil.png',
        iswhite: false,
        type: ChessPieceType.bishop);
    newBoard[0][5] = ChessPiece(
        imagePath: 'assets/alfil.png',
        iswhite: false,
        type: ChessPieceType.bishop);
    newBoard[7][2] = ChessPiece(
        imagePath: 'assets/alfil.png',
        iswhite: true,
        type: ChessPieceType.bishop);
    newBoard[7][5] = ChessPiece(
        imagePath: 'assets/alfil.png',
        iswhite: true,
        type: ChessPieceType.bishop);

    newBoard[0][3] = ChessPiece(
        imagePath: 'assets/reina.png',
        iswhite: false,
        type: ChessPieceType.queen);
    newBoard[7][4] = ChessPiece(
        imagePath: 'assets/reina.png',
        iswhite: true,
        type: ChessPieceType.queen);

    newBoard[0][4] = ChessPiece(
        imagePath: 'assets/rey.png', iswhite: false, type: ChessPieceType.king);
    newBoard[7][3] = ChessPiece(
        imagePath: 'assets/rey.png', iswhite: true, type: ChessPieceType.king);

    board = newBoard;
  }

  //seleccion pieza usuario
  void pieceSelected(int row, int col) {
    setState(() {
      //todavia no se selecciono ninguna pieza, es el primer movimiento
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.iswhite == iswhiteturn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      }

      //hay una pieza ya seleccionada, pero el usuario puede agarrar otras piezas
      else if (board[row][col] != null &&
          board[row][col]!.iswhite == selectedPiece!.iswhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      } else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }

      validMoves = calculateRealValidMoves(
          selectedRow, selectedCol, selectedPiece, true);
    });
  }

  //calcular columnas validas para mover
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    int direction = piece!.iswhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        if (isInboard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        if ((row == 1 && !piece.iswhite) || (row == 6 && piece.iswhite)) {
          if (isInboard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        if (isInboard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.iswhite != piece.iswhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInboard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.iswhite != piece.iswhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
        break;
      case ChessPieceType.rook:
        var directions = [
          [-1, 0], //arriba
          [1, 0], //abajo
          [0, -1], // izquierda
          [0, 1], //DERECHA
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInboard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.iswhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }

        break;
      case ChessPieceType.knight:
        var knightMoves = [
          [-2, -1],
          [-2, 1],
          [-1, -2],
          [-1, 2],
          [1, -2],
          [1, 2],
          [2, -1],
          [2, 1],
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInboard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.iswhite != piece.iswhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
      case ChessPieceType.bishop:
        var directions = [
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInboard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.iswhite != piece.iswhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInboard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.iswhite != piece.iswhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];

        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
          if (!isInboard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.iswhite != piece.iswhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;
      default:
    }

    return candidateMoves;
  }

  List<List<int>> calculateRealValidMoves(
      int row, int col, ChessPiece? piece, bool checkSimulation) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);

    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];
        if (simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

  void movePiece(int newRow, int newCol) {
    // Verificar si el nuevo lugar tiene una pieza enemiga
    if (board[newRow][newCol] != null) {
      // Agregar la pieza capturada a la lista apropiada
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.iswhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }
    }

    // Actualizar la posición del rey si la pieza movida es un rey
    if (selectedPiece!.type == ChessPieceType.king) {
      if (selectedPiece!.iswhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    // Mover la pieza y limpiar la posición anterior
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // Verificar si el rey está en jaque
    if (isKingInCheck(!iswhiteturn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }

    // Actualizar el estado y reiniciar las variables relacionadas con la selección
    setState(() {
      selectedPiece = null;
      selectedCol = -1;
      selectedRow = -1;
      validMoves = [];
    });

    // Verificar si hay jaque mate
    if (isCheckMate(!iswhiteturn)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("¡Jaque Mate!"),
          actions: [
            TextButton(
              onPressed: resetGame,
              child: const Text("Reiniciar Partida"),
            ),
          ],
        ),
      );
    }

    // Cambiar el turno al otro jugador
    iswhiteturn = !iswhiteturn;

    // Pausar el temporizador actual y reanudar para el próximo turno
    timer.cancel();
    startTimer();
  }

  bool isKingInCheck(bool isWhiteKing) {
    List<int> kingPosition =
        isWhiteKing ? whiteKingPosition : blackKingPosition;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null || board[i][j]!.iswhite == isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves =
            calculateRealValidMoves(i, j, board[i][j], false);

        if (pieceValidMoves.any((move) =>
            move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool simulatedMoveIsSafe(
      ChessPiece piece, int startRow, int startCol, int endRow, int endCol) {
    ChessPiece? originalDestinationPiece = board[endRow][endCol];

    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition =
          piece.iswhite ? whiteKingPosition : blackKingPosition;

      if (piece.iswhite) {
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }

    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    bool kingInCheck = isKingInCheck(piece.iswhite);

    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    if (piece.type == ChessPieceType.king) {
      if (piece.iswhite) {
        whiteKingPosition = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }
    return !kingInCheck;
  }

  bool isCheckMate(bool isWhiteKing) {
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null || board[i][j]!.iswhite != isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves =
            calculateRealValidMoves(i, j, board[i][j], true);

        if (pieceValidMoves.isNotEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void resetGame() {
    Navigator.pop(context);
    _initializeBoard();
    checkStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    iswhiteturn = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuPlay()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [],
        title: Text(
          "Chess.ia",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MontSerrat-SemiBold',
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF363636),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinea el contador a la derecha
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${formatTime(blackTimeRemaining)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width:
                      10), // Espacio entre el contador y el borde derecho de la pantalla
            ],
          ),
          //WHITE PIECES TAKEN
          Expanded(
            child: GridView.builder(
              itemCount: whitePiecesTaken.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) => DeadPiece(
                imagePath: whitePiecesTaken[index].imagePath,
                iswhite: true,
              ),
            ),
          ),
          Text(checkStatus ? "CHECK!" : ""),

          //CHESS BOARD
          Expanded(
            flex: 6,
            child: GridView.builder(
              itemCount: 8 * 8,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;

                bool isSelected = selectedRow == row && selectedCol == col;
                bool isValidMove = false;
                for (var position in validMoves) {
                  if (position[0] == row && position[1] == col) {
                    isValidMove = true;
                  }
                }
                return Board(
                  iswhite: iswhite(index),
                  piece: board[row][col],
                  isselect: isSelected,
                  isValidMove: isValidMove,
                  onTap: () => pieceSelected(row, col),
                );
              },
            ),
          ),
          //BLACK PIECES TAKEN
          Expanded(
            child: GridView.builder(
              itemCount: blackPiecesTaken.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) => DeadPiece(
                imagePath: blackPiecesTaken[index].imagePath,
                iswhite: false,
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinea el contador a la derecha
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${formatTime(whiteTimeRemaining)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width:
                      10), // Espacio entre el contador y el borde derecho de la pantalla
            ],
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
