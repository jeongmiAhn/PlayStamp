package com.playstamp.myspace;

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

@WebServlet("/UserImgUpload")
public class UserImgUpload extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String realPath = request.getServletContext().getRealPath("/profile");
		
		System.out.println(realPath);
		
		String fileName = null;
	    
	    // 위 경로의 디렉토리가 존재하지 않으면 새로 생성 
		File dir = new File(realPath); 
		if (!dir.exists()) { dir.mkdirs(); } // 파일크기 제한 설정 (15mb) 
		int sizeLimit = 15 * 1024 * 1024; // MultipartRequest 객체를 생성하면 파일 업로드 수행 
		
		MultipartRequest multpartRequest = new MultipartRequest(request
				, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy()); // 업로드한 파일명 가져오기 
		
		fileName = multpartRequest.getFilesystemName("userImg"); 
		
		//userProfile = realPath + fileName;
		System.out.println(fileName);
		HttpSession session= request.getSession();
	    session.setAttribute("userProfile", fileName);
	    
		response.sendRedirect("uploadimg.action"); 
		
	} 
}

