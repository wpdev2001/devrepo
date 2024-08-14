package com.wp.mycart.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.wp.mycart.dao.CategoryDao;
import com.wp.mycart.dao.ProductDao;
import com.wp.mycart.entities.Category;
import com.wp.mycart.entities.Product;
import com.wp.mycart.helper.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
						
			String op = request.getParameter("operation");
			
			if(op.trim().equals("addCategory")) {
				//add category
				String title = request.getParameter("catTitle");
				String description = request.getParameter("catDescription");
				
				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);
				
				//saving category to database
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				
				int catId = categoryDao.saveCategory(category);
				
//				response.getWriter().println("Category Saved!!!");
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category Added Successfully!!!");
				response.sendRedirect("admin.jsp");
				return;
				
			}
			else if(op.trim().equals("addProduct")) {
				//add product
				String pName = request.getParameter("pName");
				String pDesc = request.getParameter("pDesc");
				int pPrice = Integer.parseInt(request.getParameter("pPrice"));
				int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
				int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
				int catId = Integer.parseInt(request.getParameter("catId"));
				Part part = request.getPart("pPic");
				
				Product p = new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPhoto(part.getSubmittedFileName());
				
				//get category by Id
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);
				
				p.setCategory(category);
				
				//Save Product
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				pdao.saveProduct(p);
				
				//pic upload
//				find out the path to upload photo
				
				String path = getServletContext().getRealPath("img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
				System.out.println(path);
				
				//uploading code ..
				try {
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();

					// reading data
					byte[] data = new byte[is.available()];
					is.read(data);

					// Writing data
					fos.write(data);
					fos.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
//				response.getWriter().println("Product Save success...");
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product is Added Successfully!!!");
				response.sendRedirect("admin.jsp");
				return;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
