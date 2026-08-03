<div align="center">

# 🎓 College ERP System

### A Complete College ERP Management System built using Java, JSP, Servlets, JDBC, Maven & MySQL

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=openjdk)
![JSP](https://img.shields.io/badge/JSP-JakartaEE-blue?style=for-the-badge)
![Servlet](https://img.shields.io/badge/Servlet-JakartaEE-red?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Maven](https://img.shields.io/badge/Maven-Build-red?style=for-the-badge&logo=apachemaven)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

# 📖 About

College ERP System is a role-based web application developed to simplify the management of students, faculty, departments, subjects, attendance and notices within a college.

The project follows the **MVC (Model-View-Controller)** architecture and provides dedicated portals for:

- 👨‍💼 Admin
- 👨‍🏫 Faculty
- 👨‍🎓 Student

---

# ✨ Features

## 👨‍💼 Admin Portal

- Secure Login
- Dashboard
- Department Management
- Student Management
- Faculty Management
- Subject Management
- Faculty-Subject Assignment
- Notice Management
- Attendance Monitoring
- Attendance Search & Filters
- BCrypt Password Encryption

---

## 👨‍🏫 Faculty Portal

- Secure Login
- Dashboard
- Assigned Subjects
- Take Attendance
- View Attendance
- Attendance Filters

---

## 👨‍🎓 Student Portal

- Secure Login
- Dashboard
- View Attendance
- View Subjects

---

# 🛠 Tech Stack

| Layer | Technology |
|--------|------------|
| Language | Java |
| Frontend | JSP, HTML5, CSS3, JavaScript |
| Backend | Java Servlets |
| Architecture | MVC |
| Database | MySQL |
| Connectivity | JDBC |
| Build Tool | Maven |
| IDE | Apache NetBeans |
| Server | Apache Tomcat 10 |
| Authentication | BCrypt |

---

# 📁 Project Structure

```
CollegeERP
│
├── src
│   └── main
│       ├── java
│       │   ├── controller
│       │   ├── dao
│       │   ├── model
│       │   └── util
│       │
│       ├── resources
│       └── webapp
│           ├── css
│           ├── images
│           ├── js
│           └── jsp
│
├── database
│   └── college_erp.sql
│
├── pom.xml
└── README.md
```

---

# 🗄 Database

The project contains realistic demo data.

| Table | Records |
|--------|--------:|
| Departments | 5 |
| Faculty | 15 |
| Students | 50 |
| Subjects | 80 |
| Faculty-Subject Mapping | 90 |
| Attendance | 2800+ |
| Users | Role Based |

---

# 🔑 Demo Credentials

## 👨‍💼 Admin

| Username | Password |
|----------|----------|
| **Souvik** | **admin** |

---

## 👨‍🏫 Faculty

| Username | Password |
|----------|----------|
| faculty1 | faculty |
| faculty2 | faculty |

---

## 👨‍🎓 Student

| Username | Password |
|----------|----------|
| student1 | student |
| student2 | student |

---

# 🚀 Getting Started

## 1️⃣ Clone Repository

```bash
git clone https://github.com/Souvik686/college-erp-system.git
```

---

## 2️⃣ Import Database

Import

```
database/college_erp.sql
```

into MySQL.

---

## 3️⃣ Configure Database

Open

```
src/main/java/util/DBConnection.java
```

Update your credentials.

```java
private static final String URL =
"jdbc:mysql://localhost:3306/college_erp";

private static final String USER =
"root";

private static final String PASSWORD =
"YOUR_MYSQL_PASSWORD";
```

---

## 4️⃣ Open Project

Open using

- Apache NetBeans

---

## 5️⃣ Build Project

```
Clean & Build
```

---

## 6️⃣ Deploy

Deploy on

- Apache Tomcat 10

---

# 📸 Screenshots

## 🏠 Home Page

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185335" src="https://github.com/user-attachments/assets/29cb1ea6-7a44-4d0b-81dc-f4f0a3c8d627" />


---

## 👨‍💼 Admin Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185452" src="https://github.com/user-attachments/assets/68938a9a-4700-4fc0-a3e9-b6d2a7813861" />


---

## 👨‍🏫 Faculty Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185514" src="https://github.com/user-attachments/assets/719d3d73-5c63-44cb-aca6-fbca986af070" />


---

## 👨‍🎓 Student Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185538" src="https://github.com/user-attachments/assets/aa6fbd12-a88c-44a5-bf10-e3013a067d2f" />


---

## 📋 Attendance Module

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185631" src="https://github.com/user-attachments/assets/f1d215a7-91a2-4792-bce5-c317ba5b9431" />


---

## 👥 Student Management

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185641" src="https://github.com/user-attachments/assets/ea01a02c-fc7b-4fe3-a411-4302cb4f617f" />


---

# 🔒 Security

- BCrypt Password Hashing
- Role-Based Authentication
- Session Management
- JDBC Prepared Statements
- Password Encryption

---

# 🎯 Future Enhancements

- Student Result Management
- Fee Management
- Timetable Module
- Email Notifications
- Parent Portal
- REST API
- Mobile Responsive UI
- Dashboard Analytics

---

# 👨‍💻 Developer

## Souvik Sarkar

**Bachelor of Computer Applications (BCA)**

📍 Kolkata, India

GitHub:

https://github.com/Souvik686

---

# ⭐ Support

If you found this project useful, consider giving it a **⭐ Star** on GitHub.

---

<div align="center">

### Thank you for visiting ❤️

</div>
