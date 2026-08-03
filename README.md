<div align="center">

# 🎓 College ERP System

### A Role-Based College ERP Management System built using Java, JSP, Servlets, JDBC, Maven & MySQL

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=openjdk)
![JSP](https://img.shields.io/badge/JSP-JakartaEE-blue?style=for-the-badge)
![Servlet](https://img.shields.io/badge/Servlet-JakartaEE-red?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Maven](https://img.shields.io/badge/Maven-Build-red?style=for-the-badge&logo=apachemaven)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

A complete web-based College ERP System developed using Java Enterprise technologies.

</div>

---

# 📖 Overview

The **College ERP System** is a web application designed to simplify and digitize college administration. It provides separate portals for **Admin**, **Faculty**, and **Students**, enabling efficient management of departments, students, faculty members, subjects, attendance, and notices.

The application follows the **MVC (Model-View-Controller)** architecture using **JSP, Servlets, JDBC, Maven, and MySQL**.

---

# ✨ Features

## 👨‍💼 Admin Portal

- Secure Login
- Dashboard
- Department Management (Add, Edit, Delete)
- Student Management
- Faculty Management
- Subject Management
- Faculty Subject Assignment
- Attendance Monitoring
- Attendance Search & Filter
- Notice Management
- Secure Logout

---

## 👨‍🏫 Faculty Portal

- Secure Login
- Dashboard
- View Assigned Subjects
- Take Student Attendance
- View Attendance Records
- Attendance Search

---

## 👨‍🎓 Student Portal

- Secure Login
- Dashboard
- View Subjects
- View Attendance

---

# 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Language | Java |
| Frontend | JSP, HTML5, CSS3 |
| Backend | Java Servlets |
| Architecture | MVC |
| Database | MySQL 8 |
| Database Connectivity | JDBC |
| Build Tool | Maven |
| IDE | Apache NetBeans |
| Server | Apache Tomcat 10 |
| Security | BCrypt Password Hashing |

---

# 📂 Project Structure

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
│       │
│       └── webapp
│           ├── css
│           ├── images
│           ├── js
│           └── jsp
│
├── database
│   └── college_erp.sql
│
├── screenshots
│   ├── home-page.png
│   ├── admin-dashboard.png
│   ├── faculty-dashboard.png
│   ├── student-dashboard.png
│   ├── student-management.png
│   ├── faculty-management.png
│   ├── subject-management.png
│   ├── attendance-management.png
│   └── attendance-report.png
│
├── pom.xml
├── README.md
└── .gitignore
```

---

# 🗄 Database

The project includes a fully populated demo database.

### Database Statistics

| Table | Records |
|--------|---------|
| Departments | 5 |
| Faculty | 15 |
| Students | 50 |
| Subjects | 80 |
| Faculty-Subject Assignments | 90 |
| Attendance | 2800+ |
| Users | Role-Based |

---

# 🚀 Installation Guide

## Prerequisites

Install the following software:

- Java JDK 17 (or your compatible version)
- Apache NetBeans
- Apache Tomcat 10.x
- MySQL Server 8.x
- MySQL Workbench
- Git (optional)

---

## Step 1 : Clone the Repository

```bash
git clone https://github.com/Souvik686/college-erp-system.git
```

Or download the ZIP from GitHub.

---

## Step 2 : Open Project

Open **Apache NetBeans**

```
File
→ Open Project
```

Select the **CollegeERP** project.

Wait for Maven to download all required dependencies.

---

## Step 3 : Create Database

Open MySQL Workbench and execute:

```sql
CREATE DATABASE college_erp;
```

---

## Step 4 : Import Database

Import the following file into the **college_erp** database:

```
database/college_erp.sql
```

---

## Step 5 : Configure Database Connection

Open:

```
src/main/java/util/DBConnection.java
```

Update your MySQL credentials:

```java
private static final String URL =
"jdbc:mysql://localhost:3306/college_erp";

private static final String USER =
"root";

private static final String PASSWORD =
"YOUR_MYSQL_PASSWORD";
```

---

## Step 6 : Configure Apache Tomcat

In NetBeans:

```
Services
→ Servers
→ Add Server
```

Select:

```
Apache Tomcat 10.x
```

---

## Step 7 : Build the Project

Right-click the project:

```
Clean and Build
```

---

## Step 8 : Run the Project

Right-click the project:

```
Run
```

or

```
Run Project
```

---

## Step 9 : Open in Browser

```
http://localhost:8080/CollegeERP/
```

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
| faculty3 | faculty |

---

## 👨‍🎓 Student

| Username | Password |
|----------|----------|
| student1 | student |
| student2 | student |
| student3 | student |

---

# 📸 Screenshots

## 🏠 Home Page

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185335" src="https://github.com/user-attachments/assets/4e94d81c-79e8-4882-8366-16fc1e21e87a" />

---

## 👨‍💼 Admin Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185452" src="https://github.com/user-attachments/assets/c5fc7d60-44c3-4a44-97f3-b1dbf8ad4eab" />

---

## 👨‍🏫 Faculty Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185514" src="https://github.com/user-attachments/assets/8f2efc7e-2a22-450b-9640-ba5009ced0b0" />

---

## 👨‍🎓 Student Dashboard

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185538" src="https://github.com/user-attachments/assets/4f612afc-9fa3-4c35-8f33-ef662bf4af37" />

---

## 👨‍🎓 Student Management

<img width="1920" height="1020" alt="Screenshot 2026-08-03 185641" src="https://github.com/user-attachments/assets/91d7b6d6-67af-4507-b93c-6ae90eeb011c" />

---

## 👨‍🏫 Faculty Management

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/719f7136-a7a8-4917-b0da-defe49418b2d" />

---

## 📚 Subject Management

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/68c33d62-fe9a-4215-b7ef-c0c59037d5fc" />

---

## 📋 Attendance Management

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/149d1cb0-6184-40a0-b114-0d15a4c70274" />

---

## 📊 Attendance Report

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/7b9b7379-27af-4769-8fb8-934cd519315a" />

---

# 🔒 Security Features

- BCrypt Password Hashing
- Role-Based Authentication
- Session Management
- JDBC Prepared Statements
- Secure Login System

---

# 📚 Learning Objectives

This project demonstrates:

- Java Web Development
- MVC Architecture
- JSP & Servlets
- JDBC Database Connectivity
- CRUD Operations
- MySQL Database Design
- Authentication & Authorization
- Session Management
- Maven Project Structure

---

# 🎯 Future Enhancements

- Student Result Management
- Fee Management System
- Timetable Management
- Parent Portal
- Email Notifications
- Dashboard Analytics
- REST API
- Responsive User Interface

---

# 🤝 Contributing

Contributions are welcome.

1. Fork this repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to your branch.
5. Open a Pull Request.

---

# 📄 License

This project is licensed under the **MIT License**.

---

# 👨‍💻 Author

## Souvik Sarkar

Bachelor of Computer Applications (BCA)

GitHub: https://github.com/Souvik686

---

<div align="center">

### ⭐ If you found this project useful, please consider giving it a Star!

Made with ❤️ using Java, JSP, Servlets & MySQL

</div>
