import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'fetch_from_firestore.dart';

class Firestore extends StatefulWidget {
  const Firestore({super.key});

  @override
  State<Firestore> createState() => _FirestoreState();
}

TextEditingController addtofirestore = TextEditingController();
final firestore = FirebaseFirestore.instance.collection('data');
bool loading = false;

class _FirestoreState extends State<Firestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text('Hello'),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(border: OutlineInputBorder()),
            controller: addtofirestore,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      String id =
                          DateTime.now().microsecondsSinceEpoch.toString();

                      firestore
                          .doc(id)
                          .set({
                            'title': addtofirestore.text.toString(),
                            'id': id,
                          })
                          .then((value) {})
                          .onError((error, stackTrace) {
                            print(error.toString());
                          });
                    },
                    child: Text('Add'))),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FetchhData()));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            ),
          )
        ],
      ),
    ));
  }
}
