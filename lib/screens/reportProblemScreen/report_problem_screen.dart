import 'package:flutter/material.dart';
import 'package:safarkarappfyp/database/report_problem.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';

class ReportProblemScreen extends StatelessWidget {
  static const routeName = '/ReportProblemScreen';
  final TextEditingController _problem = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please explain your problem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '''We'll try to resolve your problems as soon as possible''',
              maxLines: 2,
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _problem,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Write your Problem ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ReportProblemMethods().reportProblem(problem: _problem.text);
                },
                child: Text('Submit Problem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
