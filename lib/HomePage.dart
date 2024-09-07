import 'dart:convert';
import 'package:flutter/material.dart';
import './AppTabs.dart';
import './AppColor.dart' as AppColors;
import './BooksCard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List<dynamic> popularBooks = [];
  List<dynamic> books = [];
  ScrollController? _scrollController;
  TabController? _tabController;

  Future<void> readData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonFolder/popularbooks.json');
    setState(() {
      popularBooks = json.decode(jsonString);
    });

    String booksJsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonFolder/books.json');
    setState(() {
      books = json.decode(booksJsonString);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Home Page Icon Area
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      'https://cdn2.iconfinder.com/data/icons/editorial-design-5/24/grid_glyph-512.png',
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Icon(Icons.notifications),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Popular Books Heading
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: const Text(
                      'Popular Books',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              // Popular Books Images
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: popularBooks.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage('${popularBooks[i]['img']}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Tab Bar Area
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30, left: 10),
                            child: TabBar(
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              isScrollable: true,
                              indicator: const BoxDecoration(), // Removes the bottom line
                              tabs: const [
                                AppTabs(color: Colors.yellow, text: 'New'),
                                AppTabs(color: Colors.red, text: 'Popular'),
                                AppTabs(color: Colors.blue, text: 'Trending'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (_, i) {
                          return BooksCard(
                            imagePath: books[i]['img'],
                            bookRating: books[i]['rating'],
                            bookTitle: books[i]['title'],
                            bookText: books[i]['text'],
                          );
                        },
                      ),
                      const Center(child: Text("Popular Books")),
                      const Center(child: Text("Trending Books")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
