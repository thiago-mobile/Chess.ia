import 'package:chess_app/game_board.dart';
import 'package:chess_app/menu.dart';
import 'package:flutter/material.dart';

class TimePlay extends StatefulWidget {
  const TimePlay({Key? key}) : super(key: key);

  @override
  State<TimePlay> createState() => _TimePlayState();
}

class _TimePlayState extends State<TimePlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: const Color(0xff1B1B1B),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPlay()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Tiempo De Juego',
          style: TextStyle(
            fontFamily: 'MontSerrat-SemiBold',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 70.0,
              color: const Color(0xff1B1B1B),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Image.asset(
                    'assets/balas.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre la imagen y el texto
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Bala',
                    style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold', color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
//SECCION BALA
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 60), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '1 min',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 60 + 1), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '1|1',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 60 + 4), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '1|4',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//SECCION BLITZ
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Image.asset(
                    'assets/destello.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre la imagen y el texto
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Blitz',
                    style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold', color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 180), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '3 min',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 180 + 4), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '3|4',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 180 + 10), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '3|10',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//SECCION BLITZ
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Image.asset(
                    'assets/tiempo-rapido.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre la imagen y el texto
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Rapida',
                    style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold', color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 330),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 300), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '10 min',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 300 + 5), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '10|5',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameBoard(
                            timeSelected: 300 + 10), // Ejemplo de 60 segundos
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B6B6B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        '10|10',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.9);
    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height * 0.9);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.8);
    final secondEndPoint = Offset(size.width, size.height * 0.9);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
