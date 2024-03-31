// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:mvvm_auth2/view_model/get_doctor_details_view_model.dart';
// import 'package:provider/provider.dart';

// import 'doctor_image.dart';

// class DoctorCard extends StatefulWidget {
//   const DoctorCard({super.key});

//   @override
//   State<DoctorCard> createState() => _DoctorCardState();
// }

// class _DoctorCardState extends State<DoctorCard> {
//   @override
//   Widget build(BuildContext context) {
//     final _getDoctorDetailsViewModel =
//         Provider.of<GetDoctorDetailsViewModel>(context);

//     return FutureBuilder(
//       future: _getDoctorDetailsViewModel.getDoctorDetailsApi(),
//       builder: ((context, snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Container(
//               width: double.infinity,
//               height: 180,
//               child: Card(
//                 elevation: 50,
//                 shadowColor: Colors.black,
//                 color: Color.fromARGB(255, 0, 112, 137),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       DoctorImage(),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               snapshot.data!['speciality'],
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 fontSize: 13,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               snapshot.data!['name'],
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         } else if (snapshot.hasError) {
//           Text('no data');
//         }
//         return CircularProgressIndicator();
//       }),
//     );
//   }
// }
