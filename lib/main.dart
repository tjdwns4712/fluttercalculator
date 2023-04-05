import 'package:flutter/material.dart';

void main() {
  runApp(const calculator());
}

class calculator extends StatelessWidget {
  static const String _title = 'Calculator';
  const calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({super.key});

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  final List _buttonList = ['+', '-', 'x', '÷'];
  //기본 리스트
  final List<DropdownMenuItem<String>> _dropDownMenuItems =
      List.empty(growable: true);
  final List<DropdownMenuItem<String>> _dropDownIconMenuItems =
      List.empty(growable: true);
  // 기본 리스트에 추가되는 경우 추가된 값까지 저장하기 위한 리스트. 자동으로 늘어나도록 옵션.
  String? _buttonText;
  String? _iconbuttonText;
  // 첫 번째 값을 가져오기위한 변수

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    } // 반복문을 통해 _buttonList에 있는 값을 _dropDownMenuItems에 하나씩 저장
    _buttonText = _dropDownMenuItems[0].value;
    //_buttonText는 _dropDownMenuItems의 첫 번째 값을 저장.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 29,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'First Number',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: value1,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Second Number',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: value2,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        var value1nt = double.parse(value1.value.text);
                        //입력 받은 vlaue1의 값을 double 타입으로 받아옴
                        var value2nt = double.parse(value2.value.text);
                        //입력 받은 vlaue2의 값을 double 타입으로 받아옴
                        double result;
                        // 결과를 위한 변수
                        if (_buttonText == '더하기') {
                          result = value1nt + value2nt;
                        } else if (_buttonText == '빼기') {
                          result = value1nt - value2nt;
                        } else if (_buttonText == '곱하기') {
                          result = value1nt * value2nt;
                        } else {
                          result = value1nt / value2nt;
                        }
                        String stringResult = result.toStringAsFixed(6);
                        //String 타입으로 바꾸면서 소숫점 자리 6자리까지 제한
                        sum = stringResult;
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _buttonText!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: DropdownButton(
                          icon: const Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 40,
                            color: Colors.white54,
                          ),
                          dropdownColor: Colors.orangeAccent,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white54,
                          ),

                          //value: _buttonText, // 기본값
                          items: _dropDownMenuItems,
                          onChanged: (String? value) {
                            setState(
                              () {
                                _buttonText = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 394,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Answer:',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      sum,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
