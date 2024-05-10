package com.one.san.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component
public class KakaoApi {
	
	@Value("${kakao.api_key}")
	private String kakaoApiKey;

	@Value("${kakao.redirect_uri}")
	private String kakaoRedirectUri;
	
	@Value("${kakao.admin_key}")
	private String adminKey;
	
	@Value("${kakao.javascript_key}")
	private String javascriptKey;

	public enum HttpMethodType { POST, GET, DELETE }

    private final String API_SERVER_HOST  = "https://kapi.kakao.com";

    private final String USER_LOGOUT_PATH = "/v1/user/logout";
    private final String USER_IDS_PATH = "/v1/user/ids";
    private final String USER_UNLINK_PATH = "/v1/user/unlink";

    private final String PUSH_REGISTER_PATH = "/v1/push/register";
    private final String PUSH_TOKENS_PATH = "/v1/push/tokens";
    private final String PUSH_DEREGISTER_PATH = "/v1/push/deregister";
    private final String PUSH_SEND_PATH = "/v1/push/send";

	private String accessToken;
    
    
    private final List<String> adminApiPaths = new ArrayList<String>();

    {
        adminApiPaths.add(USER_IDS_PATH);
        adminApiPaths.add(PUSH_REGISTER_PATH);
        adminApiPaths.add(PUSH_TOKENS_PATH);
        adminApiPaths.add(PUSH_DEREGISTER_PATH);
        adminApiPaths.add(PUSH_SEND_PATH);
    }
	
    public String getAdminKey() {
		return adminKey;
	}

	public void setAdminKey(String adminKey) {
		this.adminKey = adminKey;
	}

	public String getJavascriptKey() {
		return javascriptKey;
	}

	public void setJavascriptKey(String javascriptKey) {
		this.javascriptKey = javascriptKey;
	}

	public String getAccessToken() {
    	return accessToken;
    }
    
    public void setAccessToken(String accessToken) {
    	this.accessToken = accessToken;
    }
	
	public String getKakaoApiKey() {
		return kakaoApiKey;
	}

	public void setKakaoApiKey(String kakaoApiKey) {
		this.kakaoApiKey = kakaoApiKey;
	}

	public String getKakaoRedirectUri() {
		return kakaoRedirectUri;
	}

	public void setKakaoRedirectUri(String kakaoRedirectUri) {
		this.kakaoRedirectUri = kakaoRedirectUri;
	}

	
	public String getAccessToken(String code) {
	    String accessToken = "";
	    String refreshToken = "";
	    String reqUrl = "https://kauth.kakao.com/oauth/token";

	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        //필수 헤더 세팅
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setDoOutput(true); //OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.

	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
	        
	        //필수 쿼리 파라미터 세팅
	        sb.append("grant_type=authorization_code");
	        sb.append("&client_id=").append(kakaoApiKey);
	        sb.append("&redirect_uri=").append(kakaoRedirectUri);
	        sb.append("&code=").append(code);

	        bw.write(sb.toString());
	        bw.flush();

	        int responseCode = conn.getResponseCode();

	        BufferedReader br;
	        if (responseCode >= 200 && responseCode <= 300) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        String result = responseSb.toString();

	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        accessToken = element.getAsJsonObject().get("access_token").getAsString();
	        refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

	        br.close();
	        bw.close();
	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return accessToken;
	}
	
	
	public HashMap<String, Object> getUserInfo(String accessToken) {
	    HashMap<String, Object> userInfo = new HashMap<>();
	    String reqUrl = "https://kapi.kakao.com/v2/user/me";
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	        int responseCode = conn.getResponseCode();

	        BufferedReader br;
	        if (responseCode >= 200 && responseCode <= 300) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        String result = responseSb.toString();

	        JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			
			System.out.println("element 값 확인: "+element);

	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        String id = element.getAsJsonObject().get("id").getAsString();

	        
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
	        String name = kakaoAccount.getAsJsonObject().get("name").getAsString();
	        String phone_number = kakaoAccount.getAsJsonObject().get("phone_number").getAsString();
	        String age_range = kakaoAccount.getAsJsonObject().get("age_range").getAsString();
	        String birthyear = kakaoAccount.getAsJsonObject().get("birthyear").getAsString();
	        String birthday = kakaoAccount.getAsJsonObject().get("birthday").getAsString();
//	        String has_gender = kakaoAccount.getAsJsonObject().get("has_gender").getAsString();
	        

	        userInfo.put("id", id);
	        userInfo.put("nickname", nickname);
	        userInfo.put("email", email);
	        userInfo.put("name", name);
	        userInfo.put("phone_number", phone_number);
	        userInfo.put("age_range", age_range);
	        userInfo.put("birthyear", birthyear);
	        userInfo.put("birthday", birthday);
	        

	        br.close();

	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return userInfo;
	}
	
	public String unlink() {
        return request(HttpMethodType.POST, USER_UNLINK_PATH);
    }
	
	public String logout() {
        return request(HttpMethodType.POST, USER_LOGOUT_PATH);
    }
	
	
	public String request(final HttpMethodType httpMethod, final String apiPath) {
        return request(httpMethod, apiPath, null);
    }

    public String request(HttpMethodType httpMethod, final String apiPath, final String params) {

        String requestUrl = API_SERVER_HOST + apiPath;
        if (httpMethod == null) {
            httpMethod = HttpMethodType.GET;
        }
        if (params != null && params.length() > 0
                && (httpMethod == HttpMethodType.GET || httpMethod == HttpMethodType.DELETE)) {
            requestUrl += params;
        }

        HttpsURLConnection conn;
        OutputStreamWriter writer = null;
        BufferedReader reader = null;
        InputStreamReader isr = null;

        try {
            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod(httpMethod.toString());

            if (adminApiPaths.contains(apiPath)) {
                conn.setRequestProperty("Authorization", "KakaoAK " + this.adminKey);
            } else {
            	System.out.println("this.accessToken : " + this.accessToken);
                conn.setRequestProperty("Authorization", "Bearer " + this.accessToken);
            }

            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("charset", "utf-8");
            
            //20240507_ym추가 시작
            if(requestUrl.contains("/unlink")) {
            	conn.setDoInput(true);
            	conn.setUseCaches(false);
            	conn.setDefaultUseCaches(false);
            	conn.connect();
            }
            //20240507_ym추가 종료

            if (params != null && params.length() > 0 && httpMethod == HttpMethodType.POST) {
                conn.setDoOutput(true);
                writer = new OutputStreamWriter(conn.getOutputStream());
                writer.write(params);
                writer.flush();
            }

            final int responseCode = conn.getResponseCode();
            System.out.println(String.format("\nSending '%s' request to URL : %s", httpMethod, requestUrl));
            System.out.println("Response Code : " + responseCode);
            if (responseCode == 200)
                isr = new InputStreamReader(conn.getInputStream());
            else
                isr = new InputStreamReader(conn.getErrorStream());

            reader = new BufferedReader(isr);
            final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            System.out.println(buffer.toString());
            
            
            return buffer.toString();

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }
	
	
	@Override
	public String toString() {
		return "KakaoApi [kakaoApiKey=" + kakaoApiKey + ", kakaoRedirectUri=" + kakaoRedirectUri + "]";
	}
	
}
