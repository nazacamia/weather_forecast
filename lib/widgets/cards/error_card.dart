import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final bool connectionErr;
  const ErrorCard({Key? key, this.connectionErr=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.4)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            connectionErr
                ? const Icon(Icons.error, size: 40,)
                : const Icon(Icons.network_check, size: 40,),
            const SizedBox(height: 10,),
            connectionErr
                ? const Text('Apparently something went wrong')
                : const Text('You have no connection'),
          ],
        ),),
    );
  }
}
