<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>College ERP System</title>

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
                padding:40px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            .portal{

                display:block;
                width:100%;
                padding:14px;
                margin-bottom:20px;

                background:#3498db;
                color:white;

                text-decoration:none;
                text-align:center;

                border-radius:6px;

                font-size:16px;
                font-weight:bold;

                transition:.3s;

            }

            .portal:hover{

                background:#2980b9;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <h1>College ERP System</h1>

            <h3>Select Your Portal</h3>

        </div>

        <div class="container">

            <a class="portal"
               href="jsp/admin-login.jsp">

                Administrator Portal

            </a>

            <a class="portal"
               href="jsp/faculty-login.jsp">

                Faculty Portal

            </a>

            <a class="portal"
               href="jsp/student-login.jsp">

                Student Portal

            </a>

        </div>

    </body>

</html>