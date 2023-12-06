import 'package:bookbuddies/core/constants/constants.dart';
import 'package:bookbuddies/core/utils.dart';
import 'package:bookbuddies/features/auth/controller/auth_controller.dart';
import 'package:bookbuddies/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:bookbuddies/features/community/repository/communitory_repository.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

final communityControllerProvider = StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunityController(
    communityRepository: communityRepository, 
    ref: ref,
    );
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref.watch(communityControllerProvider.notifier).getCommunityByName(name);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    }): _communityRepository = communityRepository,
    _ref = ref, super(false);

    void createCommunity(String name, BuildContext context) async {
      state = true;
      final uid = _ref.read(userProvider)?.uid ?? '';
      Community community = Community(
        id: name, 
        name: name, 
        avatar: Constants.avatarDefault, 
        members: [uid], 
        mods: [uid],
      );

      final res = await _communityRepository.createCommunity(community);
      state = false;
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Community created successfully!');
        Routemaster.of(context).pop();
      });
    }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

}