import 'dart:developer';

import 'package:custom_calendar/models/case_model.dart';
import 'package:flutter/material.dart';

enum CaseSize { big, medium, small }

class Case extends StatefulWidget {
  final CaseSize caseSize;
  final Order order;
  final double caseWight;

  const Case({
    Key? key,
    this.caseSize = CaseSize.big,
    required this.order,
    this.caseWight = 165,
  }) : super(key: key);

  @override
  State<Case> createState() => _CaseState();
}

class _CaseState extends State<Case> {
  late double containerHeight;
  double mousePosition = 0;

  @override
  void initState() {
    containerHeight = widget.caseSize == CaseSize.medium ? 37 : 85;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: widget.caseWight,
            height: containerHeight,
            decoration: BoxDecoration(
              color: const Color(0xffFCEDF0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(196, 196, 196, 0.25),
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: widget.caseWight == 165 ? Row(
              children: [
                const SizedBox(width: 9.5),
                CircleAvatar(
                  radius: 20 - (85 - containerHeight) / 8,
                  backgroundColor: const Color(0xffE59B9C),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7 + (85 - containerHeight) / 18),
                    Text(
                      widget.order.serviceName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffE59B9C),
                      ),
                    ),
                    if (containerHeight > 43) ...[
                      const SizedBox(height: 6),
                      Text(
                        widget.order.clientName,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                    if (containerHeight > 60) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Мастер: ' + widget.order.masterName,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                    if (containerHeight > 79) ...[
                      const SizedBox(height: 6),
                      Text(
                        widget.order.date.hour.toString() +
                            ':' +
                            widget.order.date.minute.toString() +
                            (widget.order.date.minute == 0 ? '0' : ''),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ],
            ) : Container(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: Container(
            height: containerHeight - 18,
            width: 2,
            decoration: BoxDecoration(
              color: const Color(0xffE59B9C),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.resizeUpDown,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (details) {
              setState(() {
                if (details.primaryDelta! < 0 && containerHeight < 85) {
                  containerHeight += 2;
                }
                if (details.primaryDelta! > 0 && containerHeight > 37) {
                  containerHeight -= 2;
                }
              });
            },
            child: SizedBox(
              height: 8,
              width: widget.caseWight,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: containerHeight - 8),
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeUpDown,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (details.primaryDelta! < 0 && containerHeight > 37) {
                    containerHeight -= 2;
                  }
                  if (details.primaryDelta! > 0 && containerHeight < 85) {
                    containerHeight += 2;
                  }
                });
              },
              child:  SizedBox(
                width: widget.caseWight,
                height: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
