import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_calendar/case_widget.dart';
import 'package:custom_calendar/models/case_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final GlobalKey _draggableKey = GlobalKey();
  CarouselController buttonCarouselController = CarouselController();
  bool isDaySelected = false;
  late DateTime selectedDateTime;
  late int selectedMonth;
  late int countOfCarouselSlides;
  Order? selectedOrder;

  List<Order> items = [
    Order('1', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 11, 9, 00)),
    Order('2', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 11, 10, 00)),
    Order('3', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 11, 10, 00)),
    Order('4', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 11, 10, 00)),
    Order('5', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 12, 11, 00)),
    Order('6', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 13, 9, 00)),
    Order('7', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 13, 10, 00)),
    Order('8', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 13, 10, 00)),
    Order('9', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 14, 9, 00)),
    Order('10', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 14, 10, 00)),
    Order('11', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 14, 10, 00)),
    Order('12', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 15, 9, 00)),
    Order('13', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 15, 10, 00)),
    Order('14', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 15, 10, 00)),
    Order('15', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 15, 9, 00)),
    Order('16', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 16, 10, 00)),
    Order('17', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 16, 10, 00)),
    Order('18', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 16, 9, 00)),
    Order('19', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 16, 10, 00)),
    Order('20', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 17, 10, 00)),
    Order('21', 'Василий', 'Полина', "hfj", 'Маникюр',
        DateTime(2022, 7, 17, 9, 30)),
  ];

  List<String> dayOfTheWeek = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Вс',
  ];

  List<String> month = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  ValueKey<int> rowKey = ValueKey(0);

  @override
  void initState() {
    selectedDateTime = DateTime.now();
    selectedMonth = selectedDateTime.month;
    countOfCarouselSlides = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF3F4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isDaySelected) ...[
            //Верхняя часть экрана в недельном календаре
            const SizedBox(height: 44),
            Row(
              children: [
                const SizedBox(width: 62),
                MonthSelector(),
                const SizedBox(width: 19),
                ButtonMonthSelector(TextDirection.ltr),
                const SizedBox(width: 19),
                ButtonMonthSelector(TextDirection.rtl),
                const Spacer(),
                PeriodSelector(),
                const SizedBox(width: 135),
              ],
            ),
            const SizedBox(height: 20),
          ],
          AnimatedAlign(
            duration: Duration(milliseconds: 350),
            //контейнер календаря
            alignment:
                isDaySelected ? Alignment.centerRight : Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: isDaySelected ? 370 : 1419,
                height: isDaySelected
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height - 88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!isDaySelected) ...[
                        //отображение дней если выбрана неделя
                        const SizedBox(height: 7),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: Row(
                            key: rowKey,
                            children: List.generate(
                              7,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 190 : 138,
                                    right: index == 6 ? 30 : 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDateTime = selectedDateTime.add(
                                          Duration(
                                              days: index +
                                                  1 -
                                                  selectedDateTime.weekday));
                                      rowKey = ValueKey(selectedDateTime.weekday);
                                    });
                                  },
                                  child: Container(
                                    width: 47.5,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      color: index == selectedDateTime.weekday - 1
                                          ? const Color(0xffE59B9C)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        Text(
                                          selectedDateTime
                                              .add(Duration(
                                                  days: index -
                                                      selectedDateTime.weekday +
                                                      1))
                                              .day
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: index ==
                                                      selectedDateTime.weekday - 1
                                                  ? Colors.white
                                                  : const Color(0xffE59B9C)),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          dayOfTheWeek[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: index ==
                                                      selectedDateTime.weekday - 1
                                                  ? Colors.white
                                                  : const Color(0xff979797)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21),
                          child: Container(
                            height: 1,
                            width:
                                1382 + 1440 - MediaQuery.of(context).size.width,
                            color: Color(0xff979797),
                          ),
                        ),
                      ] else ...[
                        //отображение выбора смены дня и переключалки дня/недели если выбран день
                        SizedBox(height: 113),
                        Row(
                          children: [
                            ButtonMonthSelector(TextDirection.ltr),
                            MonthSelector(),
                            ButtonMonthSelector(TextDirection.rtl),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: PeriodSelector(),
                        ),
                        const SizedBox(height: 13),
                      ],
                      Padding(
                        //контент ордеров
                        padding: const EdgeInsets.only(left: 37, top: 11),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 23,
                          itemBuilder:
                              (BuildContext context, int builderIndex) {
                            return Column(
                              children: [
                                Row(
                                    children: List.generate(
                                  isDaySelected ? 1 : 7,
                                  (listIndex) => Padding(
                                    padding: EdgeInsets.only(
                                        left: listIndex == 0 ? 87 : 21),
                                    child: Container(
                                      width: 165,
                                      child: DragTarget<Case>(
                                        builder: (context, candidateItems,
                                            rejectedItems) {
                                          List<Order> list = checkOrders(
                                              builderIndex: builderIndex,
                                              listIndex: listIndex,
                                              selectedDay: isDaySelected
                                                  ? selectedDateTime.day
                                                  : null);
                                          return Column(
                                            children: [
                                              if (list.length == 1) ...[
                                                longPressDraggable(
                                                    order: list[0]),
                                              ] else if (list.length == 2) ...[
                                                longPressDraggable(
                                                    order: list[0],
                                                    caseSize: CaseSize.medium),
                                                const SizedBox(height: 11),
                                                longPressDraggable(
                                                    order: list[1],
                                                    caseSize: CaseSize.medium),
                                              ] else if (list.length > 2) ...[
                                                Stack(
                                                  children: [
                                                    Row(
                                                      children: List.generate(
                                                        list.length,
                                                        (rowIndex) =>
                                                            GestureDetector(
                                                          child: longPressDraggable(
                                                              order: list[
                                                                  rowIndex],
                                                              caseWight: 165 /
                                                                  list.length,
                                                              caseSize: CaseSize
                                                                  .small),
                                                          onTap: () {
                                                            setState(() {
                                                              selectedOrder =
                                                                  list[
                                                                      rowIndex];
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    if (selectedOrder != null && selectedOrder!.date == list[0].date)
                                                      GestureDetector(
                                                        child: Case(
                                                            order:
                                                                selectedOrder!),
                                                        onTap: () {
                                                          setState(() {
                                                            selectedOrder =
                                                                null;
                                                          });
                                                        },
                                                      )
                                                  ],
                                                ),
                                              ] else ...[
                                                const SizedBox(
                                                  height: 85,
                                                  width: 165,
                                                )
                                              ]
                                            ],
                                          );
                                        },
                                        onAccept: (item) {
                                          //изменение даты ордера при перетаскивании
                                          for (int i = 0;
                                              i < items.length;
                                              i++) {
                                            if (items[i].id == item.order.id) {
                                              setState(() {
                                                items[i].date =
                                                    selectedDateTime.add(
                                                  Duration(
                                                      days: isDaySelected
                                                          ? 0
                                                          : listIndex -
                                                              selectedDateTime
                                                                  .weekday +
                                                              1,
                                                      hours: ((builderIndex /
                                                                      2) +
                                                                  8.5)
                                                              .floor() -
                                                          selectedDateTime.hour,
                                                      minutes: -selectedDateTime
                                                              .minute +
                                                          (builderIndex % 2 == 0
                                                              ? 30
                                                              : 0)),
                                                );
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                )),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        (builderIndex / 2 + 9)
                                                .floor()
                                                .toString() +
                                            (builderIndex % 2 == 1
                                                ? ':30'
                                                : ':00'),
                                      ),
                                      width: 39,
                                      height: 19,
                                    ),
                                    Container(
                                      height: 1,
                                      width: isDaySelected
                                          ? 294
                                          : MediaQuery.of(context).size.width -
                                              97 +
                                              1440 -
                                              MediaQuery.of(context).size.width,
                                      color: const Color.fromRGBO(
                                          238, 240, 240, 1),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LongPressDraggable<Case> longPressDraggable(
      //Перетаскивание виджета ордера в контейнере
      {required Order order,
      CaseSize caseSize = CaseSize.big,
      double caseWight = 165}) {
    return LongPressDraggable<Case>(
      child: Case(
        order: order,
        caseSize: caseSize,
        caseWight: caseWight,
      ),
      feedback: Feedback(
        caseWidget: Case(order: order),
        dragKey: _draggableKey,
      ),
      data: Case(order: order),
      dragAnchorStrategy: pointerDragAnchorStrategy,
    );
  }

  Widget ButtonMonthSelector(TextDirection direction) {
    //Переключение недели/дня и сопутствующая логика
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (isDaySelected) {
            if (direction == TextDirection.ltr) {
              setState(() {
                buttonCarouselController.previousPage();
                selectedDateTime = selectedDateTime.add(Duration(days: -1));
              });
            }
            if (direction == TextDirection.rtl) {
              setState(() {
                buttonCarouselController.nextPage();
                selectedDateTime = selectedDateTime.add(Duration(days: 1));
              });
            }
          } else {
            if (direction == TextDirection.ltr) {
              setState(() {
                selectedDateTime = selectedDateTime
                    .add(Duration(days: -selectedDateTime.weekday - 6));
                rowKey = ValueKey(selectedDateTime.day + 7);
              });
            }
            if (direction == TextDirection.rtl) {
              setState(() {
                selectedDateTime = selectedDateTime
                    .add(Duration(days: 7 - selectedDateTime.weekday + 1));
                rowKey = ValueKey(selectedDateTime.day + 7);
              });
            }
            if (selectedDateTime.month == 1 && selectedMonth == 12) {
              buttonCarouselController.nextPage();
              selectedMonth = 1;
            }
            if (selectedDateTime.month == 12 && selectedMonth == 1) {
              buttonCarouselController.nextPage();
              selectedMonth = 12;
            }
            if (selectedDateTime.month > selectedMonth) {
              buttonCarouselController.nextPage();
              selectedMonth++;
            }
            if (selectedDateTime.month < selectedMonth) {
              buttonCarouselController.previousPage();
              selectedMonth--;
            }
          }
        },
        child: SvgPicture.asset(direction == TextDirection.ltr
            ? 'images/left_arrow.svg'
            : 'images/right_arrow.svg'),
      ),
    );
  }

  Widget MonthSelector() {
    //крутилка смены месяца/дня
    return Stack(
      children: [
        SizedBox(
          width: isDaySelected ? 82 : 148,
          height: isDaySelected ? 17 : 24,
          child: CarouselSlider.builder( //todo
            itemCount: 12,
            carouselController: buttonCarouselController,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Text(
                month[selectedDateTime.month - 1] +
                    (isDaySelected
                        ? ', ' + (selectedDateTime.day).toString()
                        : ' ' + selectedDateTime.year.toString()),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isDaySelected ? 14 : 20),
              );
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 2,
              aspectRatio: 2,
              initialPage: DateTime.now().month - 1,
              disableCenter: false,
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          width: isDaySelected ? 82 : 148,
          height: isDaySelected ? 17 : 24,
        ),
      ],
    );
  }

  Widget PeriodSelector() {
    //переключалка между днем и неделей
    return Row(
      children: List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 6),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index == 0 ? isDaySelected = true : isDaySelected = false;
                });
              },
              child: Container(
                width: 116,
                height: 24,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: (!isDaySelected && index == 0) ||
                              (isDaySelected && index == 1)
                          ? Color(0xff979797)
                          : Color(0xffE59B9C),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    index == 0 ? 'День' : 'Неделя',
                    style: TextStyle(
                      color: (!isDaySelected && index == 0) ||
                              (isDaySelected && index == 1)
                          ? const Color(0xff979797)
                          : const Color(0xffE59B9C),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Order> checkOrders(
      {required int builderIndex, required int listIndex, int? selectedDay}) {
    //функция для выведения ордеров в конкретной ячейке
    List<Order> list = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].date.hour + (items[i].date.minute == 30 ? 0.5 : 0) ==
              builderIndex / 2 + 8.5 &&
          items[i].date.weekday == listIndex + 1 &&
          selectedDay == null) {
        list.add(items[i]);
      }
      if (selectedDay != null &&
          items[i].date.day == selectedDay &&
          items[i].date.hour + (items[i].date.minute == 30 ? 0.5 : 0) ==
              builderIndex / 2 + 8.5) {
        list.add(items[i]);
      }
    }
    return list;
  }
}

class Feedback extends StatelessWidget {
  //отображение при перетаскивании
  final GlobalKey dragKey;
  final Case caseWidget;

  const Feedback({
    Key? key,
    required this.dragKey,
    required this.caseWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: SizedBox(
        height: 150,
        width: 150,
        child: caseWidget,
      ),
    );
  }
}
