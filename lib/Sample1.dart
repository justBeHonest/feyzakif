import 'package:feyzakif/GetAllProduct.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PieChartSample1(),
    );
  }
}

class PieChartSample1 extends StatefulWidget {
  GetAllProduct product = GetAllProduct(
    id: 1500,
    name: 'Bilgisayar',
    description: 'Lenovo-12345',
    stock: 1000,
    price: 2500,
    createdDate: DateTime.now(),
  );
  //PieChartSample1({required this.product});

  @override
  State<StatefulWidget> createState() => PieChartSample1State(product);
}

class PieChartSample1State extends State {
  GetAllProduct product;
  PieChartSample1State(this.product);
  int touchedIndex = -1;
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Icon(Icons.accessible_forward_rounded,color: Colors.blue,),
                    Text(
                      'Bilgisayar',
                      style: TextStyle(
                        fontSize: touchedIndex == 1 ? 18 : 16,
                        color: touchedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Indicator(
                  color: const Color(0xfff8b250),
                  text: product.createdDate.year.toString(),
                  isSquare: false,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff845bef),
                  text: product.description,
                  isSquare: false,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff13d38e),
                  text: product.id.toString(),
                  isSquare: false,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: true,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 1,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.blue.withOpacity(opacity),
              value: product.stock.toDouble(),
              title: product.name,
              radius: screenSize.width * 0.4,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: product.id.toDouble(),
              title: product.createdDate.year.toString(),
              radius: screenSize.width * 0.4,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef).withOpacity(opacity),
              value: product.price.toDouble(),
              title: product.description,
              radius: screenSize.width * 0.4,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: const Color(0xff13d38e).withOpacity(opacity),
              value: product.id.toDouble(),
              title: product.id.toString(),
              radius: screenSize.width * 0.4,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            throw Error();
        }
      },
    );
  }
}
