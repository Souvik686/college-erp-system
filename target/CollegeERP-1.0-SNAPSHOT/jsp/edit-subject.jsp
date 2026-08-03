<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="dao.DepartmentDAO"%>
<%@page import="model.Department"%>
<%@page import="model.Faculty"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    Subject s = (Subject) request.getAttribute("subject");

    List<Faculty> facultyList
            = (List<Faculty>) request.getAttribute("facultyList");

    List<Integer> assignedFaculty
            = (List<Integer>) request.getAttribute("assignedFaculty");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Edit Subject</title>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:Arial, Helvetica, sans-serif;
            }

            body{
                background:#f4f6f9;
            }

            .header{

                background:#2c3e50;
                color:white;
                text-align:center;
                padding:25px;
                position:relative;
                box-shadow:0 2px 8px rgba(0,0,0,.2);

            }

            .header h1{
                margin-bottom:10px;
            }

            .header p{
                font-size:18px;
            }

            .header h3{
                margin-top:10px;
            }

            .top-links{

                position:absolute;
                top:25px;
                right:30px;

            }

            .top-links a{

                color:white;
                text-decoration:none;
                font-weight:bold;
                margin-left:20px;

            }

            .top-links a:hover{

                text-decoration:underline;

            }

            .container{

                width:650px;
                margin:40px auto;
                background:white;
                padding:30px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            label{

                display:block;
                margin-bottom:8px;
                font-weight:bold;
                color:#2c3e50;

            }

            input,
            select{

                width:100%;
                padding:12px;
                margin-bottom:20px;
                border:1px solid #ccc;
                border-radius:6px;
                font-size:15px;

            }

            input:focus,
            select:focus{

                outline:none;
                border-color:#3498db;

            }

            .faculty-box{

                border:1px solid #ddd;
                border-radius:8px;
                padding:15px;
                max-height:250px;
                overflow-y:auto;
                margin-bottom:25px;

            }

            .faculty-box label{

                display:block;
                font-weight:normal;
                margin-bottom:12px;

            }

            .faculty-box input{

                width:auto;
                margin-right:8px;

            }

            .button-group{

                display:flex;
                gap:15px;

            }

            .button-group input{

                flex:1;
                border:none;
                color:white;
                cursor:pointer;
                font-size:16px;
                font-weight:bold;

            }

            input[type=submit]{

                background:#3498db;

            }

            input[type=submit]:hover{

                background:#2980b9;

            }

            input[type=button]{

                background:#7f8c8d;

            }

            input[type=button]:hover{

                background:#636e72;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <div class="top-links">

                <a href="<%=request.getContextPath()%>/AdminDashboardServlet">
                    Dashboard
                </a>

                <a href="<%=request.getContextPath()%>/LogoutServlet">
                    Logout
                </a>

            </div>

            <h1>College ERP System</h1>

            <p>
                Welcome,
                <b><%=user.getUsername()%></b>
            </p>

            <h3>Edit Subject</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/EditSubjectServlet"
                  method="post">

                <input type="hidden"
                       name="subjectId"
                       value="<%=s.getSubjectId()%>">

                <label>Subject Code</label>

                <input type="text"
                       name="subjectCode"
                       value="<%=s.getSubjectCode()%>"
                       required>

                <label>Subject Name</label>

                <input type="text"
                       name="subjectName"
                       value="<%=s.getSubjectName()%>"
                       required>

                <label>Department</label>

                <select name="departmentId">

                    <%
                        DepartmentDAO ddao = new DepartmentDAO();

                        for (Department d : ddao.getAllDepartments()) {
                    %>

                    <option value="<%=d.getDepartmentId()%>"
                            <%=d.getDepartmentId() == s.getDepartmentId() ? "selected" : ""%>>

                        <%=d.getDepartmentName()%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <label>Semester</label>

                <select name="semester">

                    <%
                        for (int i = 1; i <= 8; i++) {
                    %>

                    <option value="<%=i%>"
                            <%=i == s.getSemester() ? "selected" : ""%>>

                        Semester <%=i%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <label>Assign Faculty</label>

                <div class="faculty-box">

                    <%
                        for (Faculty f : facultyList) {

                            boolean checked = assignedFaculty.contains(f.getFacultyId());
                    %>

                    <label>

                        <input
                            type="checkbox"
                            name="facultyIds"
                            value="<%=f.getFacultyId()%>"
                            <%=checked ? "checked" : ""%>>

                        <%=f.getFacultyName()%>

                    </label>

                    <%
                        }
                    %>

                </div>

                <div class="button-group">

                    <input
                        type="submit"
                        value="Update Subject">

                    <input
                        type="button"
                        value="Cancel"
                        onclick="location.href = '<%=request.getContextPath()%>/SubjectListServlet'">

                </div>

            </form>

        </div>

    </body>

</html>