class CommonData {
  // background gradient
  static Map<String, dynamic> subwayData = null;
  static List<Map<String, String>> meters = [
      {"100": "100m"},
      {"300": "300m"},
      {"500": "500m"},
      {"1000": "1km"},
      {"2000": "2km"}
  ];
  static setSubwayData(data){
    CommonData.subwayData = addSubwayName(data);
    print("@@@");
    print(data);
  }
  static Map<String, dynamic> addSubwayName(data){
    var meta = {
      "1"  :  "1호선",
      "2"  :  "2호선",
      "3"  :  "3호선",
      "4"  :  "4호선",
      "5"  :  "5호선",
      "6"  :  "6호선",
      "7"  :  "7호선",
      "8"  :  "8호선",
      "9"  :  "9호선",
      "I"  :  "인천1호선",
      "K"  :  "경의중앙선",
      "B"  :  "분당선",
      "A"  :  "공항철도",
      "G"  :  "경춘선",
      "S"  :  "신분당선",
      "SU" :  "수인선",
      "E"  :  "에버라인",
      "I2" :  "인천2호선",
      "KK" :  "경강선",
      "T"  :  "테스트",
      "U"  :  "의정부",
      "UI" :  "우이신설선"
    };
    var array = data["DATA"];
    for(var i = 0 ; i < array.length; i++){
      array[i]["line_nm"] = meta[array[i]["line_num"]];
    }
    return data;
  }
}