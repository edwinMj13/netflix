import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';

import '../../domain/core/failures/main_failures.dart';
import '../../domain/downloads/i_downloads_repo.dart';
import '../../domain/downloads/models/downloads.dart';

import 'package:dio/dio.dart';


@LazySingleton(as: IDownloadRepo)
class DownloadRepository implements IDownloadRepo{
  Future<Either<MainFailures,List<Downloads>>> getDownloadsImages() async {
    try{
      final Response response=await Dio(BaseOptions()).get(ApiEndpoints.downloads);
      if(response.statusCode== 200 || response.statusCode==201){
        final List<Downloads> downloadsList=[];
        for(final raw in response.data){
          downloadsList.add(Downloads.fromJson(raw as Map<String,dynamic>) );
        }
        print(downloadsList);
        return Right(downloadsList);
      }else{
        return const Left(MainFailures.serverFailure());
      }
    }catch(e){
return Left(MainFailures.clientFailure());
    }
  }
}