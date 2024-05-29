import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dado/providers/app_color_provider.dart';
import 'package:multi_dado/providers/bluetooth_provider.dart';
import 'package:multi_dado/providers/class_provider.dart';
import 'package:multi_dado/screens/responses/response_screen.dart';
import 'package:multi_dado/utils/app_color.dart';
import 'package:multi_dado/utils/files.dart';
// import 'package:shop_app/providers/providers.dart';
// import 'package:shop_app/components/init_app_bar.dart';
// import 'package:shop_app/utils/app_color.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  static String routeName = "class/";

  @override
  ClassScreenState createState() => ClassScreenState();
}

class ClassScreenState extends ConsumerState<ClassScreen> {

  int _selectedOption = 5;
  bool isChanging = false;
  final random = Random();
  int intRan = 0;

  Map<String,dynamic> data = Map.from({});

  @override
  void initState() {
    intRan = random.nextInt(2);
    Multiclass.getData().then((value){
      data = value;
      setState(() {
      });
    });
    super.initState();
  }

  String getName(int v){
      return v < 5?Multiclass.getName(v):"Presiona\nEscanear";
    }

  IconData getIcon(int v){
    switch(v){
      case 1:
        return Icons.piano;
      case 2:
        return Icons.star;
      case 3:
        return Icons.speaker;
      case 4:
        return Icons.audiotrack;
      case 5:
        return Icons.disc_full;
      default:
        return Icons.help_rounded;
    }
  }

  List<Widget> getQuestion(int v){
    
    final letters = ["A. ","B. ","C. ","D. "];
    List<Widget> res =[];
    if(v < 5){
      String name = Multiclass.getName(v).toLowerCase();
      return [(Text(data["parts"][name]["questions"][intRan]["nun"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),)),
                SizedBox(height: 15),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, i) => IntrinsicWidth(
                      child: Row(
                        children: [
                          Radio(
                            fillColor: MaterialStatePropertyAll(Colors.white54),
                            overlayColor: MaterialStatePropertyAll(Colors.white54),
                            activeColor: Colors.white,
                            value: i, 
                            groupValue: _selectedOption, 
                            onChanged: (i){
                              setState(() {
                                _selectedOption = i??0;
                              });

                              int trueInt = data["parts"][name]["questions"][intRan]["answer"];
                              if(i == trueInt){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResponseScreen(value: true)));
                              }else{
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                                ResponseScreen(value: false, trueAnswer: data["parts"][name]["questions"][intRan]["options"][trueInt])));
                              }}
                            ),
                          Container(
                            width: 250,
                            child: Text(letters[i] + data["parts"][name]["questions"][intRan]["options"][i],
                          style: TextStyle(fontSize: 18, color: Colors.white),),
                          )]
                      ),
                    ), 
                    separatorBuilder: (context, index) => SizedBox.shrink(), 
                    itemCount: 4)];
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final classProv = ref.watch(classProvider);
    final isLoading = ref.watch(bluetoothStateProvider);
    AppColor appColor = ref.watch(appColorProvider);
    return Scaffold(
      // backgroundColor: appColor.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: appColor.gradient
        ),
        child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(classProv.when(data: (d) => getName(d), error: (error, stackTrace) => "Error", loading: ()=>"Cargando"),
            style: TextStyle(color: appColor.getContrastColor(), fontSize: 30, fontWeight: FontWeight.bold))
          ),
          data.isNotEmpty?Container(
            padding: EdgeInsets.all(30),
            height: classProv.when(data: (d) => d>4?200:500, error: (error, stackTrace) => 200, loading: ()=>200),
            child: ListView(
              shrinkWrap: true,
            children: classProv.when(data: (d) => getQuestion(d), error: (error, stackTrace) => [], loading: ()=>[]),),
          ):SizedBox.shrink(),
          SizedBox(height: 100), 
          !isLoading?Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appColor.getContrastColor()
                ),
                child: Text("Escanear", style: TextStyle(color: appColor.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              onTap: (){
                setState(() {
                  _selectedOption = 5;
                  intRan = random.nextInt(2);
                });
                ref.read(bluetoothDeviceProvider.notifier).writeCharacteristcs();
                setState(() {
                  isChanging = true;
                });
              },
            ),
          ):Center(
            child: classProv.when(data: (data) => Icon(getIcon(data),
            color: appColor.getContrastColor(),
            size: 120),error: (error, stackTrace) => SizedBox.shrink(),
            loading: () => CircularProgressIndicator(color: appColor.getContrastColor())),
          ),
          SizedBox(height: 20),
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appColor.getContrastColor()
                ),
                child: Text("Volver", style: TextStyle(color: appColor.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              onTap: (){
                ref.read(bluetoothDeviceProvider.notifier).stopRead();
                Navigator.of(context).maybePop();
              },
            ),
          )
        ],
      ),
      ),
      ),
    );
  }
}
