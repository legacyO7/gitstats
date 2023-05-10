import 'package:easy_listview/easy_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';
import 'package:gitstats/ui/stat_screen/stats_bloc.dart';
import 'package:gitstats/ui/stat_screen/stats_event.dart';
import 'package:gitstats/ui/stat_screen/stats_state.dart';
import 'package:gitstats/ui/stat_screen/widgets/asset_list_widget.dart';
import 'package:gitstats/utils/common_widgets.dart';

class StatsListWidget extends StatefulWidget {
   const StatsListWidget({Key? key,required this.title}) : super(key: key);
   final String title;

  @override
  State<StatsListWidget> createState() => _StatsListWidgetState();
}

class _StatsListWidgetState extends State<StatsListWidget> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController=ScrollController();
     super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: widget.title,refresh: false),
      body: BlocBuilder<StatsBloc, StatsState>(builder: (context, state){
        if(state is StatsStateList){
          if(state.statList.repositoryStatList?.isEmpty??true){
            return emptyData();
          }else{
            return  EasyListView(
              controller: _scrollController,
              itemBuilder: (context,index){
              return listCard(
                  state.statList.repositoryStatList![index].id==state.statList.repositoryStatList?.first.id,
                  repositoryStatModel: state.statList.repositoryStatList![index]);
              },
              itemCount: state.statList.repositoryStatList!.length,
              onLoadMore: ()=>context.read<StatsBloc>().add(StatsEventLoadMore()),
              loadMore: state.loadMore,
              loadMoreItemBuilder: (_)=>
                  Transform.scale(
                      scale: .5,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 10,backgroundColor: Colors.red,))),
              dividerBuilder:(_,__)=>const SizedBox(height: 20,),
            );
          }
        }
        return const SizedBox();
      }),
    );
  }

  Widget listCard(bool isLatest,{required RepositoryStatModel repositoryStatModel})=>
    Container(
      color: isLatest?Colors.green: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(isLatest)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text("Latest release",style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repositoryStatModel.name!,style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700,
                  )),
                  Row(
                    children: [
                      Image.network(repositoryStatModel.repositoryAuthorModel!.avatarUrl!,
                        height: 20,
                        errorBuilder: (_,__,___)=>  const Icon(Icons.person)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(repositoryStatModel.repositoryAuthorModel!.name!),
                      ),
                    ],
                  ),
                  Text('published on ${formattedDateTime(dateTime: repositoryStatModel.publishedAt)}'),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.local_offer_outlined),
                    Text(repositoryStatModel.tag!),
                  ],
                ),
              ),
              if(repositoryStatModel.preRelease??false)
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  margin: const EdgeInsets.only(left: 8,top: 5),
                  child: const Text("Pre-Release")),
            ],
          ),
          if(repositoryStatModel.repositoryAsset!=null)
          Flexible(child: AssetListWidget(repositoryAssetModel: repositoryStatModel.repositoryAsset!))
        ],
      ),
    );
}