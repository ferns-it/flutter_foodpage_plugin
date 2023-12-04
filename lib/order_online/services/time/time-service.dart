import '../../constants/api_endpoints.dart';
import '../../model/time/time_data.dart';
import '../base_client.dart';

class TimeService {
    static Future<TimeData?> fetchTimeData() async {
    final response =
        await BaseClient.get(api: ApiEndpoints.timeDetails, needAuth: true);
    if (response == null) return null;
    return TimeData.fromJson(response);
  }
  
}