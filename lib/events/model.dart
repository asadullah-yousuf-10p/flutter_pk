import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/registration/model.dart';

class EventBloc {
  Stream<List<EventDetails>> get events => Firestore.instance
      .collection(FireStoreKeys.eventCollection)
      .where('date',
          isGreaterThanOrEqualTo: DateTime.now().add(Duration(days: -1)))
      .orderBy('date')
      .snapshots()
      .asyncMap<List<EventDetails>>((snapshot) => snapshot.documents
          .map((doc) => EventDetails.fromSnapshot(doc))
          .toList());
}

class SponsorBloc {
  Stream<List<Sponsor>> getSponsors(String eventId) => Firestore.instance
      .collection(
          '${FireStoreKeys.eventCollection}/$eventId/${FireStoreKeys.sponsorCollection}')
      .snapshots()
      .asyncMap<List<Sponsor>>((snapshot) =>
          snapshot.documents.map((doc) => Sponsor.fromSnapshot(doc)).toList());
}

class Sponsor {
  final String id;
  final String imageUrl;
  final String name;

  Sponsor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.reference.documentID);
  Sponsor.fromMap(Map map, {this.id})
      : imageUrl = map['image_url'],
        name = map['name'];
}

class EventDetails {
  final DateTime date;
  final String eventTitle;
  final Venue venue;
  final String id;
  final String bannerUrl;
  final String registrationStatus;
  final Map registrations;
  final String description;
  final List<String> volunteers;
  final List<String> organizers;
  final bool isRegistrationOpen;

  EventDetails({
    this.eventTitle,
    this.venue,
    this.id,
    this.date,
    this.bannerUrl,
    this.description,
    this.registrationStatus = RegistrationStates.undefined,
    this.registrations,
    this.volunteers,
    this.organizers,
    this.isRegistrationOpen,
  });

  String get formattedDate => formatDate(
        this.date,
        DateFormats.shortUiDateFormat,
      );

  EventDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, id: snapshot.reference.documentID);

  EventDetails.fromMap(Map<String, dynamic> map, {this.id})
      : eventTitle = map['eventTitle'],
        date = (map['date'] as Timestamp).toDate(),
        bannerUrl = map['bannerUrl'],
        registrations = map['registrations'],
        registrationStatus = _findRegistrationStatus(map['registrations']),
        venue = Venue.fromMap(map['venue']),
        description = map['description'],
        volunteers = List<String>.from(map['volunteers']),
        organizers = List<String>.from(map['organizers']),
        isRegistrationOpen = map['is_registration_open'] ?? false;

  static String _findRegistrationStatus(Map registrations) =>
      registrations != null && registrations[userCache.user.id] != null
          ? registrations[userCache.user.id]['status']
          : RegistrationStates.defaultState;

  bool isManagedBy(String userId) =>
      volunteers.contains(userId) || organizers.contains(userId);
}

class Venue {
  final String title;
  final String address;
  final String city;
  final String imageUrl;
  final Location location;
  final DocumentReference reference;

  Venue({
    this.address,
    this.title,
    this.imageUrl,
    this.location,
    this.city,
    this.reference,
  });

  Venue.fromMap(Map map, {this.reference})
      : title = map['title'],
        address = map['address'],
        city = map['city'],
        imageUrl = map['imageUrl'],
        location = Location.fromMap(map['location']);

  Venue.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Location {
  final double latitude;
  final double longitude;
  final DocumentReference reference;

  Location({
    this.latitude,
    this.longitude,
    this.reference,
  });

  Location.fromMap(Map map, {this.reference})
      : latitude = map['latitude'],
        longitude = map['longitude'];

  Location.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
