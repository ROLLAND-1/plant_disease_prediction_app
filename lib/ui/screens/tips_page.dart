import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/plants.dart';
import 'package:flutter_onboarding/ui/screens/widgets/plant_widget.dart';
import 'package:url_launcher/url_launcher.dart';


class TipsPage extends StatefulWidget {
  TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  
  var titlelist = [
    "corn_Healthy",
    "corn_Gray_Leaf_Spot",
    "corn_Common_Rust",
    "corn_Blight",
    "Potato___Early_blight",
    "Potato___healthy",
    "Potato___Late_blight",
    "Pepper__bell___Bacterial_spot",
    "Pepper__bell___healthy",
  ]; 
  
  List<List<String>> descList = [
    [" Tap on for tips/remedies ","https://cropwatch.unl.edu/plantdisease/corn"] ,
    [" Tap on for tips/remedies","https://www.google.com/search?q=corn_Gray_Leaf_Spot"],
    [" Tap on for tips/remedies","https://www.google.com/search?q=corn_Common_Rust"],
    [" Tap on for tips/remedies","https://www.google.com/search?q=corn_Blight"],
    [" Tap on for tips/remedies",'https://www.google.com/search?q=Potato___Early_blight'],
    [" Tap on for tips/remedies",'https://www.google.com/search?q=Potato___healthy'],
    [" Tap on for tips/remedies",'https://www.google.com/search?q=Potato___Late_blight'],
    [" Tap on for tips/remedies",'https://www.google.com/search?q=Pepper__bell___Bacterial_spot'],
    [" Tap on for tips/remedies",'https://www.google.com/search?q=Pepper__bell___healthy'],
   
  ];

  var imglist = [
    "assets/images/download 1.jpg",
    "assets/images/download2.jpg",
    "assets/images/download3.jpg",
    "assets/images/download4.jpg",
    "assets/images/download5.jpg",
    "assets/images/download6.jpg",
    "assets/images/download7.jpg",
    "assets/images/download18.jpg",
    "assets/images/download19.jpg",

  ];
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
         title: Text(
          "Tips on plant health and disease",
          style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
          ),
          elevation: 5,
          backgroundColor: Color.fromARGB(255, 250, 248, 248),
      ),
      body: ListView.builder(
        itemCount: imglist.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              showDialogFunc(context, imglist[index], titlelist[index], descList[index][0],descList[index][1]);
            },
            child: Card(
               child:
               Row(
                children: <Widget>[
                  Container(
                    width:100,
                    height: 150,
                    child: Image.asset(imglist[index]),
                  ),
                  Padding (
                    padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        child: Text(
                          titlelist[index],
                          style: TextStyle(
                            fontSize: 15,
                             overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: width,
                        child: Text(
                          descList[index][0],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    ],
                  ),)
                ],
                )
            ),
          );
        }
      )
    );
  }
}
showDialogFunc(context, img, title, desc,link){
  return showDialog(
    context: context, 
    builder: (contex){
      return Center(
        child: Material(
          type:  MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                  img,
                  width: 200,
                  height: 200,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 10,),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 15,
                    color:  Colors.green[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: (){
                    launchUrl(Uri.parse(link));
                  },
                  child: Text(
                    link,
                    style: TextStyle(
                      fontSize: 15,
                      color:  Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  
  );
}

