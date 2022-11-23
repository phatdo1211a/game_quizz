import 'package:flutter/material.dart';

import 'currentGameInformation.dart';

Row gameInfoRow({
  required int currentBalanceValue,
  required int currentQustionNumber,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      currentGameInfo(title: 'Xu', info: '$currentBalanceValue Xu'),
      currentGameInfo(
          title: 'Câu hỏi', info: '$currentQustionNumber'),
    ],
  );
}
