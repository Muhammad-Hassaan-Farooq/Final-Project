import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final void Function() updatePage;
  const StartScreen({
    required this.updatePage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Effortlessly Manage Your Activities",
              style:
              TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w800,
                  fontSize: 30

              ),

            ),
            SizedBox(height: 20,),
            Text(
                "Chronoscribe helps you track, document, and reflect on your activities to boost your productivity.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15
                )),
            SizedBox(height: 30,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor:
                    Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  updatePage();
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSecondary),
                )),
            SizedBox(height: 40,)
          ],
        )
    )
    );
  }
}
