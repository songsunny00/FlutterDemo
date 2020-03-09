class UserEntity {
	UserData data;
	int status;
	String msg;

	UserEntity({this.data, this.status, this.msg});

	UserEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
		status = json['status'];
		msg = json['msg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['status'] = this.status;
		data['msg'] = this.msg;
		return data;
	}
}

class UserData {
	String password;
	List<Null> chapterTops;
	String icon;
	bool admin;
	List<int> collectIds;
	int id;
	int type;
	String email;
	String token;
	String username;

	UserData({this.password, this.chapterTops, this.icon, this.admin, this.collectIds, this.id, this.type, this.email, this.token, this.username});

	UserData.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		icon = json['icon'];
		admin = json['admin'];
		collectIds = json['collectIds']?.cast<int>();
		id = json['id'];
		type = json['type'];
		email = json['email'];
		token = json['token'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['icon'] = this.icon;
		data['admin'] = this.admin;
		data['collectIds'] = this.collectIds;
		data['id'] = this.id;
		data['type'] = this.type;
		data['email'] = this.email;
		data['token'] = this.token;
		data['username'] = this.username;
		return data;
	}
}