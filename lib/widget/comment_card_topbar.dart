import 'package:flutter/material.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/utils/helper.dart';
import 'package:verse/utils/type_def.dart';

class CommentCardTopbar extends StatelessWidget {
  final ReplyModel comment;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const CommentCardTopbar({
    required this.comment,
    this.isAuthCard = false,
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          comment.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formateDateFromNow(comment.createdAt!)),
            const SizedBox(width: 10),
            isAuthCard
                ? GestureDetector(
                    onTap: () {
                      confirmDialog(
                          "Are you sure ?", "This action can't be undone.", () {
                        callback!(comment.id!);
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : const Icon(Icons.more_horiz),
          ],
        )
      ],
    );
  }
}