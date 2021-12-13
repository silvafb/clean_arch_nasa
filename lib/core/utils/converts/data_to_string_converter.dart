class DateToStringConverter {
  static String convert(DateTime date){
    var dataSplitted = date.toString().split(" ");
    return dataSplitted.first;
  }
}