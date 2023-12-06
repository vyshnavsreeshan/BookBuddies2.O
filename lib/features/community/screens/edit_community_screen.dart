import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Scaffold(
      //backgroundColor: Pallete.darkModeAppTheme.backgroundColor,
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
      body: Column(
        children: [

        ],

      ),
    );
  }
}