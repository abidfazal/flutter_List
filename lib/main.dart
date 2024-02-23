import 'package:flutter/material.dart';
import 'package:listing/data.dart';

void main() {
  
  runApp( const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Home page'),centerTitle: true,backgroundColor: const Color.fromARGB(255, 121, 208, 124),),
     body: Center(
       child: ListTile(
        title: ElevatedButton(onPressed: (){
          Navigator.of(context).push(_route('list'));
        }, child: Text('List Page')),
        trailing:
         ElevatedButton(onPressed: (){
          Navigator.of(context).push(_route('builder'));
        }, child: Text('Layout Builder')) ,
       ) 
     ),
    );
  }
}

Route _route(type){
  return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(title: 'Demo List',
   type: type),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
     const begin = Offset(0.4, 0.8);
     const end = Offset.zero;
     final tween   = Tween(begin: begin,end: end);
     final animate = animation.drive(tween);
     return SlideTransition(position: animate,child: child,);
   },);
}

class MyHomePage extends StatefulWidget {
  final String title,type;
  const MyHomePage({super.key,required this.title,required this.type});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ListItems> items;
  @override
  void initState() {
   items = List<ListItems>.generate(100, (i) => i % 6 == 0 ? Heading(heading: 'Heading $i'):
  Message(sender: 'Sender $i', body: 'Message body $i')  );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 172, 85, 187),
     ),
     body: widget.type == 'list'?
     ListItem(items: items )
     : Layouting()
      );
    
  }
}

class ListItem extends StatelessWidget {
  final List<ListItems> items;
  const ListItem({super.key,required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
          ),
        );
      },);
  }
}

class Layouting extends StatelessWidget {
  const Layouting({super.key});

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      
      builder: (context, constraints) {
        return SingleChildScrollView(

          child: ConstrainedBox(constraints: BoxConstraints(
            minWidth: constraints.maxWidth
          ),
          child: Column(
            children: List.generate(100, (i) {
              return WidgetItem(item: 'index $i');
            }),
          ),),
        );
      },);
  }
}

class WidgetItem extends StatelessWidget {
  final String item;
  const WidgetItem({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
    child: SizedBox(
      height: 100,
      child: Center(child: Text(item,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
    ),
    );
  }
}

