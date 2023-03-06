import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/widget/cards/schedule_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ListOfSchedule extends StatefulWidget {
  final DateTime date;
  final List<scheduleListModel> models;

  const ListOfSchedule({
    Key? key,
    required this.date,
    required this.models,
  }) : super(key: key);

  @override
  State<ListOfSchedule> createState() => _ListOfScheduleState();
}

class _ListOfScheduleState extends State<ListOfSchedule> {
  scheduleService get service => GetIt.I<scheduleService>();

  final scrollController = ScrollController();

  late APIResponse<List<scheduleListModel>> _apiResponse;
  List<scheduleListModel> _models = [];

  String _keyword = "";
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);

    _models.clear();
    _models = widget.models;
  }

  onSearch(String search) {
    _models.clear();

    if (search != "") {
      _keyword = search;
    } else {
      _keyword = "";
    }
    _page = 1;

    _fetchAPI(widget.date);
  }

  clearSearch() {
    _controller.clear();
    _models.clear();
    _page = 1;
    _keyword = "";
    _fetchAPI(widget.date);
  }

  // _fetchBack() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   await _fetchAPI(widget.date);

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Widget bottomWidget() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: sgWhite,
            ),
          ),
        ),
        Column(
          children: [
            Text('data')
            // ListView.builder(
            //   itemCount: data.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Text(
            //       data[index].reference_no,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14,
            //         color: sgBlack,
            //         fontFamily: 'Nexa',
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ],
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        minChildSize: 0.32,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: bottomWidget(),
        ),
      ),
    );
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: sgGrey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_outlined,
                          color: sgRed,
                        ),
                        sgSizedBoxWidth,
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) => onSearch(value),
                            autofocus: true,
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        // Icon(
                        //   Icons.mic_outlined,
                        //   color: sgRed,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          sgSizedBoxHeight,
          Container(
            height: size.height,
            child: ListView.builder(
              controller: scrollController,
              itemCount: _isLoading ? _models.length + 1 : _models.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < _models.length) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(
                      //   MaterialPageRoute(
                      //     builder: (_) => EmployeeModify(
                      //       id: _models[index].id,
                      //     ),
                      //   ),
                      // )
                      //     .then(
                      //   (_) {
                      //     _fetchBack();
                      //   },
                      // );
                    },
                    child: ScheduleCardWidget(
                      model: _models[index],
                      openBottom: _showModal,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchAPI(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiResponse = await service.GetList(formatted, _page, _keyword);

    setState(() {
      for (var i = 0; i < _apiResponse.data.length; i++) {
        _models.add(_apiResponse.data[i]);
      }
    });
  }

  Future<void> _scrollListener() async {
    if (_isLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _isLoading = true;
      });
      _page = _page + 1;
      await _fetchAPI(widget.date);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
