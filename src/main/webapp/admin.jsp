<%@page import="com.wp.mycart.entities.Product"%>
<%@page import="com.wp.mycart.dao.ProductDao"%>
<%@page import="com.wp.mycart.dao.UserDao"%>
<%@page import="com.wp.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.wp.mycart.helper.FactoryProvider"%>
<%@page import="com.wp.mycart.dao.CategoryDao"%>
<%@page import="com.wp.mycart.entities.User"%>
<%
	//Get the current user from the session
	User user = (User)session.getAttribute("current-user");

	//Protecting the admin page
	if(user==null){
		session.setAttribute("message", "You're not logged in!!! Login first");
		response.sendRedirect("login.jsp");
		return;
	}
	else{
		if(user.getUserType().equals("normal user")) {
			session.setAttribute("message", "You're not Admin!! Do not access this page");
			response.sendRedirect("login.jsp");
			return;        	
        }
	}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Admin Panel</title>
	<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container admin">
	
		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp" %>
		</div>	
	
	
		<!-- First row -->
		<div class="row mt-3">
					
			<div class="col-md-4">
			
				<div class="card">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width:125px" class="img-fluid rounded-circle" alt="user_icon" src="img/team.png">
						</div>
						<%
						
						UserDao usersDao = new UserDao(FactoryProvider.getFactory());
						List<User> ulist = usersDao.getAllUsers();			
												
						%>
						<h1><%= ulist.size() %></h1>
						<h1>Users</h1>
					</div>
				</div>
			
			</div>

			<div class="col-md-4">

				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width:125px" class="img-fluid rounded-circle" alt="user_icon" src="img/list.png">
						</div>
						<%
						
						CategoryDao categoriesDao = new CategoryDao(FactoryProvider.getFactory());
						List<Category> clist = categoriesDao.getCategories();			
												
						%>
						<h1><%= clist.size() %></h1>
						<h1>Categories</h1>
					</div>
				</div>

			</div>

			<div class="col-md-4">

				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width:125px" class="img-fluid rounded-circle" alt="user_icon" src="img/delivery-box.png">
						</div>
						<%
						
						ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
						List<Product> plist = productDao.getAllProducts();			
												
						%>
						<h1><%= plist.size() %></h1>
						<h1>Products</h1>
					</div>
				</div>

			</div>


		</div>
		
		<!-- Second row -->
		<div class="row mt-3">
					
			<div class="col-md-6">
			
				<div class="card" data-toggle="modal" data-target="#add-category-modal">
					<div class="card-body text-center">
					
						<div class="container">
							<img style="max-width:125px" class="img-fluid rounded-circle" alt="user_icon" src="img/calculator.png">
						</div>
						
						<p class="mt-2">Click here to add category</p>
						<h1>Add Category</h1>
					</div>
				</div>
			
			</div>

			<div class="col-md-6">

				<div class="card" data-toggle="modal" data-target="#add-product-modal">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width:125px" class="img-fluid rounded-circle" alt="user_icon" src="img/plus.png">
						</div>
						<p class="mt-2">Click here to add new Product</p>
						<h1>Add Product</h1>
					</div>
				</div>

			</div>

		</div>
		
	</div>
	<!-- Start Add category modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
					<form action="ProductOperationServlet" method="post">
					
						<input type="hidden" name="operation" value="addCategory">
						
						<div class="form-group">
							<input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
						</div>

						<div class="form-group">
							<textarea style="height: 250px" class="form-control"
								placeholder="Enter Category description" name="catDescription"
								required></textarea>
						</div>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>

					</form>
				
				</div>
				
			</div>
		</div>
	</div>

	<!-- End Add category modal -->
	
	<!-- Start Add Product modal -->
	
	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
					<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
					
						<input type="hidden" name="operation" value="addProduct">
						
						<!-- Product name -->
						<div class="form-group">
							<input type="text" class="form-control" name="pName" placeholder="Enter title of product" required/>
						</div>
						
						<!-- Product Description -->
						<div class="form-group">
							<textarea style="height: 150px" class="form-control"
								placeholder="Enter product description" name="pDesc"
								required></textarea>
						</div>
						
						<!-- Product price -->
						<div class="form-group">
							<input type="number" class="form-control" name="pPrice" placeholder="Enter price of product" required/>
						</div>
						
						<!-- Product discount -->
						<div class="form-group">
							<input type="number" class="form-control" name="pDiscount" placeholder="Enter product Discount" required/>
						</div>
						
						<!-- Product quantity -->
						<div class="form-group">
							<input type="number" class="form-control" name="pQuantity" placeholder="Enter product Quantity" required/>
						</div>
						
						<!-- Product category -->
						
						<%
							CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
							List<Category> list = cdao.getCategories();
						%>
						
						<div class="form-group">
							<select name="catId" class="form-control" id="">
								<%
									for(Category c:list){								
								%>
								<option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle() %></option>
								
								<%
									}
								%>
							</select>
						</div>
						
						<!-- Product file -->
						<div class="form-group">
							<label for="pPic">Select Picture of product</label>
							<br>
							<input type="file" id="pPic" name="pPic" required/>
						</div>
						
						<!-- Submit button -->
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>

					</form>
				
				</div>
				
			</div>
		</div>
	</div>
	
	
	<!-- End Add Product modal -->

</body>
</html>