<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Student Login</title>

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
                padding:30px;
                box-shadow:0 2px 8px rgba(0,0,0,.2);

            }

            .header h1{

                margin-bottom:10px;

            }

            .header h3{

                font-weight:normal;

            }

            .container{

                width:420px;
                margin:60px auto;
                background:white;
                padding:35px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            label{

                display:block;
                margin-bottom:8px;
                color:#2c3e50;
                font-weight:bold;

            }

            input[type=text],
            input[type=password]{

                width:100%;
                padding:12px;
                border:1px solid #ccc;
                border-radius:6px;
                margin-bottom:20px;
                font-size:15px;

            }

            input[type=text]:focus,
            input[type=password]:focus{

                outline:none;
                border-color:#3498db;

            }

            input[type=submit]{

                width:100%;
                padding:12px;
                background:#3498db;
                color:white;
                border:none;
                border-radius:6px;
                font-size:16px;
                font-weight:bold;
                cursor:pointer;

            }

            input[type=submit]:hover{

                background:#2980b9;

            }

            .error{

                margin-top:20px;
                text-align:center;
                color:#e74c3c;
                font-weight:bold;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <h1>College ERP System</h1>

            <h3>Student Login</h3>

        </div>

        <div class="container">

            <form action="../LoginServlet" method="post">

                <label>Username</label>

                <input
                    type="text"
                    name="username"
                    placeholder="Enter Username"
                    required>

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Enter Password"
                    required>

                <input
                    type="hidden"
                    name="expectedRole"
                    value="3">

                <input
                    type="submit"
                    value="Login">

            </form>

            <%
                if (request.getParameter("error") != null) {
            %>

            <div class="error">

                Invalid Student Username or Password

            </div>

            <%
                }
            %>

        </div>

    </body>

</html>