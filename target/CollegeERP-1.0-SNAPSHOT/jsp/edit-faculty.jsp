<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="model.Faculty"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    Faculty faculty = (Faculty) request.getAttribute("faculty");
    List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
    List<Integer> assignedSubjects = (List<Integer>) request.getAttribute("assignedSubjects");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Edit Faculty</title>

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
                margin-bottom:10px;
                font-size:18px;
            }

            .header h3{
                margin:0;
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

                width:700px;
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

            input[type=text],
            input[type=email]{

                width:100%;
                padding:12px;
                border:1px solid #ccc;
                border-radius:6px;
                font-size:15px;
                margin-bottom:20px;

            }

            input:focus{

                outline:none;
                border-color:#3498db;

            }

            .subject-box{

                border:1px solid #ddd;
                border-radius:8px;
                padding:15px;
                max-height:250px;
                overflow-y:auto;
                margin-bottom:25px;

            }

            .subject-box label{

                display:block;
                margin-bottom:10px;
                font-weight:normal;
                cursor:pointer;

            }

            .subject-box input{

                margin-right:8px;
                width:auto;

            }

            .button-group{

                display:flex;
                gap:15px;

            }

            .button-group input{

                flex:1;
                padding:12px;
                border:none;
                border-radius:6px;
                font-size:16px;
                font-weight:bold;
                cursor:pointer;
                background:#3498db;
                color:white;

            }

            .button-group input:hover{

                background:#2980b9;

            }

            .cancel-btn{

                flex:1;
                text-align:center;
                padding:12px;
                background:#7f8c8d;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;

            }

            .cancel-btn:hover{

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

            <h3>Edit Faculty</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/UpdateFacultyServlet" method="post">

                <input
                    type="hidden"
                    name="facultyId"
                    value="<%=faculty.getFacultyId()%>">

                <label>Faculty Name</label>

                <input
                    type="text"
                    name="facultyName"
                    value="<%=faculty.getFacultyName()%>"
                    required>

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    value="<%=faculty.getEmail()%>"
                    required>

                <label>Phone</label>

                <input
                    type="text"
                    name="phone"
                    value="<%=faculty.getPhone()%>"
                    required>

                <label>Assigned Subjects</label>

                <div class="subject-box">

                    <%

                        for (Subject s : subjectList) {

                            boolean checked = assignedSubjects.contains(s.getSubjectId());

                    %>

                    <label>

                        <input
                            type="checkbox"
                            name="subjectIds"
                            value="<%=s.getSubjectId()%>"
                            <%=checked ? "checked" : ""%>>

                        <%=s.getSubjectCode()%> - <%=s.getSubjectName()%>

                    </label>

                    <%

                        }

                    %>

                </div>

                <div class="button-group">

                    <input
                        type="submit"
                        value="Update Faculty">

                    <a class="cancel-btn"
                       href="<%=request.getContextPath()%>/FacultyListServlet">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </body>

</html>