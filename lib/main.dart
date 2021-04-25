import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:section7/page_view.dart';
import 'package:section7/splash_screen.dart';
import 'package:toast/toast.dart';
import 'package:flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs= await SharedPreferences.getInstance();
  bool decision = prefs.get('x');
  Widget _screen = (decision==false || decision==null )? PView(): MyHomePage();
    runApp(_screen);
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       themeMode: ThemeMode.system,
//       theme: ThemeData(primaryColor: Colors.blue, canvasColor: Colors.white),
//       darkTheme:
//       ThemeData(primaryColor: Colors.blue, canvasColor: Colors.black),
//       home: MyHomePage(),
//     );
//   }
// }
class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String str = 'Flutter Demo';
  final _x = GlobalKey<ScaffoldState>();
  List imagesList = [
    'assets/images/jumanji.jpg',
    'assets/images/mmm.jpg',
    'assets/images/gggg.jpg'
  ];
  int currentIndex = 0;
  String _selectedVal = "";
  String result = "no selected";
  Color resultColor = Colors.black;
  bool jS = false;
  bool cSharp = false;
  bool python = false;
  bool java = false;
  bool dart = false;

  String get text {
    String str = "you select:\n";
    if (jS == true) str += 'Java Script\n';
    if (python) str += 'Python\n';
    if (java) str += 'Java\n';
    if (dart) str += 'Dart\n';
    if (cSharp)
      str += 'C#\n';
    else
      str += 'no selection yet\n';
    return str;
  }

  bool _sValue = false;
  ThemeMode tm = ThemeMode.light;

  String _selectedLetter;
  List _lettersList = ["a", "b","c","d", "e", "f"];
  @override
  void initState() {
    super.initState();
    _selectedLetter = _lettersList[0];
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.green,
        canvasColor: Colors.black87,
      ),
      themeMode: tm,
      home: Scaffold(
        key: _x,
        appBar: AppBar(
          title: Text(str, style: TextStyle(color: Colors.black)),
        ),
        body:buildExpansionTile(),
      ),
    );
  }

  Padding buildExpansionTile() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ExpansionTile(
              title: Text('Login!',style:TextStyle(color: Colors.green),),
              trailing:Icon(Icons.arrow_forward_ios) ,
              backgroundColor: Colors.blueGrey,

              children: [
                Card(color:Colors.grey,child: ListTile(leading: Icon(Icons.person),title: Text('login if you have an account!'),)),
                Card(color:Colors.grey,child: ListTile(leading: Icon(Icons.power_settings_new),title: Text('login!'),)),
              ],
            ),
            SizedBox(height: 30,),
            ExpansionTile(
              title: Text('Sign Up!',style:TextStyle(color: Colors.green),),
              trailing:Icon(Icons.arrow_forward_ios) ,
              backgroundColor: Colors.blueGrey,
              children: [
                Card(color:Colors.grey,child: ListTile(leading: Icon(Icons.person_add),title: Text('login if you have an account!'),)),
                Card(color:Colors.grey,child: ListTile(leading: Icon(Icons.share),title: Text('share this'),)),
              ],
            ),
          ],
        ),
      );
  }

  Row buildDropDownButton(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text('select A letter! ',
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        DropdownButton(
          items: _lettersList.map(
                (item) {
              return DropdownMenuItem(
                value: item,
                child: new Text(item),
              );
            },
          ).toList(),
          icon: Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.red,
          dropdownColor: Colors.grey,
          onChanged: (val) {
            setState(() {
              _selectedLetter = val;
              var ad=new AlertDialog(
                title: Text('selected'),
                content: Text(_selectedLetter,
                  style: TextStyle(color: Colors.pink,fontSize:25 ),),
              );
              showDialog(context: context,child: ad);
            });

          },
          value: _selectedLetter,
          hint: Text(
            'selected',
          ),
        ),
      ]);
  }

  Container buildThemeModeSwitch() {
    return Container(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("light",
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          ),
          Switch(
            value: _sValue,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.blueGrey,
            onChanged: (val) {
              setState(() {
                _sValue = val;
                tm = _sValue == false ? ThemeMode.light : ThemeMode.dark;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("dark",
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void buildCheckBoxResultDialog(BuildContext context) {
    var ad = new AlertDialog(
      title: Text('result'),
      content: Column(
        children: [
          Divider(),
          Text(text),
        ],
      ),
    );
    showDialog(context: context, child: ad);
  }

  Row buildCheckBox(lang, String title) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        Checkbox(
          value: lang,
          onChanged: (val) {
            setState(() {
              if (title == 'java')
                java = val;
              else if (title == 'JavaScript')
                jS = val;
              else if (title == 'python')
                python = val;
              else if (title == 'dart')
                dart = val;
              else if (title == 'c#') cSharp = val;
            });
          },
          activeColor: Colors.pink,
          checkColor: Colors.yellow,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          title,
        ),
      ],
    );
  }

  CheckboxListTile buildCheckboxListTile(lang, String title) {
    return CheckboxListTile(
      value: lang,
      title: Text(title),
      onChanged: (val) {
        setState(() {
          if (title == 'java')
            java = val;
          else if (title == 'JavaScript')
            jS = val;
          else if (title == 'python')
            python = val;
          else if (title == 'dart')
            dart = val;
          else if (title == 'c#') cSharp = val;
        });
      },
      activeColor: Colors.pink,
      checkColor: Colors.amber,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Row buildRadio(String No) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        Radio(
          value: No,
          groupValue: _selectedVal,
          activeColor: Colors.lightGreen,
          onChanged: (valu) {
            setState(() {
              _selectedVal = valu;
              result = _selectedVal == '4' ? 'right answer' : 'wrong answer';
              resultColor = _selectedVal == '4' ? Colors.green : Colors.red;
            });
            myDialog();
          },
        ),
        SizedBox(
          width: 12,
        ),
        Text('8'),
      ],
    );
  }

  void myDialog() {
    var ad = new AlertDialog(
      title:
          Text('Result', style: TextStyle(color: Colors.black, fontSize: 20)),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Divider(),
            Text(
              _selectedVal,
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$result',
              style: TextStyle(color: resultColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: ad);
  }

  RadioListTile<String> buildRadioListTile(String number) {
    return RadioListTile(
      value: number,
      groupValue: _selectedVal,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        setState(() {
          _selectedVal = value;
          result = _selectedVal == '4' ? 'right answer' : 'wrong answer';
          resultColor = _selectedVal == '4' ? Colors.green : Colors.red;
        });
        myDialog();
      },
      // selected: number==_selectedVal?true:false,
      title: Text(number),
      activeColor: Colors.lightGreen,
      subtitle: Text('No' + number),
    );
  }

  ListView buildCarouselSlider() {
    return ListView(
      children: [
        Text('sliderView: page $currentIndex'),
        SizedBox(
          height: 8,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 180,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              }),
          items: imagesList.map((imageUrl) {
            return Container(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
            );
          }).toList(),
        ),
        SizedBox(
          height: 8,
        ),
        Text('sliderView: page $currentIndex'),
        SizedBox(
          height: 8,
        ),
        CarouselSlider.builder(
          itemCount: imagesList.length,
          itemBuilder: (_, index) {
            return Container(
              child: Image.asset(
                imagesList[index],
                fit: BoxFit.fill,
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
            );
          },
          options: CarouselOptions(
              height: 180,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
          ],
        ),
      ],
    );
  }

  Container buildContainer(int index) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? Colors.amber : Colors.grey,
      ),
    );
  }

  CustomScrollView buildSilverAppbarView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          expandedHeight: 150,
          // collapsedHeight: 150,
          // toolbarHeight: 50,
          title: Text("widget.title", style: TextStyle(color: Colors.white)),
          leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Row(
              children: [
                Expanded(child: Image.asset('assets/iTunesArtwork.png')),
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.amber,
                  onPressed: () {},
                )),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pink, Colors.deepPurple],
            )),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            //body
          ]),
        ),
      ],
    );
  }

  Flushbar buildFlushBar(BuildContext context) {
    return Flushbar(
      title: 'title',
      messageText: Text(
        'this is message',
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
      backgroundColor: Colors.amber,
      icon: Icon(Icons.category),
      mainButton: FlatButton(
        child: Text('close'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      duration: Duration(seconds: 8),
      flushbarPosition: FlushbarPosition.TOP,
    );
  }

  void buildSnackBar() {
    final sBar = SnackBar(
      content: Text('you deleted appbar title'),
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      duration: Duration(seconds: 8),
      action: SnackBarAction(
        label: 'undo!',
        textColor: Colors.black,
        onPressed: null,
      ),
    );
    _x.currentState.showSnackBar(sBar);
  }

  void buildAlertDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      title: Text('alert title'),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Divider(
              color: Colors.blueGrey,
              height: 7,
            ),
            Text('are you sure of this action'),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.red,
                child: Text(
                  'close!',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        child: alert,
        barrierColor: Colors.red.withOpacity(0.4),
        barrierDismissible: false);
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Pink',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        TextSpan(
          text: '/',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextSpan(
          text: 'yellow',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
      ]),
    );
  }

  void buildToast(BuildContext context) => Toast.show('pink or yellow', context,
      duration: Toast.LENGTH_LONG,
      textColor: Colors.red,
      backgroundColor: Colors.amber,
      backgroundRadius: 5,
      gravity: Toast.CENTER);
}
