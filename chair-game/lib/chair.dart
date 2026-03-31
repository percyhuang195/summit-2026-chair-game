import 'package:flutter/material.dart';

Widget chair(Color color,int rotation) {
  return SizedBox(
    width: 150,
    height: 200,
    child: Center(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 20,
            child: Container(
              width: 120,
              height: 20,
              color: color,
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                width: 20,
                height: 180,
                color: color,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.rotate(
              angle: -0.1,
              child: Container(
                width: 20,
                height: 180,
                color: color,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            child: Container(
              width: 140,
              height: 20,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
