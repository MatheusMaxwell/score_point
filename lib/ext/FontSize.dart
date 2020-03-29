
class FontSize {

  static var small = getValue(12, 16, 8);
  static var medium = getValue(18, 22, 14);
  static var big = getValue(26, 28, 22);
  static var ultraBig = getValue(36, 40, 30);


  static getValue(double value, double max, double min){
    if(value < max && value > min){
      return value;
    } else if(value < min){
      return min;
    } else {
      return max;
    }
  }

}