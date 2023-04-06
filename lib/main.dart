import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Irem Ozdemir commit2'),
      ),
      body: AnaEkranState(),
    );
  }
}

class AnaEkranState extends StatefulWidget {
  const AnaEkranState({Key? key}) : super(key: key);

  @override
  State<AnaEkranState> createState() => _AnaEkranStateState();
}

class _AnaEkranStateState extends State<AnaEkranState> {
  num num1 = 0 ;
  num num2 = 0 ;
  num sonuc = 0 ;

  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();

  sayiTopla() {
    setState(() {
      num1 = num.parse(text1.text);
      num2 = num.parse(text2.text);
      sonuc = num1+num2;
    });
  }
  sayiCikar() {
    setState(() {
      num1 = num.parse(text1.text);
      num2 = num.parse(text2.text);
      sonuc = num1-num2;
    });
  }
  sayiBol() {
    setState(() {
      num1 = num.parse(text1.text);
      num2 = num.parse(text2.text);
      sonuc = num1/num2;
    });
  }
  sayiCarp() {
    setState(() {
      num1 = num.parse(text1.text);
      num2 = num.parse(text2.text);
      sonuc = num1*num2;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextField(controller: text1,),
          TextField(controller: text2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: sayiTopla,
                child: Text('Topla'),
              ),
              ElevatedButton(
                onPressed: () {
                  sayiCikar();
                },
                child: Text('Çıkar'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  sayiBol();
                },
                child: Text('Böl'),
              ),
              ElevatedButton(
                onPressed: () {
                  sayiCarp();
                },
                child: Text('Çarp'),
              ),
            ],
          ),
          Text(sonuc.toString()),
        ],
      ),
    );
  }
}


