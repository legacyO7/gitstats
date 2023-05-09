import 'package:flutter/material.dart';
import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';
import 'package:gitstats/ui/stat_screen/widgets/asset_list_widget.dart';

class StatsListWidget extends StatelessWidget {
   StatsListWidget({Key? key,required this.statList}) : super(key: key);

  StatListModel statList;

  @override
  Widget build(BuildContext context) {
    return
      statList.repositoryStatList?.isEmpty??false?
      emptyData():
      Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.separated(itemBuilder: (context,index){
            return listCard(repositoryStatModel: statList.repositoryStatList![index]);
          }, separatorBuilder: (_,__)=>const SizedBox(height: 20,),
          itemCount: statList.repositoryStatList!.length,
          shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget listCard({required RepositoryStatModel repositoryStatModel})=>
    Container(
      color: repositoryStatModel.id==statList.repositoryStatList?.first.id?Colors.green: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(repositoryStatModel.id==statList.repositoryStatList?.first.id)
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
              Text(repositoryStatModel.name!,style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700,
              )),
              listItem(text: ' by ${repositoryStatModel.repositoryAuthorModel!.name!}'),
              Row(
                children: [
                  const Icon(Icons.local_offer_outlined),
                  Text(repositoryStatModel.tag!),
                ],
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

Widget listItem({required String text, int flex=1,bool isHeading=false}){
  return Expanded(
      flex: flex,
      child: Text(text,style: TextStyle(
          fontWeight: isHeading?FontWeight.w700:FontWeight.w500,
          fontSize: isHeading?20:14
      ),));
}

Widget emptyData()=>
    Center(child: const Text("No Data"));
