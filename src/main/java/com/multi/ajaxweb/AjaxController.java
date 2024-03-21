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
	@ResponseBody//������� ��ȯ�ϴ°��� �ƴ� ���䵥���͸� ��ȯ�Ѵٴ� �ǹ̷� �ٿ��ش�
	public String ajaxResponseText(@RequestParam(defaultValue="") String phone) {
		log.info("phone: "+phone);
		
		//return "10#��ö��#����#"+phone;
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
		map.put("name", "����");
		map.put("addr", "�� ������");
		map.put("phone", phone);
		return map;
	}//-----------------
	
	@RequestMapping(value="/ajaxJson", produces= {"application/json; charset=utf-8"})
	@ResponseBody
	public UserVO ajaxResponseJson(UserVO user) {
		log.info("user: "+user);//�Ķ���� �����͸� �޴´�(����ó, �ּ�)
		user.setNo(88);
		user.setName("������");
		user.setAddr("����");
		user.setPhone("3333-1234");
		
		return user;
	}
	
	@RequestMapping(value="/ajaxJsonList", produces={"application/json; charset=utf-8"})
	@ResponseBody
	public List<UserVO> ajaxResponseJsonList(UserVO user){
		log.info("json���� �Ķ���� user: "+user);
		
		List<UserVO> arr=new ArrayList<>();
		arr.add(new UserVO(10,"ȫ�浿","���� 1����","2222"));
		arr.add(new UserVO(20,"��å��","���� 1����","3222"));
		arr.add(new UserVO(30,"��Ҹ�","���� 2����","4222"));
		user.setNo(40);
		user.setName("�ó���");
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
