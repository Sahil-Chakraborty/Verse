import 'package:flutter/material.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/utils/helper.dart';

class ReplyCardTopbar extends StatelessWidget {
  final ReplyModel comment;
  final bool isAuthCard;
  
  const ReplyCardTopbar({
    required this.comment,
    this.isAuthCard = false,
    
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          comment.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formateDateFromNow(comment.createdAt!)),
            const SizedBox(width: 10),
            const Icon(Icons.more_horiz),
          ],
        )
      ],
    );
  }
}