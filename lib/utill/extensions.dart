import 'package:intl/intl.dart';


//make first letter capital
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

//format date & time
extension DataExtention on DateTime {
  String dateFormat() {
    return DateFormat("dd-MMM ").format(this);
  }}
extension DataTimeExtention on DateTime {
  String dateTimeFormat() {
    return DateFormat("yyyy-MM-dd hh:mm").format(this);
  }
}  extension IsoDataTimeExtention on String {
  DateTime isoDateTimeFormat() {


    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(this, true).toLocal();
  }
}

extension TimeExtention on DateTime {
  String timeFormat() {
    return DateFormat("hh:mm a").format(this);
  }
}



extension LearnTypID on String {

  int get id {
    switch (this) {
      case "حضوري":
        return 1;
      case "عن بعد ":
        return 2;
      case 'الكل':
        return 3;

      default:
        return 1;
    }
  }
}
