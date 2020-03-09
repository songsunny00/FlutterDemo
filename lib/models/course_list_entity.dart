class CourseListObjData {
	Map userInfo;
	List<CourseListData> courselist;

	CourseListObjData({this.userInfo, this.courselist});

	CourseListObjData.fromJson(Map<String, dynamic> json) {
		userInfo = json['userInfo'];
		if (json['courselist'] != null) {
			courselist = new List<CourseListData>();(json['courselist'] as List).forEach((v) { courselist.add(new CourseListData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userInfo'] = this.userInfo;
		if (this.courselist != null) {
      data['courselist'] =  this.courselist.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CourseListData {
	String id;
	String name;
	String short_description;
	String pic;
	String numbers; //学习人数
	int type;
	String share;
	int is_learned; //是否学习过0没有，1有
	int learn_rate;
	String is_pay; //是否付费0-免费
	String level;
	String skill_id;
	String skill_name;
	String skill_pic;
	String skill_color;

	CourseListData({this.id, this.name, this.short_description, this.pic, this.numbers, this.type, this.share, this.is_learned, this.learn_rate, this.is_pay, this.level, this.skill_id, this.skill_name, this.skill_pic, this.skill_color});

	CourseListData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		short_description = json['short_description'];
		pic = json['pic'];
		numbers = json['numbers'];
		type = json['type'];
		share = json['share'];
		is_learned = json['is_learned'];
		learn_rate = json['learn_rate'];
		is_pay = json['is_pay'];
		level = json['level'];
		skill_id = json['skill_id'];
		skill_name = json['skill_name'];
		skill_pic = json['skill_pic'];
		skill_color = json['skill_color'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['short_description'] = this.short_description;
		data['pic'] = this.pic;
		data['numbers'] = this.numbers;
		data['type'] = this.type;
		data['share'] = this.share;
		data['is_learned'] = this.is_learned;
		data['learn_rate'] = this.learn_rate;
		data['is_pay'] = this.is_pay;
		data['level'] = this.level;
		data['skill_id'] = this.skill_id;
		data['skill_name'] = this.skill_name;
		data['skill_pic'] = this.skill_pic;
		data['skill_color'] = this.skill_color;
		return data;
	}
}