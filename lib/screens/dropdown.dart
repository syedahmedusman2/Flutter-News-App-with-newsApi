import 'package:flutter/material.dart';
import 'package:newsapp/screens/homepage.dart';

class Language {
  final int id;
  final String name;
  final String languageCode;

  const Language(this.id, this.name, this.languageCode);


}


 const List<Language> getLanguages = <Language>[
        Language(1, 'Science', 'https://newsapi.org/v2/top-headlines?category=science&apiKey=f507c969eaee41ffb23d10668b679090'),
        Language(2, 'General', 'https://newsapi.org/v2/top-headlines?category=general&apiKey=f507c969eaee41ffb23d10668b679090'),
        Language(3, 'Sports', 'https://newsapi.org/v2/top-headlines?category=sports&apiKey=f507c969eaee41ffb23d10668b679090'),
         Language(4, 'Entertainment', 'https://newsapi.org/v2/top-headlines?category=entertainment&apiKey=f507c969eaee41ffb23d10668b679090'),
          Language(5, 'Health', 'https://newsapi.org/v2/top-headlines?category=health&apiKey=f507c969eaee41ffb23d10668b679090'),
           Language(6, 'Technology', 'https://newsapi.org/v2/top-headlines?category=technology&apiKey=f507c969eaee41ffb23d10668b679090'),
     ];

class Drp extends StatefulWidget {


  @override
  _DrpState createState() => _DrpState();
}

class _DrpState extends State<Drp> {
 
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: SizedBox(),
        icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                    ),
        items: getLanguages.map((Language lang) {
        return new DropdownMenuItem<String>(
                        value: lang.languageCode,
                        child: new Text(lang.name),
                      );
                    }).toList(),

        onChanged: (val) {
          setState(() {
            sortoption=val;
          });
                      print(sortoption);
                   },
      );
  }
}
