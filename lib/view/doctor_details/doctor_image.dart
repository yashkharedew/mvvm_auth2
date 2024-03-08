import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../view_model/get_doctor_details_view_model.dart';

class DoctorImage extends StatefulWidget {
  const DoctorImage({super.key});

  @override
  State<DoctorImage> createState() => _DoctorImageState();
}

class _DoctorImageState extends State<DoctorImage> {
  @override
  Widget build(BuildContext context) {
    final _getDoctorDetailsViewModel =
        Provider.of<GetDoctorDetailsViewModel>(context);

    return FutureBuilder(
      future: _getDoctorDetailsViewModel.getDoctorDetailsApi(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              width: 90,
              height: 180,
              child: Image.network(
                snapshot.data!['imageUrl'],
                fit: BoxFit.fill,
              ),
            );
          }
        } else if (snapshot.hasError) {
          Text('no data');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
