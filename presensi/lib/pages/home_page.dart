import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Detail"),
        backgroundColor: Colors.grey[900],
      ),
      body: const Center(
          child: Text(
        "Detail page",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
// ${user.email!}