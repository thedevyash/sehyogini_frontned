import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sehyogini_frontned/controllers/getPostByID.dart';
import 'package:sehyogini_frontned/controllers/get_posts_controller.dart';
import 'package:sehyogini_frontned/controllers/likeComment_controller.dart';
import 'package:sehyogini_frontned/models/posts.dart';
import 'package:sehyogini_frontned/utils/constants.dart';
import 'package:sehyogini_frontned/utils/login_field.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  GetPostsController getPostsController = Get.put(GetPostsController());
  GetPostByIdController getPostByidController =
      Get.put(GetPostByIdController());
  MakeLikeCommentController likeCommentController =
      Get.put(MakeLikeCommentController());

  void dolike(String id) async {
    var resp = await likeCommentController.doLike(id);
    if (resp) {
      // print(getPostsController.myModel[0].likes!.length);
      // getPostsController.getPostById(id);
      setState(() {});
    }
  }

  void docomment(String id) async {
    var resp = await likeCommentController.doComment(id);
    if (resp) {
      // print(getPostsController.myModel[0].likes!.length);
      // getPostsController.getPostById(id);
      getPostByidController.update();
      setState(() {});
    }
  }

  // Future<Post> getpostdata(int index) async {
  //   return await getPostByidController
  //       .getPostById(getPostsController.myModel[index].sId!);
  // }

  Future<void> onrefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    getPostsController.getPost();
  }

  Future<void> onefreshCom() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(),
          Obx(
            () {
              if (getPostsController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: RefreshIndicator(
                      onRefresh: onrefresh,
                      child: ListView.builder(
                        itemCount: getPostsController.myModel.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // print(getPostsController.myModel[index].likes!.length
                          //     .toString());

                          // getPostsController.getPostById(
                          //     getPostsController.myModel[index].sId!);
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, bottom: 10, top: 10),
                            child: Container(
                              // constraints: BoxConstraints(maxWidth: width * 0.5),
                              color: colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          getPostsController
                                              .myModel[index].author!,
                                          style: styleTitle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      getPostsController
                                          .myModel[index].content!,
                                      style: styleContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                      future: getPostByidController.getPostById(
                                          getPostsController
                                              .myModel[index].sId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    dolike(snapshot.data!.sId!),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(snapshot
                                                        .data!.likes!.length
                                                        .toString()),
                                                    Text(
                                                      "Spark",
                                                      style: styleContent,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // TextButton.icon(

                                              //     label:
                                              //     onPressed: () {},
                                              //     icon: Icon(
                                              //       Icons.thumb_up,
                                              //       size: 18,
                                              //     )),
                                              TextButton.icon(
                                                  label: Text(
                                                    "Gupshup",
                                                    style: styleContent,
                                                  ),
                                                  onPressed: () {
                                                    showModalBottomSheet<
                                                            dynamic>(
                                                        isScrollControlled:
                                                            true,
                                                        showDragHandle: true,
                                                        backgroundColor:
                                                            Colors.white,
                                                        context: context,
                                                        builder: ((context) {
                                                          return StatefulBuilder(
                                                            builder: (context,
                                                                    setModalstate) =>
                                                                Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      constraints: BoxConstraints(
                                                                          minHeight:
                                                                              300,
                                                                          maxHeight: height *
                                                                              0.8),
                                                                      child: snapshot
                                                                              .data!
                                                                              .comments!
                                                                              .isEmpty
                                                                          ? Center(
                                                                              child: Text("Add Your Thoughts..."),
                                                                            )
                                                                          : FutureBuilder(
                                                                              future: getPostByidController.getPostById(getPostsController.myModel[index].sId!),
                                                                              builder: (context, snapshotCom) {
                                                                                if (snapshotCom.hasData) {
                                                                                  return ListView.builder(
                                                                                    itemCount: snapshotCom.data!.comments!.length,
                                                                                    itemBuilder: (context, indexC) {
                                                                                      return ListTile(
                                                                                        leading: const CircleAvatar(
                                                                                          child: Icon(Icons.person),
                                                                                        ),
                                                                                        title: Text(snapshotCom.data!.comments![indexC]["name"]),
                                                                                        subtitle: Text(snapshotCom.data!.comments![indexC]["comment"]),
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                } else {
                                                                                  return Center(
                                                                                    child: CircularProgressIndicator(),
                                                                                  );
                                                                                }
                                                                              },
                                                                            )),
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        LoginField(
                                                                            hint:
                                                                                "Write your thoughts...",
                                                                            textEditingController:
                                                                                likeCommentController.commentcontroller,
                                                                            isfilled: true),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (!likeCommentController.commentcontroller.text.isEmpty) {
                                                                                var resp = await likeCommentController.doComment(snapshot.data!.sId!);
                                                                                setModalstate(() {});
                                                                              }
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.send))
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }));
                                                  },
                                                  icon: const Icon(
                                                    Icons.comment,
                                                    size: 18,
                                                  )),
                                              TextButton.icon(
                                                  label: Text(
                                                    "Keep It",
                                                    style: styleContent,
                                                  ),
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.bookmark,
                                                    size: 18,
                                                  ))
                                            ],
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),

                                    // getPostsController.myModel[index].sId != Null
                                    //     ? FutureBuilder(
                                    //         future: getPostByidController
                                    //             .getPostById(getPostsController
                                    //                 .myModel[index].sId!),
                                    //         builder: (context, snapshot) {
                                    //           if (snapshot.hasData) {

                                    // } else {
                                    //   return Center(
                                    //     child:
                                    //         CircularProgressIndicator(),
                                    //   );
                                    //           }
                                    //         })
                                    //     : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ));
              }
            },
          )
        ],
      ),
    ));
  }
}
