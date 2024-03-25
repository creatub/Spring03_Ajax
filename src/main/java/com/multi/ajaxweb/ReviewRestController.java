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

/* Rest : Representational State Transfer의 약자
 * - 전송방식과 URI를 결합해서 원하는 작업을 지정하여 처리하도록 하는 방식
 * 	 GET/POST/PUT/DELETE
 *   - GET : 조회
 *   - DELETE : 삭제처리
 *   - POST : INSERT처리
 *   - PUT : Update처리
 *   ...
 *   URI +GET/POST/PUT/DELETE
 *   
 *   GET : /users/100 ==> 100번 회원의 정보를 조회하는 로직 처리한다
 *   GET : /users ===> 모든 회원 목록을 조회하는 로직을 처리한다
 *   DELETE: /delete/3 ==> 3번 회원 정보를 삭제 처리...
 * @RestController==> REST방식의 데이터를 처리하는 여러 기능을 쉽게 할 수 있다.
 * ==> @Controller + @ResponseBody
 * *******************************************************
 * (미리 설계하고 시작하는 게 좋음)
 * 리뷰 관련 method + URI
 * 
 * GET /reviewForm ==> 글쓰기 폼 보여주기 (/WEB-INF/views/shop/reviewWrite.jsp)
 * GET /reviews   ===> 모든 게시글 보여주기(조회-R)
 * GET /reviews/10 ==> 10번 게시글 보여주기(조회-R)
 * POST /reviews   ==> 글쓰기 처리 (C)
 * DELETE /reviewss/10 => 10번 게시글 삭제 (D)
 * PUT /reviews    ==> 글 수정 처리 (U)
 * *******************************************************
 * 
 * */

@RestController //Ajax 전용 컨트롤러, restful방식 지원
@Log4j
@RequiredArgsConstructor
public class ReviewRestController {
	
	private final ReviewService rService;//final변수=>생성자 주입
	
	@GetMapping("/reviewForm")
	public ModelAndView reviewForm() {
		ModelAndView mv = new ModelAndView(); //Model객체 역할도 하고 View네임 지정하면 해당 뷰페이지를 찾아가도록
		mv.addObject("msg","Multishop 쇼핑몰");//데이터 저장
		mv.setViewName("shop/reviewWrite"); //뷰네임 지정
		return mv;
	}
	
	@PostMapping(value="/reviews", produces= {"application/json; charset=utf-8"})
	public ModelMap reviewInsert2(ReviewVO vo, 
			@RequestParam(value="mode", defaultValue="insert") String mode,
			@RequestParam("mfilename") MultipartFile mfilename, HttpSession session){
		ServletContext app = session.getServletContext();
		//log.info("app: "+app);
		//1. 업로드 절대경로 얻기
		String upDir=app.getRealPath("/resources/images");
		
		log.info("upDir: "+upDir);

		//2. 업로드 처리
		if(!mfilename.isEmpty()) {
			String fname = mfilename.getOriginalFilename();//첨부파일명
			try {
				mfilename.transferTo(new File(upDir, fname));//업로드함
				//3. 첨부파일명을 ReviewVO에 setting
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
	
	@PostMapping("/reviews_old") // 파일 업로드하지 않을 경우
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
		//@RestController를 붙이면 메서드를 반환하는 문자열이
		//viewName이 아니라 응답데이터(@ResponseBody)로 취급함
	}
	@GetMapping(value="/test2", produces= {"application/json; charset=utf-8"})
	public List<UserVO> test2(){
		List<UserVO> arr = new ArrayList<>();
	
		arr.add(new UserVO(1,"홍길동","서울","1111"));
		arr.add(new UserVO(2,"고길동","인천","2222"));
		return arr;
	}//
	
}
