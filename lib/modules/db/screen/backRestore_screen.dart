import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/home/models/config.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:mandaos/widgets/ui/btn_default.dart';
import 'package:mandaos/widgets/ui/message_ui.dart';

class BackRestoreScreen extends StatefulWidget {
  // const ConfigScreen({Key? key}) : super(key: key);

  @override
  _BackRestoreScreen createState() => _BackRestoreScreen();
}

class _BackRestoreScreen extends State<BackRestoreScreen> {
  //TextEditingController _filter = new TextEditingController();

  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: SafeArea(
          maintainBottomViewPadding: false,
          child: Column(
            children: [
              const HeaderM(title: 'Copia de Seguridad', ico: Icons.backup),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BtnDefault(text: 'Crear respaldo', bgColor: kotherColor,icon: Icons.download_rounded,functionCallback: _CreateBackup,),
                    // BtnDefault(text: 'Crear respaldo', bgColor: kotherColor,icon: Icons.backup_outlined,)
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.builder(
                        itemCount:list.length ,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {

                              replaceDB(list[index]).then((value) {

                                if(value)
                                  Message(list[index], context);
    }
                              );

                            },
                            title: Text(list[index],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor.withOpacity(0.8))),
                            trailing: Icon(Icons.arrow_upward),
                          );
                        },
                      )))
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    importDB().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void _CreateBackup() {
  exportDB().then((result) {
    print(result);
  });
}
