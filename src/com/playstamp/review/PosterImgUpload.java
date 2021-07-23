package com.playstamp.review;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/PosterImgUpload")
public class PosterImgUpload extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// form으로부터 전송된 데이터 받기
		//String rev_distin_cd = (String)session.getAttribute("rev_distin_cd");
		String realPath = request.getServletContext().getRealPath("upload");
		
		//System.out.println("서블릿" + rev_distin_cd);
		
		String fileName = null;
	    String contextPath = request.getServletContext().getContextPath();
	    String play_img = null;
	    
	    // 위 경로의 디렉토리가 존재하지 않으면 새로 생성 
		File dir = new File(realPath); 
		if (!dir.exists()) { dir.mkdirs(); } // 파일크기 제한 설정 (15mb) 
		int sizeLimit = 15 * 1024 * 1024; // MultipartRequest 객체를 생성하면 파일 업로드 수행 
		
		// 업로드한 파일명 가져오기
		MultipartRequest multipartRequest = new MultipartRequest(request
				, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		fileName = multipartRequest.getFilesystemName("userImg"); 
		
		play_img = contextPath + "/upload/" + fileName;
		
		HttpSession session = request.getSession();
	    session.setAttribute("play_img", play_img);
	    //request.setAttribute("rev_distin_cd", rev_distin_cd);
	    
		response.sendRedirect("modifyPosterImg.action"); 
		
	} 
}

