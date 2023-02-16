import 'dart:convert';
import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankList extends StatefulWidget {
  const BankList({super.key});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  final scrollController = ScrollController();
  List _models = [];
  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchBank();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(12.0),
      itemCount: isLoading ? _models.length + 1 : _models.length,
      itemBuilder: (context, index) {
        if (index < _models.length) {
          final model = _models[index];
          final name = model['name'];
          final teritory = model['city_id']['name'] +
              ", " +
              model['state_id']['name'] +
              ", " +
              model['district_id']['name'];

          return Card(
            elevation: 5,
            shadowColor: isDark ? sgWhite : sgBlueDark,
            color: isDark ? sgBlue : sgBlueMuda,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Text(
                      name,
                      style: _textTheme.headline4?.copyWith(
                        color: isDark ? sgWhite : sgBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: "Nexa",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Text(
                      teritory,
                      style: _textTheme.headline4?.copyWith(
                        color: isDark ? sgWhite : sgBlack,
                        fontSize: 14,
                        fontFamily: "Nexa",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> fetchBank() async {
    final url =
        "https://api.sampurna-group.com/v1/bank?pagesize=20&page=$_page";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data']['list'] as List;
      setState(() {
        _models = _models + json;
      });
    } else {
      print("Unexpected response");
    }
  }

  Future<void> _scrollListener() async {
    if (isLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      _page = _page + 1;
      await fetchBank();
      setState(() {
        isLoading = false;
      });
    }
  }
}
