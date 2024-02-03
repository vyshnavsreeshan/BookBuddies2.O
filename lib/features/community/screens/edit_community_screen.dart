import 'package:bookbuddies/core/common/error_text.dart';
import 'package:bookbuddies/core/common/loader.dart';
import 'package:bookbuddies/core/constants/constants.dart';
import 'package:bookbuddies/features/community/controller/community_controller.dart';
import 'package:bookbuddies/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';


class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({
    super.key, 
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
      data: (community) => Scaffold(
      backgroundColor: Pallete.darkModeAppTheme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Edit Community'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {}, 
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: Pallete.darkModeAppTheme.textTheme.bodyMedium!.color!,
                child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                     //     child: community.banner.isEmpty ||community.banner == Constants.bannerDefault?
                      //    const Center(
                       //     child: Icon(Icons.camera_alt_outlined),
                  
                       //   ):Image.network(community.banner),
              ),
                       ),
                       Positioned(
              bottom: 20,
              left: 20,
               child: CircleAvatar(
                backgroundImage: NetworkImage(community.avatar),
                radius: 32,
               ),
              ),
             ],
            ),
           ), 
        ],
       ),
      ),
     ),
  loading: () => const Loader(),
  error: (error, stackTrace) => ErrorText(
    error: error.toString(),
    ),
   );
  }
 }