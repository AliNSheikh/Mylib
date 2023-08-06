class searchmodel {
  late String searchname;


  searchmodel({
    required this.searchname,


  });

  searchmodel.fromJson(Map<String, dynamic> json)
  {
    searchname = json['searchname'];
  }

  Map<String, dynamic> toMap() {
    return {
      'searchname': searchname,
    };
  }
}


