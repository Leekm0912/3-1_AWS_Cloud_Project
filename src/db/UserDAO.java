package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

	// dao : 데이터베이스 접근 객체의 약자로서
	// 실질적으로 db에서 회원정보 불러오거나 db에 회원정보 넣을때

	private Connection conn; // connection:db에접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mysql에 접속해 주는 부분
	public UserDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		try {

			String dbURL = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
			String dbID = "leekm";
			String dbPassword = "12121212";
			Class.forName("oracle.jdbc.driver.OracleDriver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace(); // 오류가 무엇인지 출력

		}

	}

	// 로그인을 시도하는 함수****
	public User login(String userID, String userPassword, String type, String email) {
		String userType = "";
		System.out.println("login" + type);
		if (type.contains("kakao")) {
			userType = type.split("kakao")[1];
			System.out.println("카카오"+userID+"\t"+ userPassword);
		}
		User user = new User();
		String SQL = "";
		String query = "";
		if (type.contains("kakao")) {
			String enpw = userPassword;
			// 복호화
			char[] enpw_char = enpw.toCharArray();
			/*for (int i = 0; i < enpw_char.length; i++) {
				int temp = (int) enpw_char[i];
				temp -= 30;
				enpw_char[i] = (char) temp;
			}*/
			enpw = new String(enpw_char);

			if (userType.equals("매수자")) {
				query = "insert into 매수자 values(?,?,?,?,?)";
			} else if (userType.equals("매도자")) {
				query = "insert into 매도자 values(?,?,?,?,?)";
			}

			try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
				pstmt = conn.prepareStatement(query); // PreparedStatement 객체 생성(쿼리 생성)
				pstmt.setString(1, userID);
				pstmt.setString(3, userID);
				pstmt.setString(2, enpw);
				pstmt.setString(4, "kakaoUser");
				pstmt.setString(5, email);
				pstmt.executeUpdate(); // 쿼리(sql) 실행
			} catch (SQLException e) {
				System.out.println("이미 존재하는 카카오 계정 : "+userID);
			}
		}

		if (type.contains("매수자")) {
			SQL = "SELECT PW,매수자_이름, ID ,email FROM 매수자 WHERE ID = ?";
			userType = "매수자";
		} else if (type.contains("매도자")) {
			SQL = "SELECT PW,매도자_이름, ID ,email FROM 매도자 WHERE ID = ?";
			userType = "매도자";
		} 

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 패스워드 일치한다면 실행
				// 복호화 key=30
				String enpw = rs.getString(1);
				char[] enpw_char = enpw.toCharArray();
				/*
				for (int i = 0; i < enpw_char.length; i++) {
					int temp = (int) enpw_char[i];
					temp += 30;
					enpw_char[i] = (char) temp;
				}*/
				enpw = new String(enpw_char);
				System.out.println(enpw);

				if (enpw.equals(userPassword)) {
					user.setUserName(rs.getString(2));
					user.setUserID(rs.getString(3));
					user.setUserType(userType);
					user.setEmail(rs.getString(4));

					return user; // 로긴 성공

				} else {
					user.setUserType("0");
					return user; // 비밀번호 불일치
				}

			}
			user.setUserType("-1");
			return user; // 아이디가 없음 오류

		} catch (Exception e) {

			e.printStackTrace();

		}
		user.setUserType("-2");
		return user; // 데이터베이스 오류를 의미

	}
	
	public String getEmail(String userID, String type) {
		String userType = "";
		System.out.println("getEmail id: " + userID+ " type: " +type);
		String SQL = "";

		if (type.contains("매수자")) {
			SQL = "SELECT email FROM 매수자 WHERE ID = ?";
			userType = "매수자";
		} else if (type.contains("매도자")) {
			SQL = "SELECT email FROM 매도자 WHERE ID = ?";
			userType = "매도자";
		} 

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			// 결과가 존재한다면 실행
			if (rs.next()) {
				return rs.getString(0);
			}					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}