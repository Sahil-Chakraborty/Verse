import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/reply_card_topbar.dart';

class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  
  const ReplyCard({
    required this.reply,
    this.isAuthCard = false,
    
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
                url: reply.user!.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Comment top bar
                  ReplyCardTopbar(
                    comment: reply,
                    isAuthCard: isAuthCard,
                    
                  ),
                  Text(reply.reply!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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