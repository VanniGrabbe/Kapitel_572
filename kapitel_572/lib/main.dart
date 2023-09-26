import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kapitel_572/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  Future<List<UserModel>> fetchUsers() async{
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'users');
    http.Response response = await http.get(url);
    debugPrint(response.body);
    
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse.runtimeType == List){
      return (jsonResponse as List)
          .map((val) => UserModel.fromJson(val))
          .toList();
    }else{
      return [jsonResponse];
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HTTP-Client'),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: fetchUsers(), 
              builder:(context, snapshot) {
              if (snapshot.hasData){
                List<UserModel> userModel = snapshot.data ?? [];
                return Expanded(
                  child: ListView(
                    children: 
                      userModel.map(
                        (e) => Text(e.name),
                        )
                        
                    
                    .toList(),
                  ),
                );
              }
              return Text('Liste wird geladen');
              
            },),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  
                });
              }, child: Text('Zeige Liste an')),
              
          ],
          
        ),

        
      ),
      
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
