import 'package:feyzakif/GetAllProduct.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  GetAllProduct kullaniciBilgileri;
  WelcomePage({required this.kullaniciBilgileri});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hoşgeldiniz ${widget.kullaniciBilgileri.name}',
        ),
      ),
      body: PageView(
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  title: widget.kullaniciBilgileri.id.toString(),
                  color: Colors.blue,
                ),
                PieChartSectionData(
                  title: widget.kullaniciBilgileri.name,
                  color: Colors.blue,
                ),
                PieChartSectionData(
                  title: widget.kullaniciBilgileri.stock.toString(),
                  color: Colors.blue,
                ),
                PieChartSectionData(
                  title: widget.kullaniciBilgileri.price.toString(),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
