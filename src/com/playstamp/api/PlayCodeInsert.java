package com.playstamp.api;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class PlayCodeInsert
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

	// API 파싱해서 DB에 저장하는 함수
	public static void apiDB()
			throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException
	{

		StringBuilder urlBuilder = null;
		urlBuilder = new StringBuilder("http://www.kopis.or.kr/openApi/restful/pblprfr");

		urlBuilder.append(
				"?" + URLEncoder.encode("service", "UTF-8") + "=440191d3e12a4bf6905d618c4e7a5e2c"); /* Service Key */
		urlBuilder.append("&" + URLEncoder.encode("stdate", "UTF-8") + "=20180601"); /* 시작일 */
		urlBuilder.append("&" + URLEncoder.encode("eddate", "UTF-8") + "=20220630"); /* 종료일 */
		urlBuilder.append("&" + URLEncoder.encode("cpage", "UTF-8") + "=1"); /* 출력할 페이지 수 */
		urlBuilder.append("&" + URLEncoder.encode("rows", "UTF-8") + "=10000"); /* 출력할 데이터 수 */
		urlBuilder.append("&" + URLEncoder.encode("signgucode", "UTF-8") + "=11"); /* 지역 코드 */
		//urlBuilder.append("&" + URLEncoder.encode("shcate","UTF-8") + "=AAAA"); /*장르 코드(연극)*/
		urlBuilder.append("&" + URLEncoder.encode("shcate", "UTF-8") + "=AAAB"); /* 장르 코드(뮤지컬) */
		URL url = new URL(urlBuilder.toString());

		String parsingUrl = "";
		parsingUrl = url.toString();

		// #. 변수 선언 (공연 코드만 INSERT)
		Play play = new Play();
		PlayDAO dao = new PlayDAO();

		// 1. 빌더 팩토리 생성.
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

		// 2. 빌더 팩토리로부터 빌더 생성
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

		// 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
		Document doc = dBuilder.parse(parsingUrl);

		// 문서 구조 안정화
		doc.getDocumentElement().normalize();

		// XML 데이터 중 <db> 태그의 내용을 가져온다.
		NodeList nList = doc.getElementsByTagName("db");
		int result = 0;
		for (int i = 0; i < nList.getLength(); i++)
		{
			Node nNode = nList.item(i);
			if (nNode.getNodeType() == Node.ELEMENT_NODE)
			{
				Element eElement = (Element) nNode;

				String code = getTagValue("mt20id", eElement);
				if (code != null)
				{
					try
					{
						result = dao.addCodeOnly(code);

					} catch (Exception e)
					{
						System.out.println(e.toString());
					}

				}
			}
		}

		System.out.println("처리 개수" + nList.getLength());
		if (result > 0)
		{
			System.out.println("데이터 베이스 입력 성공");
		} else
		{
			System.out.println("데이터베이스 입력 실패");
		}
	}

	public static void main(String[] args)
			throws IOException, ParserConfigurationException, SAXException, SQLException, ClassNotFoundException
	{
		System.out.println("시작");

		apiDB();

	}
}
