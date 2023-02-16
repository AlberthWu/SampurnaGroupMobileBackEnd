import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_modify.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/employee/list.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/views/widgets/card_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';

class WhatsappScress extends StatefulWidget {
  const WhatsappScress({super.key});

  @override
  State<WhatsappScress> createState() => _WhatsappScressState();
}

class _WhatsappScressState extends State<WhatsappScress> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: sgRed,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              height: 38,
              child: TextField(
                controller: _controller,
                onChanged: (value) => onSearch(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: sgBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: sgBlack,
                  ),
                  hintText: "Search employee",
                  suffixIcon: IconButton(
                    onPressed: () {
                      clearSearch();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          ),
          // actions: [
          // Padding(
          //   padding: EdgeInsets.only(top: 12, right: 15),
          //   child: Icon(
          //     Icons.search,
          //     size: 28,
          //   ),
          // ),
          // PopupMenuButton(
          //   padding: EdgeInsets.symmetric(vertical: 20),
          //   iconSize: 28,
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 1,
          //       child: Text(
          //         'New',
          //         style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // ],
        ),
      ),
      body: _models.length > 0
          ? ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _isLoading ? _models.length + 1 : _models.length,
              itemBuilder: (context, index) {
                if (index < _models.length) {
                  return Slidable(
                    child: InkWell(
                      hoverColor: sgGrey,
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (_) => EmployeeModify(
                              id: _models[index].id,
                            ),
                          ),
                        )
                            .then((_) {
                          _fetchBack();
                        });
                      },
                      child: WhatsAppWidget(
                        id: _models[index].id,
                        title: _models[index].nik,
                        subtitle: _models[index].name,
                        imageAsset: "assets/logo/" +
                            _models[index].companyName +
                            ".png",
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : Center(
              child: Text("Data not found"),
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
