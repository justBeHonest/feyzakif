import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'GetAllProduct.dart';
import 'Sample1.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController kullaniciAdiController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  bool isLoading = false;
  final urlGetAllProducts =
      Uri.parse('http://localhost:5000/api/products/getallproducts');
  bool kontrol = false;
  void girisYap(String kAdi, String sifre) async {
    setState(() {
      isLoading = true;
    });
    if (kAdi == "") {
      print('Kullanıcı adı boş bırakılamaz');
    } else if (sifre == "") {
      print('Şifre boş bırakılamaz');
    } else {
      var response = await http.get(urlGetAllProducts);
      if (response.statusCode == 200) {
        var list = getAllProductFromJson(response.body);
        for (int i = 0; i < list.length; i++) {
          /*print(list[i].name);
          print('***********************');*/

          if (kAdi == list[i].name) {
            if (sifre == list[i].stock.toString()) {
              print('Kullanıcı Girişi Başarılı');
              // ignore: prefer_const_literals_to_create_immutables
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WelcomePage(
                            kullaniciBilgileri: list[i],
                          )));*/
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PieChartSample1(
                           // product: list[i],
                          )));
              kontrol = true;
              break;
            } else {
              print('Şifre Hatalı');
              kontrol = true;
              break;
            }
          } else {
            kontrol = false;
          }
        }

        if (!kontrol) {
          print('kullanıcıBulunamadı');
        }
      } else {
        print('Hata Oluştu');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP & MSSQL'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: kullaniciAdiController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Kullanıcı Adı'),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      obscureText: true,
                      controller: sifreController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Şifre'),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      child: Text('Giriş Yap'),
                      onPressed: () {
                        girisYap(
                            kullaniciAdiController.text, sifreController.text);
                      },
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
