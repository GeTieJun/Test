package com.sihuatech.entities;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Test {
	
	public static void main(String args[]){
		String strDate = "2008-01-01 23:00";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = null;
		try {
			date = format.parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(date.toString());
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());
		System.out.println(sqlDate);
	}

}
