import 'package:flutter/material.dart';
import 'package:gitstats/ui/stat_screen/models/stat_list_model.dart';
import 'package:gitstats/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AssetListWidget extends StatelessWidget {
  const AssetListWidget({Key? key, required this.repositoryAssetModel}) : super(key: key);

  final List<RepositoryAssetModel> repositoryAssetModel;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context,index){
      return listCard(repositoryAssetModel[index]);
    },shrinkWrap: true,
      itemCount: repositoryAssetModel.length,
    );
  }

  Widget listCard(RepositoryAssetModel repositoryAssetModel){
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Colors.grey[600]!,
              Colors.grey[800]!
            ],
            begin: Alignment.center,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(children: [
              listItem(text: "${repositoryAssetModel.name}"),
              Text(getSize(bytes: repositoryAssetModel.size!.toDouble())),
              if(repositoryAssetModel.url!.isNotEmpty)
              IconButton(onPressed: ()=>_launchUrl(repositoryAssetModel.url), icon: const Icon(Icons.download_outlined))
            ],),
            if(repositoryAssetModel.updatedAt!.isNotEmpty)
            Row(
              children: [
                listItem(text: "updated at ${formattedDateTime(dateTime: repositoryAssetModel.updatedAt)}"),
                  repositoryAssetModel.downloads!<1?
                const Text("No Downloads"):
                Text.rich(TextSpan(
                  text: "Downloaded ",
                  children: [
                    TextSpan(
                      text: "${repositoryAssetModel.downloads}",
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    const TextSpan(text: ' times')
                  ]
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getSize({required double bytes}){
    if(bytes<1000){
      return "$bytes B";
    }

    List<String> dataUnit=['KB', 'MB', 'GB', 'TB'];
    int count=0;
    String size='-';
     while(count<4){
      bytes=bytes/1024;
      if(bytes<1000||count==4){
        size='${bytes.toStringAsFixed(2)} ${dataUnit[count]}';
        break;
      }
      count++;
    }
    return size;
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
