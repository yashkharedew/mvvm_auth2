import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SampleDocScreen extends StatefulWidget {
  const SampleDocScreen({super.key});

  @override
  State<SampleDocScreen> createState() => _SampleDocScreenState();
}

class _SampleDocScreenState extends State<SampleDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.all(16),
              color: Color.fromARGB(255, 0, 112, 137),
              child: Text(
                'Detail Doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              width: 80,
              height: 80,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/online-doc-consultation.appspot.com/o/DoctorImages%2Fdoctor.png?alt=media&token=b4f6ce31-7bc7-4c57-b2bf-1ecac2b73493',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                'Dr. U.S.Tiwari',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                'General Physician',
                style: TextStyle(
                    color: Color.fromARGB(255, 164, 164, 164),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 208, 229, 255),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Patients',
                            style: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1,056',
                            style: TextStyle(
                              color: Color.fromARGB(255, 37, 102, 137),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 2,
                    height: 28,
                    color: Color.fromARGB(255, 202, 202, 202),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Experience',
                            style: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '10yrs',
                            style: TextStyle(
                              color: Color.fromARGB(255, 37, 102, 137),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 2,
                    height: 28,
                    color: Color.fromARGB(255, 202, 202, 202),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Rating',
                            style: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '4.8',
                            style: TextStyle(
                              color: Color.fromARGB(255, 37, 102, 137),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Doctor',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 164, 164, 164),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
