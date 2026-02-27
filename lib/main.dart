  import 'package:flutter/material.dart';
  import 'dart:math';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: VolumePage(),
      );
    }
  }

  class VolumePage extends StatefulWidget {
    @override
    _VolumePageState createState() => _VolumePageState();
  }

  class _VolumePageState extends State<VolumePage> {
    String selectedBangun = "Kubus";
    double hasil = 0;

    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();

    void hitungVolume() {
      double nilai1 = double.tryParse(controller1.text) ?? 0;
      double nilai2 = double.tryParse(controller2.text) ?? 0;

      setState(() {
        if (selectedBangun == "Kubus") {
          hasil = pow(nilai1, 3).toDouble();
        } else if (selectedBangun == "Tabung") {
          hasil = pi * pow(nilai1, 2) * nilai2;
        } else if (selectedBangun == "Bola") {
          hasil = (4 / 3) * pi * pow(nilai1, 3);
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Bangun Ruang - L200230130"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              DropdownButton<String>(
                value: selectedBangun,
                isExpanded: true,
                items: ["Kubus", "Tabung", "Bola"]
                    .map((bangun) => DropdownMenuItem(
                          value: bangun,
                          child: Text(bangun),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBangun = value!;
                    hasil = 0;
                    controller1.clear();
                    controller2.clear();
                  });
                },
              ),

              SizedBox(height: 16),

              TextField(
                controller: controller1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: selectedBangun == "Kubus"
                      ? "Sisi"
                      : "Jari-jari",
                ),
              ),

              SizedBox(height: 16),

              if (selectedBangun == "Tabung")
                TextField(
                  controller: controller2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tinggi",
                  ),
                ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: hitungVolume,
                child: Text("Hitung"),
              ),

              SizedBox(height: 16),

              Text("Hasil: ${hasil.toStringAsFixed(2)}"),
            ],
          ),
        ),
      );
    }
  }