class TextDetails {
  String title = "vivek";
  String font = "normal";
  double size = 20.0;
  double x = 150.0;
  double y = 300.0;
  bool isBold = false;
  bool isItalic = false;
  bool isCentered = true;
  bool isUnderlined = false;
}

final List<TextDetails> textData = [];
final List<TextDetails> removedItem = [];

List<TextDetails> getData() {
  if (textData.isEmpty) {
    textData.add(TextDetails());
  }
  return textData;
}

void add() {
  textData.add(TextDetails());
}

void remove() {
  if (textData.isNotEmpty) {
    removedItem.add(textData.removeLast());
  }
}

void redo() {
  if (removedItem.isNotEmpty) {
    textData.add(removedItem.removeLast());
  }
}
