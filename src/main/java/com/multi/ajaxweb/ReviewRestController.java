package com.multi.ajaxweb;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.multi.domain.ReviewVO;
import com.multi.domain.UserVO;
import com.multi.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/* Rest : Representational State Transfer�� ����
 * - ���۹�İ� URI�� �����ؼ� ���ϴ� �۾��� �����Ͽ� ó���ϵ��� �ϴ� ���
 * 	 GET/POST/PUT/DELETE
 *   - GET : ��ȸ
 *   - DELETE : ����ó��
 *   - POST : INSERTó��
 *   - PUT : Updateó��
 *   ...
 *   URI +GET/POST/PUT/DELETE
 *   
 *   GET : /users/100 ==> 100�� ȸ���� ������ ��ȸ�ϴ� ���� ó���Ѵ�
 *   GET : /users ===> ��� ȸ�� ����� ��ȸ�ϴ� ������ ó���Ѵ�
 *   DELETE: /delete/3 ==> 3�� ȸ�� ������ ���� ó��...
 * @RestController==> REST����� �����͸� ó���ϴ� ���� ����� ���� �� �� �ִ�.
 * ==> @Controller + @ResponseBody
 * *******************************************************
 * (�̸� �����ϰ� �����ϴ� �� ����)
 * ���� ���� method + URI
 * 
 * GET /reviewForm ==> �۾��� �� �����ֱ� (/WEB-INF/views/shop/reviewWrite.jsp)
 * GET /reviews   ===> ��� �Խñ� �����ֱ�(��ȸ-R)
 * GET /reviews/10 ==> 10�� �Խñ� �����ֱ�(��ȸ-R)
 * POST /reviews   ==> �۾��� ó�� (C)
 * DELETE /reviewss/10 => 10�� �Խñ� ���� (D)
 * PUT /reviews    ==> �� ���� ó�� (U)
 * *******************************************************
 * 
 * */

@RestController //Ajax ���� ��Ʈ�ѷ�, restful��� ����
@Log4j
@RequiredArgsConstructor
public class ReviewRestController {
	
	private final ReviewService rService;//final����=>������ ����
	
	@GetMapping("/reviewForm")
	public ModelAndView reviewForm() {
		ModelAndView mv = new ModelAndView(); //Model��ü ���ҵ� �ϰ� View���� �����ϸ� �ش� ���������� ã�ư�����
		mv.addObject("msg","Multishop ���θ�");//������ ����
		mv.setViewName("shop/reviewWrite"); //����� ����
		return mv;
	}
	
	@PostMapping(value="/reviews", produces= {"application/json; charset=utf-8"})
	public ModelMap reviewInsert2(ReviewVO vo, 
			@RequestParam(value="mode", defaultValue="insert") String mode,
			@RequestParam("mfilename") MultipartFile mfilename, HttpSession session){
		ServletContext app = session.getServletContext();
		//log.info("app: "+app);
		//1. ���ε� ������ ���
		String upDir=app.getRealPath("/resources/images");
		
		log.info("upDir: "+upDir);

		//2. ���ε� ó��
		if(!mfilename.isEmpty()) {
			String fname = mfilename.getOriginalFilename();//÷�����ϸ�
			try {
				mfilename.transferTo(new File(upDir, fname));//���ε���
				//3. ÷�����ϸ��� ReviewVO�� setting
				vo.setFilename(fname);
				///////////////////
			}catch(IOException e) {
				log.error(e);
			}
		}
		int n = 0;
		if(mode.equals("insert")) {
			n=rService.insertReview(vo);
		}else if(mode.equals("edit")) {
			n=rService.updateReview(vo);
		}
		
		ModelMap map=new ModelMap();
		
		String str=(n>0)?"ok":"fail";
		map.addAttribute("result",str);
		map.addAttribute("pnum",vo.getPnum());
		return map;
	}
	
	@PostMapping("/reviews_old") // ���� ���ε����� ���� ���
	public ModelMap reviewInsert(ReviewVO vo) {
		log.info("vo: "+vo);
		
		int n = rService.insertReview(vo);
		String str=(n>0)?"ok":"fail";
		
		ModelMap map=new ModelMap();
		map.addAttribute("result",str);
		map.addAttribute("pnum",vo.getPnum());
		
		return map;
	}
	
	@GetMapping(value="/reviews", 
			produces= {"application/json; charset=utf-8"})
	public List<ReviewVO> getReviewAll(int pnum){
		log.info("pnum: "+pnum);
		return rService.getReviewList(pnum);
	}
	
	@GetMapping(value="/reviews/{no}",produces= {"application/json; charset=utf-8"})
	public ReviewVO getReview(@PathVariable("no") int no) {
		return rService.getReview(no);
	}//--------------------
	
	@PutMapping(value="/reviews", produces="application/json; charset=utf-8")
	public ModelMap reviewUpdate(ReviewVO vo,
			@RequestParam("mfilename") MultipartFile mfilename) {
		log.info("vo: "+vo);
		log.info("mfilename: "+mfilename);
		
		String str="test";
		ModelMap map=new ModelMap();
		map.put("result", str);
		
		return map;
	}
	
	
	@DeleteMapping(value="/reviews/{no}", produces= {"application/json; charset:utf-8"})
	public ModelMap reviewDelete(@PathVariable("no") int no) {
		log.info("no: "+no);
		int n = rService.deleteReview(no);
		String str=(n>0)?"ok":"fail";
		
		ModelMap map=new ModelMap();
		map.put("result", str);
		
		return map;
	}
	
	
	
	@GetMapping("/test")
	public String test() {
		
		return "Hello World"; 
		//@RestController�� ���̸� �޼��带 ��ȯ�ϴ� ���ڿ���
		//viewName�� �ƴ϶� ���䵥����(@ResponseBody)�� �����
	}
	@GetMapping(value="/test2", produces= {"application/json; charset=utf-8"})
	public List<UserVO> test2(){
		List<UserVO> arr = new ArrayList<>();
	
		arr.add(new UserVO(1,"ȫ�浿","����","1111"));
		arr.add(new UserVO(2,"��浿","��õ","2222"));
		return arr;
	}//
	
}
