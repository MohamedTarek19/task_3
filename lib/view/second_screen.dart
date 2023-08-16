import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController num1 = TextEditingController();

  TextEditingController num2 = TextEditingController();

  double sum = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Sum = ${sum}',style: const TextStyle(fontSize: 20),)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: num1,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Num 1",
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: num2,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Num 2",
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: () {
                  setState((){
                    sum = (double.tryParse(num1.text)??0) +(double.tryParse(num2.text)??0);
                    print(sum);

                  });
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}