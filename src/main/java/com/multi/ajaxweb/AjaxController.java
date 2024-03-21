package com.multi.ajaxweb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.domain.NewsVO;
import com.multi.domain.UserVO;
import com.multi.service.SampleService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class AjaxController {

	private final SampleService sampleService;
	
	@RequestMapping("/ajaxView")
	public void ajaxView() {
		
	}
	
	@GetMapping(value="/ajaxText", produces= {"text/plain; charset=utf-8"})
	@ResponseBody//뷰네임을 반환하는것이 아닌 응답데이터를 반환한다는 의미로 붙여준다
	public String ajaxResponseText(@RequestParam(defaultValue="") String phone) {
		log.info("phone: "+phone);
		
		//return "10#김철수#서울#"+phone;
		if(phone.startsWith("1")) {
			return "<img src='resources/noimage.png'>";
		}else {
			return "<img src='resources/backend.png'>";
		}
	}//------------------
	
	@GetMapping(value="/ajaxXml", produces= {"text/xml; charset=utf-8"})
	@ResponseBody
	public Map<String, String> ajaxResponseXml(@RequestParam(defaultValue="") String phone){
		Map<String, String> map = new HashMap<>();
		map.put("no", "55");
		map.put("name", "고고공");
		map.put("addr", "내 마음속");
		map.put("phone", phone);
		return map;
	}//-----------------
	
	@RequestMapping(value="/ajaxJson", produces= {"application/json; charset=utf-8"})
	@ResponseBody
	public UserVO ajaxResponseJson(UserVO user) {
		log.info("user: "+user);//파라미터 데이터를 받는다(연락처, 주소)
		user.setNo(88);
		user.setName("히히히");
		user.setAddr("서울");
		user.setPhone("3333-1234");
		
		return user;
	}
	
	@RequestMapping(value="/ajaxJsonList", produces={"application/json; charset=utf-8"})
	@ResponseBody
	public List<UserVO> ajaxResponseJsonList(UserVO user){
		log.info("json형식 파라미터 user: "+user);
		
		List<UserVO> arr=new ArrayList<>();
		arr.add(new UserVO(10,"홍길동","수원 1번지","2222"));
		arr.add(new UserVO(20,"전책영","서울 1번지","3222"));
		arr.add(new UserVO(30,"허소르","서울 2번지","4222"));
		user.setNo(40);
		user.setName("시나진");
		arr.add(user);
		
		return arr;
	}//-----------------
	
	@PostMapping(value="/news_dbCreate", produces= {"application/json; charset=utf-8"})
	@ResponseBody
	public ModelMap ajaxRssNewsInsert(NewsVO vo) {
		log.info("vo: "+vo);
		int n=sampleService.createNews(vo);
		
		ModelMap map=new ModelMap();
		map.addAttribute("result","ok");
		return map;
	}
	
	@RequestMapping("/weather")
	public void weather() {
		
	}
	
}////////////////////////////
