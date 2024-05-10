package com.one.san.user;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

public class NaverProfile
{
    private String id;
    private String nickname;
    private String email;
    private String mobile;
    private String birthyear;
    private String birthday;
    
    public NaverProfile(String jsonResponseBody)
    {
       JsonParser jsonParser = new JsonParser();
       JsonElement element = jsonParser.parse(jsonResponseBody);
       
       this.id = element.getAsJsonObject().get("response").getAsJsonObject().get("id").getAsString();
       this.nickname = element.getAsJsonObject().get("response").getAsJsonObject().get("nickname").getAsString();
       this.email = element.getAsJsonObject().get("response").getAsJsonObject().get("email").getAsString();
       this.mobile = element.getAsJsonObject().get("response").getAsJsonObject().get("mobile").getAsString();
       this.birthyear = element.getAsJsonObject().get("response").getAsJsonObject().get("birthyear").getAsString();
       this.birthday = element.getAsJsonObject().get("response").getAsJsonObject().get("birthday").getAsString();
    }

	public String getId() {
		return id;
	}

	public String getNickname() {
		return nickname;
	}

	public String getEmail() {
		return email;
	}

	public String getMobile() {
		return mobile;
	}

	public String getBirthyear() {
		return birthyear;
	}

	public String getBirthday() {
		return birthday;
	}
    
}