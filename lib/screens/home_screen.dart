import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peace_pulse/data/remote/response/Status.dart';
import 'package:peace_pulse/models/audioModel.dart';
import 'package:peace_pulse/screens/details_screen.dart';
import 'package:peace_pulse/utils/app_colors.dart';
import 'package:peace_pulse/utils/constants.dart';
import 'package:peace_pulse/viewModels/audiosListVM.dart';
import 'package:peace_pulse/widget/LoadingWidget.dart';
import 'package:peace_pulse/widget/MyErrorWidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudiosListVM viewModel = AudiosListVM();

  late ScrollController _scrollController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (500 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    viewModel.fetchMovies();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appScreensBg,
        body: ChangeNotifierProvider<AudiosListVM>.value(
          value: viewModel,
          child: Consumer<AudiosListVM>(builder: (context, viewModel, _) {
            switch (viewModel.audiosMain.status) {
              case Status.LOADING:
                print("MARAJ :: LOADING");
                return LoadingWidget();
              case Status.ERROR:
                print("MARAJ :: ERROR");
                return MyErrorWidget(viewModel.audiosMain.message ?? "NA");
              case Status.COMPLETED:
                print("MARAJ :: COMPLETED");
                print("List Size ${viewModel.audiosMain.data!.length}");

                // return _getAudiosList(viewModel.audiosMain.data?.audios);

                return Center(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.appDark,
                        floating: false,
                        expandedHeight: 500.0,
                        actions: [
                          IconButton(
                              onPressed: () {
                                _onProfilePressed();
                              },
                              icon: SvgPicture.asset(
                                Constants.icProfile,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.appScreensBg, BlendMode.srcIn),
                              )),
                        ],
                        leading: IconButton(
                            onPressed: () {
                              _onMenuPressed();
                            },
                            icon: SvgPicture.asset(
                              Constants.icMenu,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.appScreensBg, BlendMode.srcIn),
                            )),
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            'What do you NEED today?',
                            style: TextStyle(
                                fontSize: 14,
                                color: isShrink
                                    ? AppColors.appScreensBg
                                    : AppColors.appText,
                                fontWeight: FontWeight.bold),
                          ),
                          background:
                              Image.asset("assets/images/screen_bg.jpg"),
                          centerTitle: true,
                        ),
                      ),
                      SliverPadding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 0, top: 16, bottom: 16),
                          sliver: SliverMasonryGrid.count(
                            childCount: 20,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return Tile(
                                myAudio: viewModel.audiosMain.data![index],
                                index: index,
                                extent: (index % 5 + 3) * 100,
                              );
                            },
                          )),
                      // SliverGrid(
                      //   delegate: SliverChildBuilderDelegate(
                      //     (context, index) {
                      //       return Container(
                      //         margin: index % 2 == 0
                      //             ? const EdgeInsets.fromLTRB(20, 20, 10, 0)
                      //             : const EdgeInsets.fromLTRB(10, 20, 20, 0),
                      //         alignment: Alignment.center,
                      //         color: Colors.teal[100 * (index % 9)],
                      //         child: Text('grid item $index'),
                      //       );
                      //     },
                      //     childCount: 30,
                      //   ),
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //     // mainAxisSpacing: 15,

                      //     // crossAxisSpacing: 15,
                      //     childAspectRatio: 1.0,
                      //   ),
                      // ),
                    ],
                  ),
                );
              default:
                return MyErrorWidget(viewModel.audiosMain.message ?? "NA");
            }
          }),
        ));
  }

  void _onMenuPressed() {
    print("menu button clicked");
  }

  void _onProfilePressed() {
    print("profile button clicked");
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.myAudio,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final MyAudio myAudio;
  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
        height: extent,
        margin: const EdgeInsets.only(left: 16, top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.teal[100 * (index % 9)],
        ), //backgroundColor ?? AppColors.appDark,
        child: Stack(
          children: [
            Material(
                borderRadius: BorderRadius.circular(16.0),
                child: InkWell(
                    onTap: () {
                      _onNavigatePressed(context, myAudio);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: FadeInImage(
                            image: NetworkImage(myAudio.imageUrl),
                            placeholder: const AssetImage(""),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset("", fit: BoxFit.cover);
                            },
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover)))),
            Center(
                child: CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              child: IconButton(
                  onPressed: () {
                    _onPlayPressed();
                  },
                  icon: SvgPicture.asset(
                    Constants.icPlay,
                  )),
              // child: Text('$index', style: const TextStyle(fontSize: 20)),
            ))
          ],
        ));

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }

  void _onPlayPressed() {
    print("Play button clicked");
  }

  void _onNavigatePressed(BuildContext context, MyAudio audioObj) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsScreen(myAudio: audioObj)),
    );

    // print("_onNavigatePressed button clicked");
  }
}

// CustomScrollView(
//             slivers: <Widget>[
//               SliverAppBar(
//                 pinned: true,
//                 floating: false,
//                 expandedHeight: 500.0,
//                 // leading: const Icon(
//                 //   Icons.menu_rounded,
//                 //   color: AppColors.appButtonBg,
//                 // ),

//                 flexibleSpace: FlexibleSpaceBar(
//                   title: const Text('Basic Slivers'),
//                   background: Image.asset("assets/images/screen_bg.jpg"),
//                   centerTitle: true,
//                 ),
//               ),
//               SliverFixedExtentList(
//                 itemExtent: 50,
//                 delegate: SliverChildListDelegate([
//                   Container(color: Colors.red),
//                   Container(color: Colors.green),
//                   Container(color: Colors.blue),
//                 ]),
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     return Container(
//                       height: 50,
//                       alignment: Alignment.center,
//                       color: Colors.orange[100 * (index % 9)],
//                       child: Text('orange $index'),
//                     );
//                   },
//                   childCount: 9,
//                 ),
//               ),
//               SliverGrid(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     return Container(
//                       alignment: Alignment.center,
//                       color: Colors.teal[100 * (index % 9)],
//                       child: Text('grid item $index'),
//                     );
//                   },
//                   childCount: 30,
//                 ),
//                 // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 //   maxCrossAxisExtent: 200.0,
//                 //   mainAxisSpacing: 10.0,
//                 //   crossAxisSpacing: 10.0,
//                 //   childAspectRatio: 4.0,
//                 // ),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 15,
//                   crossAxisSpacing: 15,
//                   childAspectRatio: 2.0,
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Container(
//                   color: Colors.yellow,
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Grid Header', style: TextStyle(fontSize: 24)),
//                 ),
//               ),
//               SliverGrid.count(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//                 childAspectRatio: 4.0,
//                 children: <Widget>[
//                   Container(color: Colors.red),
//                   Container(color: Colors.green),
//                   Container(color: Colors.blue),
//                   Container(color: Colors.red),
//                   Container(color: Colors.green),
//                   Container(color: Colors.blue),
//                 ],
//               ),
//               SliverGrid.extent(
//                 maxCrossAxisExtent: 200,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//                 childAspectRatio: 1.0,
//                 children: <Widget>[
//                   Container(color: Colors.pink),
//                   Container(color: Colors.indigo),
//                   Container(color: Colors.orange),
//                   Container(color: Colors.pink),
//                   Container(color: Colors.indigo),
//                   Container(color: Colors.orange),
//                 ],
//               ),
//             ],
//           )
