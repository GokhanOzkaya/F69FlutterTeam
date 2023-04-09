import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fteamdeneme/a.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page=0;
  @override
  void initState() {
    super.initState();
    _page = 2;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _bottomNavigationKey.currentState!.setPage(_page);
    });
  }
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget _buildPage(int page) {
    debugShowCheckedModeBanner: false;
    switch (page) {
      case 0:
        return FirstPage();
      case 1:
        return SecondPage();
      case 2:
        return ThirdPage();
      case 3:
        return ThirdPage();
      case 4:
        return ThirdPage();
    // Diğer sayfalar...
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _buildPage(_page),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('First Page'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zaman Yönetimi",
      theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue,
            onPrimary: Colors.black,


            secondary: Colors.grey,

            onSecondary: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,)
      ),
      home: Temel(),

    );
  }
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late ScrollController scrollController;

  GorevVeri gorevveri1 = GorevVeri();
  int selectedMonth = 5;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: (360) * (selectedMonth - 1));
  }

  Card buildCard(int index, int month) {
    bool isChecked = gorevveri1.getGorevForMonth(month, index).tamamlandiMi;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              gorevveri1.getGorevForMonth(month, index).tamamlandiMi = isChecked;
            });
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: isChecked ? Colors.blue : Colors.grey.shade400,
              ),
              color: isChecked ? Colors.blue : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: isChecked
                  ? Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              )
                  : null,
            ),
          ),
        ),
        title: Text(
          '${gorevveri1.getGorevForMonth(month, index).ad}',
          style: TextStyle(
            fontSize: 18,
            decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: GestureDetector(
            child: Icon(Icons.alarm_add,)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Merhaba Gökhan',
                  textScaleFactor: 2,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedMonth = index + 1; // ay indeksleri 0'dan başladığı için 1 eklemelisiniz
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 360,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.white10,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 5), // vertical shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${gorevveri1.aylar[index]}',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 50.0,
                                  color: Colors.white,
                                  icon: Icon(Icons.analytics),
                                  onPressed: () {
                                    // Icon'a tıklanınca yapılacak işlemler buraya yazılır
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gorevveri1.getGorevlerForMonth(selectedMonth).length,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(index, selectedMonth);
              },
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  int checkedCount = 0;
                  gorevveri1.getGorevlerForMonth(selectedMonth).forEach((gorev) {
                    if (gorev.tamamlandiMi) checkedCount++;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Seçili görev sayısı: $checkedCount"),
                        content: Text("İçerik"),
                        actions: [
                          TextButton(
                            child: Text("Tamam"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('asf'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class Temel extends StatelessWidget {
  const Temel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Zaman Yönetimi"),
      ),
      body: Zaman(),
    );
  }
}

class Zaman extends StatelessWidget {
  const Zaman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: Padding (
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child:
                ElevatedButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(
                      builder:(context)=> EisenhowerMatrisi(),
                    ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,

                  ),
                  child: Text("EISENHOWER MATRİSİ"),
                ),
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child:    ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Pomodoro(),),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,

                    ),
                    child: Text("POMODORO TEKNİĞİ"),
                  )
              ),
            ),
          ]
      ),
    );


  }

}
class EisenhowerMatrisi extends StatefulWidget {
  const EisenhowerMatrisi({Key? key}) : super(key: key);

  @override
  State<EisenhowerMatrisi> createState() => _EisenhowerMatrisiState();
}

class _EisenhowerMatrisiState extends State<EisenhowerMatrisi> {
  String _selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eisenhower Matrisi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Lütfen işinizi aşağıdaki kategorilere göre seçin:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RadioListTile(
              title: Text(
                'Acil ve Önemli',
                style: TextStyle(fontSize: 16.0),
              ),
              value: 'Hemen başla',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'Acil Değil, Önemli',
                style: TextStyle(fontSize: 16.0),
              ),
              value: 'Yapacağın zamanı belirle',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'Acil, Önemsiz',
                style: TextStyle(fontSize: 16.0),
              ),
              value: 'Başkasına devret',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            RadioListTile(
              title: Text(
                'Acil Değil, Önemsiz',
                style: TextStyle(fontSize: 16.0),
              ),
              value: 'İptal Et / Ertele',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            SizedBox(height: 20),
            _selectedOption.isNotEmpty
                ? Text(
              'Seçiminiz: $_selectedOption',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            )
                : Container(),
          ],
        ),
      ),

    );
  }
}


class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,

        title: Text("Pomodoro"),
        foregroundColor: Colors.white,
      ),
      body: TPmdr(),
    );
  }

}
class TPmdr extends StatefulWidget {
  @override
  _TPmdrState createState()=> _TPmdrState();




}

class _TPmdrState extends State<TPmdr> {


  int _seconds = 1500;
  int _initialSeconds = 1500;
  bool _isRunning = false;
  Timer? _timer;



  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        _isRunning = true;
        _seconds = _initialSeconds;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _timer?.cancel();
            _seconds = _initialSeconds;

            Future.delayed(Duration(seconds: 10), () {
              setState(() {
                _isRunning = false;
              });
            });
          }
        });
      });
    }
  }

  String _durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _durationToString(Duration(seconds: _seconds)),
            style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black,
                  elevation: 5,
                  shape:CircleBorder (
                      side: BorderSide(color: Colors.black)


                  ),
                ),
                onPressed: _isRunning ? _toggleTimer : _toggleTimer,

                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    _isRunning ? 'Dur' : 'Başla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.black),
                    )
                ),
                onPressed: () {
                  setState(() {
                    _seconds = _initialSeconds;
                    _isRunning = false;
                  });
                },

                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Tekrar Başla',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),

              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}