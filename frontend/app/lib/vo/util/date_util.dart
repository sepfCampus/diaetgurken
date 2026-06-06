class DateUtil
{
  static String formatDate(String isoDate)
  {
    final date = DateTime.tryParse(isoDate);

    if(date == null)
    {
      return isoDate;
    }

    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  } 

  static String getCurrentDate()
  {
    return formatDate(DateTime.now().toIso8601String());
  }
}
