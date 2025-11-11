import 'package:celebrare_app_project/data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<TextDetails> textTitle;
  late TextDetails onSelectedText;

  @override
  void initState() {
    super.initState();
    textTitle = getData();
    onSelectedText = textTitle.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          remove();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.undo,
                              color: Colors.grey,
                            ),
                            Text(
                              'Undo',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          redo();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.redo,
                              color: Colors.grey,
                            ),
                            Text(
                              'Redo',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      )
                    ]
                  ),
                  child: Stack(
                    // alignment: Alignment.center,
                    children: textTitle.map((value) {
                      return Positioned(
                        left: value.x,
                        top: value.y,
                        child: Draggable(
                          feedback: Text(
                            value.title,
                            style: TextStyle(
                              fontSize: value.size,
                              color: Colors.black,
                              fontWeight: (value.isBold)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontStyle: (value.isItalic)
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              decoration: (value.isUnderlined)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              fontFamily: value.font
                            ),
                          ),
                          childWhenDragging: Container(),
                          onDragEnd: (dragDetails) {
                            setState(() {
                              value.x = dragDetails.offset.dx;
                              value.y = dragDetails.offset.dy;
                            });
                          },
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSelectedText = value;
                                onSelectedText.isCentered = false;
                              });
                            },
                            child: Text(
                              value.title,
                              style: TextStyle(
                                fontSize: value.size,
                                color: Colors.black,
                                fontWeight: (value.isBold)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontStyle: (value.isItalic)
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                decoration: (value.isUnderlined)
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                fontFamily: value.font,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      hint: Text(onSelectedText.font),
                      items: ['Arima', 'Flamenco', 'PTSerif', 'Roboto'].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        onSelectedText.font = value!;
                      },
                    ),
                    Row(
                      children: [
                        Material(
                          elevation: 1.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                --onSelectedText.size;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.5),
                              child: Icon(Icons.remove)
                            ),
                          ),
                        ),
                        DropdownButton<int>(
                          hint: Text(onSelectedText.size.toString()),
                          items: [22, 24, 26, 28].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              onSelectedText.size = value!.toDouble();
                            });
                          }
                        ),
                        Material(
                          elevation: 1.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ++onSelectedText.size;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.5),
                              child: Icon(Icons.add)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Material(
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSelectedText.isBold = !(onSelectedText.isBold);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: onSelectedText.isBold ? Colors.grey : Colors.white,
                              ),
                              child: Icon(Icons.format_bold)
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSelectedText.isItalic = !(onSelectedText.isItalic);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: onSelectedText.isItalic ? Colors.grey : Colors.white,
                              ),
                              child: Icon(Icons.format_italic)
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSelectedText.x = 150.0;
                                onSelectedText.y = 300.0;
                                onSelectedText.isCentered = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.format_align_center)
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2.0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onSelectedText.isUnderlined = !(onSelectedText.isUnderlined);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: onSelectedText.isUnderlined ? Colors.grey : Colors.white,
                              ),
                              child: Icon(Icons.format_underline)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        add();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.text_format, color: Colors.black,),
                        Text('Add Text', style: TextStyle(color: Colors.black),)
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
