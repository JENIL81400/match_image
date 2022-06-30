import 'package:flutter/material.dart';
import 'package:match_image/data.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}
class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}
class _firstState extends State<first> {

  List visiblelist=List.filled(24, true);
  List tempvisiblelist=List.filled(24, true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      data.img.shuffle();
    });
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        visiblelist=List.filled(24, false);
      });
    });
  }
  int? p1,p2;
  bool click=true;
  String? s1,s2;
  int c=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Match_image",style: TextStyle(fontSize: 20,color: Colors.black),
        ),
      ),
      body: Padding(padding: const EdgeInsets.only(top: 100,left: 5,right: 5),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: data.img.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: click?() {
                    if(c==1)
                      {
                        setState(() {
                          visiblelist[index]=true;
                          p1=index;
                          s1=data.img[index];
                          c=2;
                        });
                      }
                    else if(c==2)
                      {
                        setState(() {
                          visiblelist[index]=true;
                          p2=index;
                          s2=data.img[index];
                          click=false;
                          c=1;
                        });
                      }
                    if(s1==s2)
                      {
                        print("match");
                        Future.delayed(Duration(seconds: 2)).then((value) {
                          setState(() {
                            visiblelist[p1!]=true;
                            visiblelist[p2!]=true;
                            click=true;
                          });
                        });
                      }
                    else
                      {
                        print(" no match");
                        Future.delayed(Duration(seconds: 2)).then((value) {
                          setState(() {
                            visiblelist[p1!]=false;
                            visiblelist[p2!]=false;
                            click=true;
                          });
                        });
                      }
                  }:null,
                  child: Visibility(
                    visible: visiblelist[index],
                    replacement: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(image: AssetImage(data.img[index]),fit: BoxFit.fill),
                       color: Colors.lightGreen,
                       border: Border.all(color: Colors.black),
                       borderRadius: BorderRadius.circular(10),
                     ),
                      // child: InkWell(
                      //   onTap: () {
                      //     showDialog(
                      //       context: context, barrierDismissible: false,
                      //       builder: (context) {
                      //         return AlertDialog(
                      //           title: Text("Alert"),
                      //           content: Text("are you sure want to exit "),
                      //           actions: [
                      //             TextButton(onPressed: () {
                      //               Navigator.push(context,
                      //                   MaterialPageRoute(builder: (context) {
                      //                     return first();
                      //                   },));
                      //             }, child: Text("Yes")),
                      //             TextButton(onPressed: () {
                      //               Navigator.pop(context);
                      //             }, child: Text("No")),
                      //           ],
                      //         );
                      //       },);
                      //   }
                      // ),
                    ),
                  ),
                );
              },
          ),
        ),
      );
  }
}
