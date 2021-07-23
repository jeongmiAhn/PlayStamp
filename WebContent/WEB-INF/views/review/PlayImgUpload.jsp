<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String root = pageContext.getServletContext().getRealPath("/");
	
	System.out.println("실제 물리적 주소 : " + root);
	
	// 저장되는 위치와 폴더 
	String path = root + "pds" + File.separator + "savdData";

	String fileName = null;
    //String contextPath = request.getServletContext().getContextPath();
    String userProfile = null;
    
    // 위 경로의 디렉토리가 존재하지 않으면 새로 생성 
	File dir = new File(path); 
	if (!dir.exists()) { dir.mkdirs(); } // 파일크기 제한 설정 (15mb) 
	int sizeLimit = 15 * 1024 * 1024; // MultipartRequest 객체를 생성하면 파일 업로드 수행 
	
	// 업로드한 파일명 가져오기
	MultipartRequest multpartRequest = new MultipartRequest(request
			, path, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
	
	fileName = multpartRequest.getFilesystemName("userImg");
    //-- 서버에 저장된 파일명
	
	response.sendRedirect("modifyPosterImg.action"); 
%>