package com.vmail.model;

import java.sql.*;

public class ConnectionProvider {
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail","root","root");
			return con;
		} catch (Exception e) {
			System.out.println("Exception");
			return null;
		}
		
	}

}
