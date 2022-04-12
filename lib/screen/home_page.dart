import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text("Faiz Project"),
            const SizedBox(height: 5),
            const Text(
              "Cats & Dog Detector",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            isloading
                ? const Center(
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: Icon(Icons.camera_alt_sharp),
                    ),
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("capture a photo")),
                ElevatedButton(
                    onPressed: () {}, child: const Text("select a photo"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
