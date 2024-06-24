import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failures.freezed.dart';
//part 'main_failures.g.dart';
@freezed
class MainFailures with _$MainFailures{
   const factory MainFailures.clientFailure()=_ClientFailures;
   const factory MainFailures.serverFailure()=_ServerFailures;
}