// import 'package:flutter/material.dart';
// import 'package:relative_scale/relative_scale.dart';
//
// Widget passwordValidationSection({
//   required bool hasEightCharacters,
//   required bool hasCapitalLetter,
//   required bool hasSmallCapsLetter,
//   required bool hasADigit,
//   required bool hasASpecialCharacter,
// }) {
//   return RelativeBuilder(builder: (context, height, width, sy, sx) {
//     return Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(
//         horizontal: sx(20),
//         vertical: sy(5),
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.white,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             "Password Requirements",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           Divider(
//             color: Colors.white,
//           ),
//           Row(
//             children: [
//               Text(
//                 "At least 8 characters",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: sy(8),
//                 ),
//               ),
//               hasEightCharacters
//                   ? Padding(
//                       padding: EdgeInsets.only(
//                         left: sx(20),
//                       ),
//                       child: Icon(Icons.check_box,
//                           color: ColorConfigs.TUMAI_PRIMARY_COLOR_LIGHT),
//                     )
//                   : Icon(
//                       Icons.close,
//                       color: ColorConfigs.TUMAI_PRIMARY_COLOR_DARK,
//                     ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "At least 1 uppercase letter [A - Z]",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: sy(8),
//                 ),
//               ),
//               hasCapitalLetter
//                   ? Padding(
//                       padding: EdgeInsets.only(
//                         left: sx(20),
//                       ),
//                       child: Icon(Icons.check_box,
//                           color: ColorConfigs.TUMAI_PRIMARY_COLOR_LIGHT),
//                     )
//                   : Icon(
//                       Icons.close,
//                       color: ColorConfigs.TUMAI_PRIMARY_COLOR_DARK,
//                     ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "At least 1 lowercase letter [a-z]",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: sy(8),
//                 ),
//               ),
//               hasSmallCapsLetter
//                   ? Padding(
//                       padding: EdgeInsets.only(
//                         left: sx(20),
//                       ),
//                       child: Icon(Icons.check_box,
//                           color: ColorConfigs.TUMAI_PRIMARY_COLOR_LIGHT),
//                     )
//                   : Icon(
//                       Icons.close,
//                       color: ColorConfigs.TUMAI_PRIMARY_COLOR_DARK,
//                     ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "At least 1 digit [0-9]",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: sy(8),
//                 ),
//               ),
//               hasADigit
//                   ? Padding(
//                       padding: EdgeInsets.only(
//                         left: sx(20),
//                       ),
//                       child: Icon(Icons.check_box,
//                           color: ColorConfigs.TUMAI_PRIMARY_COLOR_LIGHT),
//                     )
//                   : Icon(
//                       Icons.close,
//                       color: ColorConfigs.TUMAI_PRIMARY_COLOR_DARK,
//                     ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "At least 1  special character [!@#\\\$&*~^%()+=|]",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: sy(8),
//                 ),
//               ),
//               hasASpecialCharacter
//                   ? Padding(
//                       padding: EdgeInsets.only(
//                         left: sx(20),
//                       ),
//                       child: Icon(Icons.check_box,
//                           color: ColorConfigs.TUMAI_PRIMARY_COLOR_LIGHT),
//                     )
//                   : Icon(
//                       Icons.close,
//                       color: ColorConfigs.TUMAI_PRIMARY_COLOR_DARK,
//                     ),
//             ],
//           ),
//         ],
//       ),
//     );
//   });
// }
