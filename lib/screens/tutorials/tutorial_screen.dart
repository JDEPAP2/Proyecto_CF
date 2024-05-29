import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dado/components/modals/info_modal.dart';
import 'package:multi_dado/providers/app_color_provider.dart';
import 'package:multi_dado/providers/bluetooth_provider.dart';
import 'package:multi_dado/screens/class/class_screen.dart';
import 'package:multi_dado/utils/app_color.dart';
import 'package:multi_dado/utils/files.dart';
import 'package:multi_dado/utils/modal.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:shop_app/providers/providers.dart';
// import 'package:shop_app/components/init_app_bar.dart';
// import 'package:shop_app/utils/app_color.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  static String routeName = "tutorial/";

  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends ConsumerState<TutorialScreen> {
    late Map<String,dynamic> data;

    @override
  void initState() {
    Multiclass.getData().then((value) => data = value);
    super.initState();
  }
    @override
  void dispose() {
    // Release all sources and dispose the player.
    super.dispose();
  }

  List<Widget> getWidgets(BuildContext context, start, finish){
    final res = <Widget>[];
    for (var i = start; i < finish; i++) {
      res.add(InkWell(
        onTap: ()=> ModalUtil.handleModal(InfoModal(color:  Multiclass.getColor(i), name:  Multiclass.getName(i),data: data,), context),
        child: Container(
        width: 150,
        margin: const EdgeInsets.only(right:5,left: 5, bottom: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: Multiclass.getGradient(i)
        ),
        child: Center(
          child: Text(Multiclass.getName(i), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23,), textAlign: TextAlign.center),
        )
        ),
      ));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                child: Column(
                  children: [
                    Text("Sistema Multimedia", style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 30)),
                    SizedBox(height: 20,),
                    ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.white, Colors.white.withOpacity(0.05)],
                        stops: [0.7, 1],
                        begin: Alignment.topCenter,
                        end:Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child:Container(
                      height: 150,
                      child: ListView(
                        children: [
                          Text("Un sistema que permite  la creación de valor para las partes interesadas, a través del despliegue de una experiencia multimedia interactiva, concebido bajo un enfoque del diseño sensible al valor, que atiende a los intereses, necesidades y expectativas de sus usuarios, influyendo en sus percepciones sensoriales, a lo largo de una historia que se representa a través de diferentes medios digitales (Peláez, Solano y Granollers, 2021).\n\n",
                          style: TextStyle(color: Color.fromARGB(255, 136, 136, 136),fontStyle: FontStyle.italic))
                        ],
                      ))),
                    ],
                      )
                  ),
            ],
          ),
        ),
        const SizedBox(height: 50),  
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child:Text("Partes", style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 30))),
        SizedBox(height: 10),
        Center(
          child:Container(
            padding: EdgeInsets.only(right:15,left: 15, bottom: 10),
            height: 110,
            child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: getWidgets(context,0,2),
        ))),
        Center(
          child: Container(
            padding: EdgeInsets.only(right:15,left: 15, bottom: 10),
            height: 110,
            child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: getWidgets(context,2,4),
        )),)
      ]));
  }
}
