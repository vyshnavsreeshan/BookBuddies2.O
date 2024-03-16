import 'package:bookbuddies/core/common/error_text.dart';
import 'package:bookbuddies/core/common/loader.dart';
import 'package:bookbuddies/features/auth/controller/community_controller.dart';
import 'package:bookbuddies/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostTypeScreen extends ConsumerStatefulWidget {
  final String type;
  const AddPostTypeScreen({
    super.key, 
    required this.type
    });


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostTypeScreen();
}

class _AddPostTypeScreen extends ConsumerState<AddPostTypeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  List<Community> communities = [];
  Community? selectedCommunity;
  

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isTypeImage = widget.type == 'image';
    final isTypeText = widget.type == 'text';
    final isTypeLink = widget.type == 'link';


    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.type}'),
        actions: [
          TextButton(
            onPressed: () {}, 
          child: const Text('Share'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter title here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
              maxLength: 30,
            ),
            const SizedBox(height: 10),
            if(isTypeText)
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Description here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
              maxLines: 5,
            ),
            if(isTypeLink)
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Link here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft, child: Text('Select Community')
              ),

              ref.watch(userCommunitiesProvider).when(
                data: (data) {
                  communities = data;

                  if(data.isEmpty) {
                    return const SizedBox();
                  }

                  return DropdownButton(
                    value: selectedCommunity??data[0],
                    items: data.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(), 
                  onChanged: (val) {
                    setState(() {
                      selectedCommunity = val;
                    });
                  },
                  );
                }, 
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                  ), 
                  loading: () => const Loader(),),
          ],
        ),
      ),
    );
  }
}