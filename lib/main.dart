import 'package:flutter/material.dart';
import 'package:flutter_mumble_app/mumble_add.dart';

void main() {
  runApp(MumbleApp());
}

class MumbleApp extends StatelessWidget {
  const MumbleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      title: 'つぶやきノート',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MumbleListPage(),
    );
  }
}


class MumbleListPage extends StatefulWidget {
  const MumbleListPage({Key? key}) : super(key: key);

  @override
  State<MumbleListPage> createState() => _MumbleListPageState();
}

class _MumbleListPageState extends State<MumbleListPage> {
  // つぶやきリストのデータ
  List<String> mumbleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('つぶやきノート'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: mumbleList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(3),
            child: Card(
              child: ListTile(
                title: Text(mumbleList[index]),
                trailing: IconButton(

                  onPressed: () {},
                    icon: Icon(Icons.favorite),
                    color: Colors.pink,
                )
              ),

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return MumbleAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              mumbleList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
