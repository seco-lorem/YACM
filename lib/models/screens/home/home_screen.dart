import 'package:flutter/material.dart';
import 'components/app_bar.dart';
class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopBar(size: size),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: LeftAppBar(),
                ),
                Container( //POST
                  width: (size.width - 400),
                  height: size.height-150,
                  alignment: Alignment.bottomCenter,
                  color: Colors.blue,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    Center(child: Text('POST', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
                    ],),
                  )
                ),
                Container(
                  width: 200,
                  height: size.height-150,
                  alignment: Alignment.topCenter,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text('Suggested Clubs', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                        Text('Club1', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                        Text('Club2', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                        Text('Club3', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      )
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 110,
          child: Center(
            child: Text(
              "Yacm".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
        SizedBox(
          width: size.width - 400,
          height: 110,
          child: Center(child: TextField()),
        ),
        SizedBox(
          width: 100,
          height: 110,
          child: Center(
            child: TextButton(
              child: const Text('Notifications', style: TextStyle(color: Colors.black, fontSize: 14),), 
              onPressed: (){},
            )
          ),
        ),
        SizedBox(
          width: 100,
          height: 110,
          child: Center(
            child: TextButton(
              child: const Text(
                'Log Out', 
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 14, 
                  fontWeight: FontWeight.bold
                ),
              ), 
              onPressed: (){},
            )
          ),
        )
      ]
    );
  }
}