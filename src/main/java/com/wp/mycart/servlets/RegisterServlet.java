package com.wp.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wp.mycart.entities.User;
import com.wp.mycart.helper.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()) {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");
			
			//Validations
			if(userName.isEmpty()) {
				out.println("Name is blank!!");
				return;
			}
			
			//Creating user object to store data
			
			User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "admin");
			
			Session hibernateSession = FactoryProvider.getFactory().openSession();
			
			Transaction tx = hibernateSession.beginTransaction();
			
			int userId = (int)hibernateSession.save(user);
			
			tx.commit();
			
			hibernateSession.close();
			
			out.println("Successfully saved");
			out.println("<br> User id is " + userId);
			
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "Registration Successfull!!!" + userId);
			response.sendRedirect("register.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
