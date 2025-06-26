import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/utils/type_def.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/comment_card_topbar.dart';

class CommentCard extends StatelessWidget {
  final ReplyModel comment;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const CommentCard({
    required this.comment,
    this.isAuthCard = false,
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CirlcleImage(
                url: comment.user!.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Comment top bar
                  CommentCardTopbar(
                    comment: comment,
                    isAuthCard: isAuthCard,
                    callback: callback,
                  ),
                  Text(comment.reply!),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}