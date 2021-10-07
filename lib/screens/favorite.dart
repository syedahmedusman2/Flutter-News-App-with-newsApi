import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class favs extends StatefulWidget {
  const favs({ Key? key }) : super(key: key);

  @override
  _favsState createState() => _favsState();
}
List title = [];
List content = [];
List image = [];
List desc = [];
class _favsState extends State<favs> {
  getfromfire()async{
   FirebaseAuth auth = FirebaseAuth.instance;
  

    FirebaseFirestore.instance
    .collection(auth.currentUser!.uid).get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["title"]);
            title.add(doc["title"]);
             content.add(doc["content"]);
            image.add(doc["image"]);
            desc.add(doc['desc']);
            // name = doc['title'];
        });
    });
  }
  @override
  void initState(){
    super.initState();
    getfromfire();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.blueAccent),backgroundColor: Colors.white,title: Text('Favorites', style: TextStyle(color: Colors.blueAccent),),),
      body: Column(
        
        children: [Expanded(child: 
        ListView.builder(itemCount:title.length,itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Image(image: NetworkImage(image[index],), height: 200, width: MediaQuery.of(context).size.width,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                      child: Text(title[index], style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16
                      ),),
                    ),
                    Text(desc[index])
            
                    
                  ],
                ),
              ),
            ),
          );
        }))],
      ),
      
    );
  }
}