import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';

class URLStack {
  List<String> _url_stack = [];

  // Initialize the stack by clearing the array
  void initializeStack({required String inSource}) {
    _url_stack = [];
    Globals.printDebug(inText: 'URLStack initialise from $inSource stackCount = ${_url_stack.length.toString()}');
  }

  // Push a new item onto the top of the stack. If it is the same URL as the first URL then don't add it to the stack as it is going backwards
  bool push(String item) {
    if (item != firstURL()) {
      //Only puh URL if it is not the same as the current firstURL which means it is not going backwards and it needs to be added to the stack
      _url_stack.insert(0, item);
      return true;
    }
    return false;
  }

  // Pop the first item off the stack
  bool pop() {
    Globals.printDebug(inText: 'URLStack B4 pop stackCount = ${_url_stack.length.toString()}');
    Globals.printDebug(inText: 'URLStack B4 pop firstUrl = ${firstURL()}');
    Globals.printDebug(inText: 'URLStack B4 pop secondURL = ${secondURL()}');
    if (_url_stack.isNotEmpty) {
      _url_stack.removeAt(0);
      Globals.printDebug(inText: 'URLStack After pop stackCount = ${_url_stack.length.toString()}');
      Globals.printDebug(inText: 'URLStack After pop firstUrl = ${firstURL()}');
      Globals.printDebug(inText: 'URLStack After pop secondURL = ${secondURL()}');
      return true;
    } else {
      Globals.printDebug(inText: 'URLStack After pop Stack is Empty');
      return false;
    }
  }

  int findURL(String content) {
    for (int i = 0; i < _url_stack.length; i++) {
      if (_url_stack[i] == content) {
        return i;
      }
    }
    return -1;
  }

  String firstURL() {
    String myString = AppConstants.arrayStringItemNotFound;
    if (_url_stack.length > 0) {
      myString = _url_stack[0];
    }
    return myString;
  }

  String findItem({required int inItem}) {
    if (inItem + 1 > _url_stack.length) {
      return AppConstants.arrayStringItemNotFound;
    }
    return _url_stack[inItem];
  }

  String secondURL() {
    String myString = AppConstants.arrayStringItemNotFound;
    if (_url_stack.length > 1) {
      myString = _url_stack[1];
    }
    return myString;
  }

  // Return the size of the stack
  int stackSize() {
    return _url_stack.length;
  }

  // Find the index of a given text in the stack
  // Returns -1 if the text is not found
  int findAt(String text) {
    return _url_stack.indexOf(text);
  }

  void replaceFirstURL({required String inUrl}) {
    if (_url_stack.length > 0) {
      _url_stack[0] = inUrl;
    } else {
      push(inUrl);
    }
  }
}
