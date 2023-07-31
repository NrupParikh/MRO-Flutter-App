import 'package:flutter/material.dart';
import 'package:mro/basics_of_flutter_bloc/counter_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.title});

  final String title;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  //int _counter = 0;
  final counterBlock = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("---- Widget Tree ----");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              stream: counterBlock.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FloatingActionButton(
          onPressed: () {
            // _counter++;
            // counterBlock.counterSink.add(_counter);
            counterBlock.eventSink.add(CounterAction.Increment);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {
            // _counter = 0;
            // counterBlock.counterSink.add(_counter);
            counterBlock.eventSink.add(CounterAction.Reset);
          },
          tooltip: 'Reset',
          child: const Icon(Icons.refresh),
        ),
        FloatingActionButton(
          onPressed: () {
            // _counter--;
            // counterBlock.counterSink.add(_counter);
            counterBlock.eventSink.add(CounterAction.Decrement);
          },
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
      ]),
    );
  }
}
