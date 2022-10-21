import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showContextMenu(BuildContext context, Offset tapPosition) async {
  final RenderObject? overlay =
  Overlay.of(context)?.context.findRenderObject();

  final result = await showMenu(
      context: context,

      // Show the context menu at the tap location
      position: RelativeRect.fromRect(
          Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),

      // set a list of choices for the context menu
      items: [
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ]);

  // Implement the logic for each choice here
  switch (result) {
    case 'delete':
      debugPrint('Delete');
      break;
  }
}