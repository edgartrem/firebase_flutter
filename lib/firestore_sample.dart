import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore sample"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Firestore.instance
                    .runTransaction((Transaction transaction) async {
                  CollectionReference reference =
                      Firestore.instance.collection('flutter_data');

                  await reference
                      .add({"title": "test", "editing": false, "score": 0});
                });
              })
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('flutter_data').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          print(snapshots.data);
          if (!snapshots.hasData) return CircularProgressIndicator();
          return FireStoreListView(documents: snapshots.data.documents);
        },
      ),
    );
  }
}

class FireStoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FireStoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String title = documents[index].data['title'].toString();
        int score = documents[index].data['score'];

        return ListTile(
          title: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.white)),
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: !documents[index].data['editing']
                      ? Text(title)
                      : TextFormField(
                          initialValue: title,
                          onFieldSubmitted: (String text) {
                            Firestore.instance.runTransaction(
                                (Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction
                                  .get(documents[index].reference);

                              await transaction
                                  .update(snapshot.reference, {"title": text});
                              await transaction.update(snapshot.reference,
                                  {"editing": !snapshot['editing']});
                            });
                          },
                        ),
                ),
                Text("$score"),
                Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);

                            await transaction.update(
                                snapshot.reference, {"score": score + 1});
                          });
                        }),
                    IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);

                            await transaction.update(
                                snapshot.reference, {"score": score - 1});
                          });
                        })
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance
                          .runTransaction((Transaction transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(documents[index].reference);

                        await transaction.delete(snapshot.reference);
                      });
                    })
              ],
            ),
          ),
          onTap: () => Firestore.instance
                  .runTransaction((Transaction transaction) async {
                DocumentSnapshot snapshot =
                    await transaction.get(documents[index].reference);

                await transaction.update(
                    snapshot.reference, {"editing": !snapshot['editing']});
              }),
        );
      },
    );
  }
}
