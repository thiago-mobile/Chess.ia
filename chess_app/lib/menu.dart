import 'package:chess_app/friendgame.dart';
import 'package:chess_app/game_board.dart';
import 'package:chess_app/time_chess.dart';
import 'package:flutter/material.dart';

class MenuPlay extends StatefulWidget {
  const MenuPlay({Key? key}) : super(key: key);

  @override
  State<MenuPlay> createState() => _MenuPlayState();
}

class _MenuPlayState extends State<MenuPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: Color(0xff1B1B1B),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Nueva Partida',
          style:
              TextStyle(fontFamily: 'MontSerrat-SemiBold', color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  'assets/juegos.png',
                  width: 200,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FriendGame(), // Ejemplo de 60 segundos
                  ),
                );
              },
              child: Container(
                width: 340,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Image.asset(
                        'assets/amistad.png', // Ruta de la segunda imagen
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Text(
                            'Jugar con amigos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'MontSerrat-SemiBold',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 290,
            left: 25,
            child: Container(
              width: 340,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF2E2E2E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Image.asset(
                      'assets/ordenador.png', // Ruta de la segunda imagen
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: Text(
                          'Computadora',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'MontSerrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: 25,
            child: Container(
              width: 340,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF2E2E2E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Image.asset(
                      'assets/lapiz.png', // Ruta de la segunda imagen
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: Text(
                          'Personalizadas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'MontSerrat-SemiBold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 25,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TimePlay()));
                },
                child: Container(
                  width: 340,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(87, 87, 87, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/balas.png', // Ruta de la segunda imagen
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '1 minuto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'MontSerrat-SemiBold',
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TimePlay()));
                          },
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 520,
            left: 25,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => GameBoard()));
              },
              child: Container(
                width: 340,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF60BE08),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Arrancar Partida',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'MontSerrat-Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
