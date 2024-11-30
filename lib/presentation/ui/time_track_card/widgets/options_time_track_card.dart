import 'package:flutter/material.dart';

class OptionsTimeTrackCard extends StatefulWidget {
  const OptionsTimeTrackCard({super.key});
  @override
  State<OptionsTimeTrackCard> createState() => _OptionsTimeTrackCardState();
}

class _OptionsTimeTrackCardState extends State<OptionsTimeTrackCard> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(
          onPressed: () {},
          child: const Text('Duplicate'),
        ),
        MenuItemButton(
          onPressed: () {},
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
       
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}
