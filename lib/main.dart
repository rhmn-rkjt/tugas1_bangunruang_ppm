import 'package:flutter/material.dart'; 
import 'dart:math'; 

void main() {
  runApp(MyApp()); 
}

// Widget utama aplikasi (tidak berubah / stateless)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VolumePage(), 
    );
  }
}

// StatefulWidget karena data (hasil) bisa berubah
class VolumePage extends StatefulWidget {
  @override
  _VolumePageState createState() => _VolumePageState();
}

// Class state yang berisi logika dan tampilan
class _VolumePageState extends State<VolumePage> {

  String selectedBangun = "Kubus"; // Menyimpan bangun yang dipilih
  double hasil = 0; // Menyimpan hasil perhitungan volume

  // Controller untuk mengambil input dari TextField
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  // Fungsi untuk menghitung volume
  void hitungVolume() {

    // Mengambil nilai dari input dan mengubah ke double
    double nilai1 = double.tryParse(controller1.text) ?? 0;
    double nilai2 = double.tryParse(controller2.text) ?? 0;

    // setState untuk memperbarui tampilan
    setState(() {

      // Jika bangun yang dipilih Kubus
      if (selectedBangun == "Kubus") {
        hasil = pow(nilai1, 3).toDouble(); // Rumus: sisi³
      } 

      // Jika bangun yang dipilih Tabung
      else if (selectedBangun == "Tabung") {
        hasil = pi * pow(nilai1, 2) * nilai2; 
        // Rumus: π × r² × t
      } 

      // Jika bangun yang dipilih Bola
      else if (selectedBangun == "Bola") {
        hasil = (4 / 3) * pi * pow(nilai1, 3);
        // Rumus: 4/3 × π × r³
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // Scaffold adalah kerangka utama halaman
    return Scaffold(
      appBar: AppBar(
        title: Text("Bangun Ruang - L200230130"), 
      ),

      body: Padding(
        padding: EdgeInsets.all(16), 
        child: Column(
          children: [

            // Dropdown untuk memilih bangun ruang
            DropdownButton<String>(
              value: selectedBangun,
              isExpanded: true,
              items: ["Kubus", "Tabung", "Bola"]
                  .map((bangun) => DropdownMenuItem(
                        value: bangun,
                        child: Text(bangun),
                      ))
                  .toList(),

              // Ketika pilihan berubah
              onChanged: (value) {
                setState(() {
                  selectedBangun = value!; 
                  hasil = 0; 
                  controller1.clear();
                  controller2.clear();
                });
              },
            ),

            SizedBox(height: 16), // Jarak antar widget

            // Input sisi atau jari-jari
            TextField(
              controller: controller1,
              keyboardType: TextInputType.number, 
              decoration: InputDecoration(
                labelText: selectedBangun == "Kubus"
                    ? "Sisi (cm)" 
                    : "Jari-jari (cm)", 
              ),
            ),

            SizedBox(height: 16),

            // Input tinggi hanya muncul jika memilih Tabung
            if (selectedBangun == "Tabung")
              TextField(
                controller: controller2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tinggi (cm)",
                ),
              ),

            SizedBox(height: 16),

            // Tombol untuk menghitung volume
            ElevatedButton(
              onPressed: hitungVolume,
              child: Text("Hitung"),
            ),

            SizedBox(height: 16),

            // Menampilkan hasil perhitungan
            Text(
              "Hasil: ${hasil.toStringAsFixed(2)} cm³",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}