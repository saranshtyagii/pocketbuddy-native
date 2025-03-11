import 'package:flutter/material.dart';

class Homescreenwidget extends StatefulWidget{
  const Homescreenwidget({super.key});

  @override
  State<Homescreenwidget> createState() {
    return _HomeScreenWidgetState();
  }
}


class _HomeScreenWidgetState extends State<Homescreenwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDetailsCard()
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber
      ),
      padding: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text("Hello Worlds")
            ],
          )
        ],
      ),
    );
  }
  
}