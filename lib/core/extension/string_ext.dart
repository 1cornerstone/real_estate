
extension strExt on String{

  toDecimal(){
    String val = replaceAll(RegExp(r'\D'), '');
    return val.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ' ');
  }

}


