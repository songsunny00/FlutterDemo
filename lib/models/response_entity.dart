class ResponseEntity {
	dynamic data;
	int status;
  int code;
	String msg;

	ResponseEntity({this.data, this.status, this.msg});

	ResponseEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? json['data'] : null;
		status = json['status'];
    code = json['code'];
		msg = json['msg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['status'] = this.status;
    data['code'] = this.code;
		data['msg'] = this.msg;
		return data;
	}
}