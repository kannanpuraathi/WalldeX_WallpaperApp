import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/gridview_widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List images = [];
  int num = 1;
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  fetchapi(String searchQuery) async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$searchQuery&per_page=80&page=$num'),
        headers: {
          'Authorization':
          '563492ad6f91700001000001b03f9cdc3d19478c8e3304e60dcae7be'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = (result['photos']);
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
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Container(
                padding: const EdgeInsets.only(top: 5),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextField(
                    onSubmitted: (value){
                      fetchapi(searchController.text);
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if(!currentFocus.hasPrimaryFocus){
                        currentFocus.unfocus();
                      }
                      if (_scrollController.hasClients) {
                        final position =
                            _scrollController.position.minScrollExtent;
                        _scrollController.animateTo(
                          position,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    controller: searchController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          fetchapi(searchController.text);
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if(!currentFocus.hasPrimaryFocus){
                            currentFocus.unfocus();
                          }
                          if (_scrollController.hasClients) {
                            final position =
                                _scrollController.position.minScrollExtent;
                            _scrollController.animateTo(
                              position,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                      hintText: 'Search..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              )),
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