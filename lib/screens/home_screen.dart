import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walldex_app/screens/search_screen.dart';
import 'package:walldex_app/widgets/gridview_widget.dart';
import 'package:walldex_app/widgets/themebutton_widget.dart';
import 'package:walldex_app/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [];
  int num = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchapi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getmoredata();
      }
    });
  }

  _getmoredata() {
    num = num + 1;
    fetchapi();
  }

  fetchapi() async {
    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=$num'),
        headers: {
          'Authorization':
          '563492ad6f91700001000001b03f98c8e3304e60dcae7be'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
    if (kDebugMode) {
      print(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleSpacing: 0.0,
            title: const TitleWidget(),
            actions: [
              Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.search,
                      size: 35,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const ChangeThemeButtonWidget(),
                ],
              ),
            ],
          ),
        ],
        body: Stack(
          children: [
            GridViewWidget(
              images: images,
              scroll: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
