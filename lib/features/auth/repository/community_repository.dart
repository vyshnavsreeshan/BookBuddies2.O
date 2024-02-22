import 'package:bookbuddies/core/constants/firebase_constants.dart';
import 'package:bookbuddies/core/failure.dart';
import 'package:bookbuddies/core/providers/firebase_provider.dart';
import 'package:bookbuddies/core/type_defs.dart';
import 'package:bookbuddies/models/community_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Community with the same name already exists!';
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(
          e.toString(),),);
    }
  }

  Stream<List<Community>> getUserCommunities(String uid) {
    return _communities
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<Community> communities = [];
      for (var doc in event.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

  Stream<List<Community>> searchCommunity(String query){
    return _communities
    .where(
      'name', isGreaterThanOrEqualTo: query.isEmpty ? 0: query, 
      isLessThan: query.isEmpty 
      ? null 
      : query.substring(0, query.length - 1) + 
      String.fromCharCode(
        query.codeUnitAt(query.length - 1) + 1,
        ),
      )
      .snapshots().map((event) {
        List<Community> communities = [];
        for(var community in event.docs) {
          communities.add(Community.fromMap(community.data() as Map<String, dynamic>));
        }
        return communities;
      });

  }

  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

}
