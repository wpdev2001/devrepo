package com.wp.mycart.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession httpSession = request.getSession();
			httpSession.removeAttribute("current-user");
			response.sendRedirect("login.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
