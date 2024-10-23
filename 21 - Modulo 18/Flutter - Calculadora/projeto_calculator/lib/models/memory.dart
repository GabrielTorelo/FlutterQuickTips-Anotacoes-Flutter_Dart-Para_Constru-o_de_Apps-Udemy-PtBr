class Memory {
  String _value = '0';

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else {
      _value += command;
    }
  }

  void _allClear() {
    _value = '0';
  }

  String get value => _value;
}
