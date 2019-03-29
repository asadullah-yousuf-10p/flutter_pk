import 'package:cloud_firestore/cloud_firestore.dart';

class Sponsor {
  final int type;
  final String imageUrl;
  final DocumentReference reference;

  Sponsor({
    this.type,
    this.reference,
    this.imageUrl,
  });

  Sponsor.fromMap(Map<String, dynamic> map, {this.reference})
      : type = map['type'],
        imageUrl = map['imageUrl'];

  Map<String, dynamic> toJson() => {
        "type": type,
        "imageUrl": imageUrl,
      };

  Sponsor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
