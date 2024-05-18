import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets extends StatelessWidget {
  const Widgets({super.key});

  @override
  Widget build(BuildContext context) {
    return
     SizedBox();



    }

}
/*

 showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Enter new To Do ",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Todo', border: InputBorder.none),
                onChanged: (value) {
                  context.read<HomeBloc>().data.newTodo = value ?? "";
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.blue)),
                onPressed: () {},
                child: const Text(
                  "add",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
 */