package com.playstamp.faq.mybatis;

import java.util.ArrayList;

import com.playstamp.faq.Faq;

public interface IFaqDAO
{
	//@@ FAQ 목록 출력 메소드
	public ArrayList<Faq> getFaqList();
	
	//@@ FAQ 추가 메소드
	public int addFaq(Faq faq);
	
	//@@ FAQ 수정 메소드
	public int updateFaq(Faq faq);
	
	//@@ FAQ 코드로 FAQ 삭제하는 메소드
	public int deleteFaq(Faq faq);	
	
	//@@ FAQ 코드로 FAQ 객체를 찾는 메소드
	public Faq searchFaq(Faq faq);
}
