import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sorting_app/pages/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController inputSizeController = TextEditingController();
  int chosenInputSize;
  List<int> inputArray = [];
  String chosenSortingAlgorithm = 'Selection Sort';
  bool isInputSizeValid = false;
  bool isRunning = false;

  @override
  void dispose() {
    inputSizeController.dispose();
    super.dispose();
  }

  buildUserInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildInputField(),
          buildChooseAlgorithm(),
        ],
      ),
    );
  }

  buildInputField() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) {
          if ((double.tryParse(value) != null)) {
            double check = double.parse(value);
            if (check >= 1 && check <= 500) {
              setState(() {
                isInputSizeValid = true;
              });
            } else {
              setState(() {
                isInputSizeValid = false;
              });
            }
          } else {
            setState(() {
              isInputSizeValid = false;
            });
          }
        },
        controller: inputSizeController,
        decoration: InputDecoration(
          labelText: "Input Size",
          errorText:
              isInputSizeValid ? null : "Enter a number between 1 and 500",
        ),
      ),
    );
  }

  buildChooseAlgorithm() {
    return Container(
      child: DropdownButton<String>(
        value: chosenSortingAlgorithm,
        icon: Icon(Icons.arrow_downward),
        elevation: 16,
        items: algList.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            chosenSortingAlgorithm = newValue;
          });
        },
      ),
    );
  }

  buildGenerateButton() {
    return ElevatedButton(
      onPressed: isRunning ? null : () => generateArray(),
      child: Text('Generate'),
      style: ButtonStyle(
        backgroundColor: isInputSizeValid || !isRunning
            ? MaterialStateProperty.all<Color>(Colors.blue)
            : MaterialStateProperty.all<Color>(Colors.grey),
      ),
    );
  }

  generateArray() {
    if (isInputSizeValid) {
      int range = int.parse(inputSizeController.text);
      List<int> newList = [];
      for (var i = 0; i < range; i++) {
        newList.add(Random().nextInt(100) + 1);
      }
      setState(() {
        inputArray = newList;
      });
    }
  }

  buildAlgArea() {
    double width = MediaQuery.of(context).size.width * .75;
    double height = MediaQuery.of(context).size.height * .75;
    return Container(
      width: width + 2,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: inputArray.map((value) {
          return IndexBox(
            maxHeight: height,
            maxWidth: width,
            totalAmount: inputArray.length,
            value: value,
          );
        }).toList(),
      ),
    );
  }

  buildStartButton() {
    return ElevatedButton(
      onPressed: isRunning ? null : () => runSortAlg(),
      child: Text('Start Sorting'),
      style: ButtonStyle(
        backgroundColor: isInputSizeValid || !isRunning
            ? MaterialStateProperty.all<Color>(Colors.blue)
            : MaterialStateProperty.all<Color>(Colors.grey),
      ),
    );
  }

  runSortAlg() async {
    setState(() {
      isRunning = true;
    });
    switch (chosenSortingAlgorithm) {
      case "Selection Sort":
        await selectionSort(inputArray);
        break;
      case "Bubble Sort":
        await bubbleSort(inputArray);
        break;
      case "Insertion Sort":
        await insertionSort(inputArray);
        break;
      case 'Merge Sort':
        await mergeSort(inputArray, 0, inputArray.length - 1);
        break;
      case 'Quicksort':
        await quickSort(inputArray);
        break;
      case 'Heap Sort':
        await heapSort(inputArray);
        break;
      case 'Radix Sort':
        await radixSort(inputArray);
        break;
      case 'Pigeonhole Sort':
        await pigeonholeSort(inputArray);
        break;
      case 'Shellsort':
        await shellSort(inputArray);
        break;
      case 'Comb Sort':
        await combSort(inputArray);
        break;
      case 'Bucket Sort':
        await bucketSort(inputArray);
        break;
      default:
    }
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorting Algorithms"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildUserInput(),
            buildGenerateButton(),
            buildAlgArea(),
            buildStartButton(),
          ],
        ),
      ),
    );
  }

  Future<void> selectionSort(List<int> input) async {
    int length = input.length;
    for (int i = 0; i < length - 1; i++) {
      int minimum = i;
      for (int j = i + 1; j < length; j++) {
        if (input[j] < input[minimum]) {
          minimum = j;
        }
      }
      await Future.delayed(Duration(milliseconds: 100));
      int temp = input[minimum];
      input[minimum] = input[i];
      input[i] = temp;
      setState(() {
        inputArray = input;
      });
    }
  }

  Future<void> bubbleSort(List<int> input) async {
    int length = input.length;
    bool swapped;
    for (int i = 0; i < length - 1; i++) {
      swapped = false;
      for (int j = 0; j < length - i - 1; j++) {
        if (input[j] > input[j + 1]) {
          await Future.delayed(Duration(milliseconds: 100));
          int temp = input[j];
          input[j] = input[j + 1];
          input[j + 1] = temp;
          swapped = true;
          setState(() {
            inputArray = input;
          });
        }
      }
      if (!swapped) break;
    }
  }

  Future<void> insertionSort(List<int> input) async {
    int length = input.length;
    for (int i = 1; i < length; i++) {
      int j = i - 1;
      int selected = input[i];
      int location = binarySearch(input, selected, 0, j);

      while (j >= location) {
        await Future.delayed(Duration(milliseconds: 100));
        input[j + 1] = input[j];
        j--;
        setState(() {
          inputArray = input;
        });
      }
      input[j + 1] = selected;
    }
  }

  int binarySearch(List<int> input, int item, int low, int high) {
    if (high <= low) return (item > input[low]) ? (low + 1) : low;

    int mid = ((low + high) / 2).floor();

    if (item == input[mid]) return mid + 1;

    if (item > input[mid]) return binarySearch(input, item, mid + 1, high);
    return binarySearch(input, item, low, mid - 1);
  }

  Future<void> mergeSort(List<int> input, int left, int right) async {}

  Future<void> quickSort(List<int> input) async {}

  Future<void> heapSort(List<int> input) async {}

  Future<void> radixSort(List<int> input) {}

  Future<void> pigeonholeSort(List<int> input) async {
    int length = input.length;
    int min = input[0];
    int max = input[0];
    int range, i, j, index;
    for (int a = 0; i < length; a++) {
      if (input[a] > max) max = input[a];
      if (input[a] < min) min = input[a];
    }

    range = max - min + 1;
    List<int> phole = List.generate(range, (index) => null);
    for (i = 0; i < length; i++) {
      phole[input[i] - min] = input[i];
    }

    int count = 0;
    for (j = 0; j < range; j++) {
      while (phole[j] != null) {
        input[count] = phole[j];
        phole[j] = null;
        await Future.delayed(Duration(milliseconds: 100));
        setState(() => inputArray = input);
      }
    }
  }

  Future<void> shellSort(List<int> input) async {}

  Future<void> combSort(List<int> input) async {
    int gapValue = input.length;
    double shrink = 1.3;
    bool sorted = false;

    while (!sorted) {
      gapValue = (gapValue / shrink).floor();
      if (gapValue > 1) {
        sorted = false;
      } else {
        gapValue = 1;
        sorted = true;
      }

      int i = 0;
      while (i + gapValue < input.length) {
        if (input[i] > input[i + gapValue]) {
          swap(input, i, gapValue);
          await Future.delayed(Duration(milliseconds: 100));
          setState(() {
            inputArray = input;
          });
          sorted = false;
        }
        i++;
      }
    }
  }

  void swap(List list, int i, int gapValue) {
    int temp = list[i];
    list[i] = list[i + gapValue];
    list[i + gapValue] = temp;
  }

  Future<void> bucketSort(List<int> input) async {}
}
