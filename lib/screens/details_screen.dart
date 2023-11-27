import 'package:flutter/material.dart';
import 'package:peace_pulse/models/audioModel.dart';

class DetailsScreen extends StatefulWidget {
  MyAudio myAudio;
  DetailsScreen({Key? key, required this.myAudio}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("just a data"),
      ),
    );
  }
}
