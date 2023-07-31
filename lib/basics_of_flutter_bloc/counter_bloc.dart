import 'dart:async';

// Basics of Bloc
enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;

  // OUTPUT STREAM CONTROLLER
  final _stateStreamController = StreamController<int>(); // Stream Controller
  StreamSink<int> get counterSink => _stateStreamController.sink; // Input
  Stream<int> get counterStream => _stateStreamController.stream; // Output

  // INPUT STREAM CONTROLLER : USER INPUT
  final _eventStreamController =
      StreamController<CounterAction>(); // Stream Controller
  StreamSink<CounterAction> get eventSink =>
      _eventStreamController.sink; // Input
  Stream<CounterAction> get eventStream =>
      _eventStreamController.stream; // Output

  // CONSTRUCTOR
  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
      } else if (event == CounterAction.Reset) {
        counter = 0;
      }
      //  SENDING OUTPUT OF EVENT STREAM CONTROLLER TO FIRST STATE STREAM CONTROLLER AS INPUT
      counterSink.add(counter);
    });
  }
}
