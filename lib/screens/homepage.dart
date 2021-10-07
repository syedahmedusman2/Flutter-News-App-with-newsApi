import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/api/news_api.dart';
import 'package:newsapp/controller/main_controller.dart';
import 'package:newsapp/screens/Reading_news.dart';
import 'package:newsapp/screens/dropdown.dart';
import 'package:newsapp/screens/favorite.dart';
import 'package:newsapp/screens/login-signup/signup.dart';
import 'package:path_provider/path_provider.dart';
dynamic sortoption = 'https://newsapi.org/v2/top-headlines?category=sports&apiKey=f507c969eaee41ffb23d10668b679090';
class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<NewsApiModel>? newsList;


  bool isLoading = true;
  bool favorite = false;
  var sort;
  bool fav = false;
  FirebaseAuth auth = FirebaseAuth.instance;
 
  checkfav() {
    if (fav) {
      fav = false;
    } else if (fav == false) {
      fav = true;
    }

    print(fav);
  }
  var name;
      getfromfire()async{
   FirebaseAuth auth = FirebaseAuth.instance;
  //  var document = await FirebaseFirestore.instance.collection('userdata').doc(auth.currentUser!.uid);
  //  document.get().then((value) => print(document))
   
  //  . => then(function(document) {
  //   print(document("name"));
// } );

    FirebaseFirestore.instance
    .collection(auth.currentUser!.uid).get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["title"]);
            name = doc['title'];
        });
    });
  }
  late Box box;

 
    
  
    
  
  var logs;
dynamic sortoption = 'https://newsapi.org/v2/top-headlines?category=sports&apiKey=f507c969eaee41ffb23d10668b679090';
  @override
  void initState(){
    super.initState();
    openBox2();
    getfromfire();
    control.getSwitchState();
    logs =  control.getSwitchState();
    getNews('https://newsapi.org/v2/top-headlines?country=us&country=pk&apiKey=f507c969eaee41ffb23d10668b679090')
    .then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });

    // Maincontroller controller = Maincontroller();
    
    
    
    
  }
  Logics control = Logics();
   Future openBox2() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('name');
    return;
  }
  putData( title, image, content)async{
    await box.put('name', [title, image, content]);

  }
  getData()async{
    dynamic data= box.get('name');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(leading: GestureDetector(onTap: (){
        //   auth.signOut();
        // },child: Icon(Icons.logout)),),
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.blueAccent),title: Text("News App", style: TextStyle(color: Colors.blueAccent),),backgroundColor: Colors.white,elevation: 5,actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton .icon(
              icon: const Icon(Icons.favorite),
              label: Text('Favorite News'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>favs()));
              },
              
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Drp(),
          )
        ],
        
      ),
      drawer: Drawer(
        
        
        child: Column(
          children: [
            DrawerHeader(child: ListTile(
              leading: Text("Ahmed"),
              trailing: Icon(Icons.person),
            )),
            SizedBox(height: 10,),
             IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () {
              auth.signOut();
              
              control.saveSwitchState(false);
              
            },
            
          ),
          ],
        ),
        
      ),
        
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ElevatedButton(onPressed: (){print(sortoption);}, child: Text("child")),
              
              // Container(
              //   height: MediaQuery.of(context).size.height / 12,
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.menu,
              //         // color: Colors.white,
              //       ),
              //       Drp(),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width / 4,
              //       ),
              //       Text(
              //         "News App",
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.w500,
              //           //color: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.height / 20,
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: newsList!.length,
                          itemBuilder: (context, index) {
                            return listItems(
                                MediaQuery.of(context).size, newsList![index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(Size size, NewsApiModel model) {
    // Maincontroller controller = Maincontroller();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReadingNews(
              model: model,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          width: size.width / 1.15,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: size.height / 4,
                  width: size.width / 1.05,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  child: model.imageUrl != ""
                      ? Image.network(
                          model.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Text("Cant Load image"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width / 1.1,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Text(
                          model.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    IconButton( onPressed: () {
                   
                    if(
                      
                      auth.currentUser!= null
                      // control.getSwitchState()
                      ){
                    
                    print("Running");
                    
                    
                    CollectionReference users = FirebaseFirestore.instance.collection(auth.currentUser!.uid);
                    users.add({
                      'title':model.title,
                      'content':model.content,
                      'image':model.imageUrl,
                      'desc': model.description
                    });
                    
                    print("ran");
                    }else {Navigator.of(context).
                    push(MaterialPageRoute(builder: (_)=>Signup()));
                    }
                    
                  }, icon: Icon(Icons.favorite,color: Colors.blue,))

                    // GestureDetector(
                    //   onTap: (){
                    //     setState(() {
                    //       if(favorite){
                    //         favorite = false;
                    //       }else if(favorite==false){
                    //         favorite=true;
          
                    //       }
          
                    //     });
                    //     print(favorite);
                    //   },
                    //   child: Icon(Icons.favorite, color: favorite ? Colors.red: Colors.black ,))
                  ],
                ),
                Container(
                  width: size.width / 1.1,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                    child: Text(
                      model.description,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                   
                //     if(auth.currentUser!= null){
                //     //  FirebaseFirestore.instance.collection('favs').doc(auth.currentUser!.uid).set({
                //     //    "image": model.imageUrl,
                //     //    "title": model.title,
                //     //    "Content": model.content
            
                       
                //     //  });
                //     print("Running");
                //     // box.put('name', [model.title, model.content, model.imageUrl]);
                //     CollectionReference users = FirebaseFirestore.instance.collection(auth.currentUser!.uid);
                //     users.add({
                //       'title':model.title,
                //       'content':model.content,
                //       'image':model.imageUrl,
                //       'desc': model.description
                //     });
                    
                //     print("ran");
                //     }else {Navigator.of(context).
                //     push(MaterialPageRoute(builder: (_)=>Signup()));
                //     }
                    
                //   },
                //   child: Text("Add to favourite"),
                 
                // ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  // return Container(
  //   child: Column(
  //     children: [
  //       isloading ? Container(
  //         child: CircularProgressIndicator(),

  //       ): Expanded(child: Container(
  //         child: ListView.builder(itemCount: 10,itemBuilder: (context,index){
  //           return
  //         }),
  //       ))
  //     ],
  //   ),
  // );
}

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  var _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: _dropDownValue == null
          ? Text('Dropdown')
          : Text(
              _dropDownValue,
              style: TextStyle(color: Colors.blue),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: ['One', 'Two', 'Three'].map(
        (val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownValue = val;
          },
        );
      },
    );
  }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:newsapp/key/key.dart';

// class Api extends StatefulWidget {
//   const Api({ Key? key }) : super(key: key);

//   @override
//   _ApiState createState() => _ApiState();
// }

// class _ApiState extends State<Api> {

//   @override
//   void initState() {
//     fetchNewsdata();
//     super.initState();

//   }

//    List newsData = [];
//   fetchNewsdata()async{

//     http.Response response = await http.get(Uri.https('api.mediastack.com', 'v1/news?access_key=$key&languages=en'));
//     setState(() {
//       newsData = json.decode(response.body);
//   });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Container(child: Text("HELLO WORLD"),),
//           Column(
//         children: [
//           Container(child: Text("EJ"),),
//           newsData == null? Center(
//             child: CircularProgressIndicator(),
//           )
//           :ListView.builder(itemCount: 5,itemBuilder: (context, index){
//             return Card(child: Container(child: Column(
//               children: [
//                 Text("HELLO")
//               ],

//             ),),);

//           }),
//         ],
//       )
//         ],
//       ),

//     );
//   }
// }

// class Api extends StatefulWidget {
//   @override
//   _ApiState createState() => _ApiState();
// }

// // http://api.mediastack.com/v1/news?access_key=93818da741d5cc3e0ffcb7b95fbd451f&languages=en
// class _ApiState extends State<Api> {
//   late Future<dynamic> futureNews;

//   @override
//   void initState() {
//     fetchNewsdata();
//     super.initState();
//     futureNews = getUser();
//   }

//   getUser() async {
//     var response = await http.get(
//         Uri.http('api.mediastack.com', 'v1/news?access_key=$key&languages=en'));
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return News.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }

//     // var jsonData = jsonDecode(response.body);
//     // List<News> news = [];

//     // for (var i in jsonData){
//     //   News user = News(title:i['title'], author:i['author'], description: i['description'], image: i['image'], url: i['url']);
//     //   news.add(user);
//     // }
//     // print(news);
//     // return news;
//   }
//   List newsData = [];
//   // fetchNewsdata()async{

//   //   http.Response response = await http.get(Uri.https('api.mediastack.com', 'v1/news?access_key=$key&languages=en'));
//   //   setState(() {
//   //     newsData = json.decode(response.body);
//   // });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Container(child: Text("EJ"),),
//           newsData == null? Center(
//             child: CircularProgressIndicator(),
//           )
//           :ListView.builder(itemBuilder: (context, index){
//             return Card(child: Container(child: Column(
//               children: [
//                 Text("HELLO")
//               ],

//             ),),);

//           }),
//         ],
//       )
//     );

//       //  FutureBuilder(
//       //   future: getUser(),
//       //   builder: (BuildContext context, AsyncSnapshot snap) {
//       //     if (snap.data == null) {
//       //       return Container(child: Text("Nothing in the Api"));
//       //     } else
//       //       return ListView.builder(
//       //           itemCount: snap.data.length,
//       //           itemBuilder: (context, i) {
//       //             return Card(
//       //               child: Column(
//       //                 children: [
//       //                   Image(
//       //                       height: 200,
//       //                       width: 300,
//       //                       image: NetworkImage(snap.data[i].image)),
//       //                   Title(color: Colors.black, child: snap.data[i].title)
//       //                 ],
//       //               ),
//       //             );
//       //             // return ListTile(

//       //             //   title: Center(child: Text(snap.data[i].user)),
//       //             //   subtitle: Text(snap.data[i].username),
//       //             //   trailing: Text(snap.data[i].email),

//       //             // );
//       //           });
//       //   },
//       // ),

//   }
// }

}

class NewsApiModel {
  var title;
  var imageUrl;
  var description;
  var content;

  NewsApiModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });
  factory NewsApiModel.fromJson(Map<String, dynamic> json) {
    return NewsApiModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['urlToImage'],
      content: json['content'],
    );
  }
}
