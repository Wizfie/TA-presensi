//      bool _isHidden = true;


//  @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//         backgroundColor: Theme.of(context).secondaryHeaderColor,
//           body: Center(
//             child: Container(
//             height: 55,
//             alignment: Alignment.center,
//             padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//             child: TextField(
//               obscureText: _isHidden,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//                 suffix: InkWell(
//                   onTap: _togglePasswordView,  /// This is Magical Function
//                   child: Icon(
//                     _isHidden ?         /// CHeck Show & Hide.
//                      Icons.visibility :
//                      Icons.visibility_off,
//                   ),
//                 ),
//                 /*icon: Icon(
//                   Icons.password_sharp,
//                   color: Colors.black,
//                 ),*/
//               ),
//             ),
//           ),
//         ),
//      );
//   }
// Step 3: Create This the Magical Function.

//       void _togglePasswordView() {
//     setState(() {
//         _isHidden = !_isHidden;
//     });
// }