import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_modify.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/employee/list.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/views/cards/employee_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ListOfEmployee extends StatefulWidget {
  const ListOfEmployee({super.key});

  @override
  State<ListOfEmployee> createState() => _ListOfEmployeeState();
}

class _ListOfEmployeeState extends State<ListOfEmployee> {
  employeeService get service => GetIt.I<employeeService>();

  final scrollController = ScrollController();

  late APIResponse<List<employeeListModel>> _apiResponse;
  List<employeeListModel> _models = [];

  String _keyword = "";
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _fetchAPI();
  }

  onSearch(String search) {
    _models.clear();

    if (search != "") {
      _keyword = search;
    } else {
      _keyword = "";
    }
    _page = 1;

    _fetchAPI();
  }

  clearSearch() {
    _controller.clear();
    _models.clear();
    _page = 1;
    _keyword = "";
    _fetchAPI();
  }

  _fetchBack() async {
    setState(() {
      _isLoading = true;
    });

    await _fetchAPI();

    setState(() {
      _isLoading = false;
    });
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sgRed,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Employee',
              style: TextStyle(
                color: sgWhite,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Nexa',
              ),
            ),
            Icon(
              Icons.edit_note_outlined,
              color: sgRed,
              size: 30.0,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => EmployeeModify(),
            ),
          )
              .then((_) {
            _fetchBack();
          });
        },
        backgroundColor: sgRed,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
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
              height: size.height * .825,
              child: ListView.builder(
                controller: scrollController,
                itemCount: _isLoading ? _models.length + 1 : _models.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _models.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (_) => EmployeeModify(
                              id: _models[index].id,
                            ),
                          ),
                        )
                            .then(
                          (_) {
                            _fetchBack();
                          },
                        );
                      },
                      child: EmployeeCardWidget(
                        model: _models[index],
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
      ),
    );
  }

  Future<void> _fetchAPI() async {
    _apiResponse = await service.GetEmployeeList(_page, _keyword);

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
      await _fetchAPI();
      setState(() {
        _isLoading = false;
      });
    }
  }
}
