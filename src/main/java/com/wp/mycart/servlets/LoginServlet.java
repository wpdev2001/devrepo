package com.wp.mycart.servlets;

import java.io.IOException;

import com.wp.mycart.dao.UserDao;
import com.wp.mycart.entities.User;
import com.wp.mycart.helper.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Coding area
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validations
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.getWriter().println("Email or Password cannot be empty");
            return;
        }
        
        // Authenticating user
        UserDao userDao = new UserDao(FactoryProvider.getFactory());
        User user = userDao.getUserByEmailAndPassword(email, password);
        
        HttpSession httpSession = request.getSession();
        
        if (user == null) {
        	response.getWriter().println("<h1>Invalid Details</h1>");
        	httpSession.setAttribute("message", "Invalid Details Try Again!!!");
        	response.sendRedirect("login.jsp");
        	return;
        } else {
            response.getWriter().println("Welcome " + user.getUserEmail());
        }
        //login
        httpSession.setAttribute("current-user", user);
        
        if(user.getUserType().equals("admin")) {
        	//admin.jsp
        	response.sendRedirect("admin.jsp");        	
        }
        else if(user.getUserType().equals("normal user")) {
        	//normal.jsp
        	response.sendRedirect("normal.jsp");
        }
        else {
        	response.getWriter().println("We have not identified user type!!!");
        }
        
    }
}