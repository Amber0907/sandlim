package com.one.san.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.one.san.user.NaverProfile;

@Component
public class NaverApi {
	private static final String NAVER_LOGOUT_URL = "https://nid.naver.com/nidlogin.logout";
	
	@Value("${naver.api_key}")
	private String naverApiKey;

	@Value("${naver.redirect_uri}")
	private String naverRedirectUri;

	@Value("${naver.client_secret}")
	private String naverClientSecret;

	public String getNaverApiKey() {
		return naverApiKey;
	}

	public void setNaverApiKey(String naverApiKey) {
		this.naverApiKey = naverApiKey;
	}

	public String getNaverRedirectUri() {
		return naverRedirectUri;
	}

	public void setNaverRedirectUri(String naverRedirectUri) {
		this.naverRedirectUri = naverRedirectUri;
	}

	public String getNaverClientSecret() {
		return naverClientSecret;
	}

	public void setNaverClientSecret(String naverClientSecret) {
		this.naverClientSecret = naverClientSecret;
	}

	public String getAccessToken(String code, String state) {
		String reqUrl = "https://nid.naver.com/oauth2.0/token";
		RestTemplate restTemplate = new RestTemplate();

		// HttpHeader Object
		HttpHeaders headers = new HttpHeaders();

		// HttpBody Object
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", naverApiKey);
		params.add("client_secret", naverClientSecret);
		params.add("code", code);
		params.add("state", state);

		// http body params 와 http headers 를 가진 엔티티
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(params, headers);

		// reqUrl로 Http 요청, POST 방식
		ResponseEntity<String> response = restTemplate.exchange(reqUrl, HttpMethod.POST, naverTokenRequest,
				String.class);

		String responseBody = response.getBody();
		JsonObject asJsonObject = JsonParser.parseString(responseBody).getAsJsonObject();
		return asJsonObject.get("access_token").getAsString();
	}

	public NaverProfile getUserInfo(String accessToken) {
		String reqUrl = "https://openapi.naver.com/v1/nid/me";

		RestTemplate restTemplate = new RestTemplate();

		// HttpHeader 오브젝트
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);

		HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity<>(headers);

		ResponseEntity<String> response = restTemplate.exchange(reqUrl, HttpMethod.POST, naverProfileRequest,
				String.class);

		System.out.println("response = " + response);
		NaverProfile naverProfile = new NaverProfile(response.getBody());

		return naverProfile;
	}
	
	public String requestToServer(String apiURL, String headerStr) throws IOException {
	    URL url = new URL(apiURL);
	    HttpURLConnection con = (HttpURLConnection)url.openConnection();
	    con.setRequestMethod("GET");
	    System.out.println("header Str: " + headerStr);
	    if(headerStr != null && !headerStr.equals("") ) {
	      con.setRequestProperty("Authorization", headerStr);
	    }
	    int responseCode = con.getResponseCode();
	    BufferedReader br;
	    System.out.println("responseCode="+responseCode);
	    if(responseCode == 200) { // 정상 호출
	      br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    } else {  // 에러 발생
	      br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	    }
	    String inputLine;
	    StringBuffer res = new StringBuffer();
	    while ((inputLine = br.readLine()) != null) {
	      res.append(inputLine);
	    }
	    br.close();
	    if(responseCode==200) {
	    	String new_res=res.toString().replaceAll("&#39;", "");
			 return new_res; 
	    } else {
	      return null;
	    }
	  }
	
	@RequestMapping
	public void naverLogout(Model model){
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpGet get = new HttpGet(NAVER_LOGOUT_URL);
		model.addAttribute("naverInfo", null);
		model.addAttribute("msg", "ok");
		try {
			HttpResponse res = client.execute(get); 
			res = client.execute(get); 
		}catch (Exception e) { 
			e.printStackTrace(); 
		} 
	}
	
	@Override
	public String toString() {
		return "NaverApi [naverApiKey=" + naverApiKey + ", naverRedirectUri=" + naverRedirectUri
				+ ", naverClientSecret=" + naverClientSecret + "]";
	}

}
