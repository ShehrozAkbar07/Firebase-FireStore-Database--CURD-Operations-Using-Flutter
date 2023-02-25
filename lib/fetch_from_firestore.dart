import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// With Animated List

class FetchhData extends StatefulWidget {
  const FetchhData({super.key});

  @override
  State<FetchhData> createState() => _FetchhDataState();
}

class _FetchhDataState extends State<FetchhData> {
  final firestore = FirebaseFirestore.instance.collection('data').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder:
              (BuildContext Fcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.hasError) return Text('Some Error');

            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                    );
                  }),
            );
          },
        )
      ]),
    );
  }

  // Future<void> showMyDialog(String title, String id) async {
  //   // editController.text = title;
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Update'),
  //           content: Container(
  //             child: TextField(
  //               controller: editController,
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Cancel')),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   ref
  //                       .child(id)
  //                       .update({'title': editController.text.toLowerCase()})
  //                       .then((value) {})
  //                       .onError((error, stackTrace) {
  //                         print(error);
  //                       });
  //                 },
  //                 child: Text('Update')),
  //           ],
  //         );
  //       });
  // }
}
