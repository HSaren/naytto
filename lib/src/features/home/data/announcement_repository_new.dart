import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naytto/src/constants/firestore_constants.dart';
import 'package:naytto/src/features/home/domain/announcement_new.dart';

class AnnouncementsRepository {
  // Constructor for AnnouncementsRepository
  AnnouncementsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  //// Method to create a query for announcements to be used by a [FirestoreListView]
  Query<Announcement> announcementsQuery() {
    return _firestore
        .collection(FirestoreCollections.housingCooperative)
        // Id for housingcooperation here from users info after authentication
        .doc('flaNcZSewSF09o8SSEKI')
        .collection(FirestoreCollections.announcements)
        .withConverter(
          fromFirestore: (snapshot, _) {
            return Announcement.fromMap(snapshot.data()!, snapshot.id);
          },
          // toFirestore is not actually used but needs to be here
          // because it is a required parameter for query
          toFirestore: (announcement, _) => announcement.toMap(),
        )
        .orderBy(FirestoreFields.announcementTimestamp, descending: false);
  }
}

// Provider for AnnouncementsRepository
final announcementsRepositoryProvider =
    Provider<AnnouncementsRepository>((ref) {
  // Create and return an instance of AnnouncementsRepository
  return AnnouncementsRepository(FirebaseFirestore.instance);
});