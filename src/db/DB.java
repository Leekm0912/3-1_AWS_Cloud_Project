package db;

import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.util.*;

public class DB {
	public Connection con = null;
	
	private DB(){
		String dbURL = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
		String dbID = "leekm";
		String dbPassword = "12121212";

		try { /* 드라이버를 찾는 과정 */
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//System.out.println("드라이버 로드 성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try { /* 데이터베이스를 연결하는 과정 */
			//System.out.println("데이터베이스 연결 준비 ...");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//System.out.println("데이터베이스 연결 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static DB getDB() {
		return new DB();
	}
}
