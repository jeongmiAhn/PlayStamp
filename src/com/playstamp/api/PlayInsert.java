package com.playstamp.api;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class PlayInsert
{
	// 태그 값을 읽어올 함수
	private static String getTagValue(String tag, Element eElement)
	{
		Node nValue = null;

		NodeList x = eElement.getElementsByTagName(tag);
		Node test = x.item(0);
		NodeList t = null;
		if (test != null)
		{
			t = test.getChildNodes();
			if ((Node) t.item(0) != null)
			{
				nValue = (Node) t.item(0);
			}
		}
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}
	
	//API 파싱해서 DB에 저장하는 함수(공연 정보)
    public static void apiDB() throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException
    {
       // #. 변수 선언
        Play play = new Play();
        PlayDAO dao = new PlayDAO();
        ArrayList<String> list = new ArrayList<String>();
        
        // #. 데이터 삽입 성공 여부 판단 위해 변수 선언
        int result = 0;
        
        // #. 길이 확인 위해 nList 길이 받아 올 변수 선언
        int length = 0;
        
        // #. 공연장 코드 가져오기 
        
        try
      {
           list = dao.listPlayCode();
           
      } catch (Exception e)
      {
         System.out.println(e.toString());
      }
       
        for (String var : list)
        {           
          StringBuilder urlBuilder = null;

          urlBuilder = new StringBuilder("http://www.kopis.or.kr/openApi/restful/pblprfr/" + var); 
          
          urlBuilder.append("?" + URLEncoder.encode("service","UTF-8") + "=440191d3e12a4bf6905d618c4e7a5e2c");

           URL url = new URL(urlBuilder.toString());
           
           String parsingUrl="";
           parsingUrl=url.toString();
           
           // 1. 빌더 팩토리 생성.
           DocumentBuilderFactory dbFactory=DocumentBuilderFactory.newInstance();
   
           // 2. 빌더 팩토리로부터 빌더 생성
           DocumentBuilder dBuilder=dbFactory.newDocumentBuilder();
           
           // 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
           Document doc=dBuilder.parse(parsingUrl);
           
           // 문서 구조 안정화 
           doc.getDocumentElement().normalize();
           
           // XML 데이터 중 <db> 태그의 내용을 가져온다.
           NodeList nList=doc.getElementsByTagName("db");
           
           length = nList.getLength();
           
           for(int i=0; i<nList.getLength(); i++)
           {
               Node nNode=nList.item(i);
               
               if(nNode.getNodeType()==Node.ELEMENT_NODE)
               {
                   Element eElement=(Element)nNode;
                   
                   String code=getTagValue("mt20id", eElement);
                   
                   if(code!=null)
                   {     
                      play.setPlayCd(code);

                      play.setTheaterCd(getTagValue("mt10id", eElement));
                      play.setMngCd("M001");
                       
                      if (getTagValue("genrenm", eElement).equals("뮤지컬"))
                  {
                     play.setGenreCd(1);
                  }
                       else if(getTagValue("genrenm", eElement).equals("연극"))
                       {
                          play.setGenreCd(2);
                       }
                       
                      play.setPlayNm(getTagValue("prfnm", eElement));
                      
                      play.setPlayStart(transformDate(getTagValue("prfpdfrom", eElement)));
                      play.setPlayEnd(transformDate(getTagValue("prfpdto", eElement)));
                      play.setPlayImg(getTagValue("poster", eElement));
                      play.setPlayCast(getTagValue("prfcast", eElement));
                                         
                      try
                  {
                         result = dao.addPlay(play);
                  }
                      catch (Exception e)
                  {
                     System.out.println(e.toString());
                  }
   
                   }  
               }
               
           }
           
        }
        
        System.out.println("처리 개수" + length);
        if (result > 0)
      {
         System.out.println("데이터 베이스 입력 성공");
      }
        else
        {
           System.out.println("데이터베이스 입력 실패");
        }
        
    }
    
    // 날짜가 yyyymmdd 형식으로 입력되었을 경우 Date로 변경하는 메서드
    public static Date transformDate(String date)
    {
        SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy.mm.dd");
        
        // Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
        SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");
        
        java.util.Date tempDate = null;
        
        try {
            // 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
            tempDate = beforeFormat.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        // java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
        String transDate = afterFormat.format(tempDate);
        
        // 반환된 String 값을 Date로 변경한다.
        Date d = Date.valueOf(transDate);
        
        return d;
    }


	public static void main(String[] args)
			throws IOException, ParserConfigurationException, SAXException, SQLException, ClassNotFoundException
	{
		System.out.println("시작");

		apiDB();
	}
}
