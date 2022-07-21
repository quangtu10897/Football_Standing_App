import 'models/football.dart';
import 'fetchData.dart';


void main() async {
  List<Football> listFootball = await fetchData();
  for (int i = 0; i < listFootball[0].data.standings!.length; i++) {
    print(listFootball[0].data.standings![i].team.name+'===>'+listFootball[0].data.standings![i].team.logo[0].href);
    }
}
