package com.example;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

public class DateCheck{
	public static boolean isFirstDateTimeAfterSecond(String dateTime1, String dateTime2) {
	    // Define the date-time formatter
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    // Parse the input strings into LocalDateTime objects
	    LocalDateTime localDateTime1 = LocalDateTime.parse(dateTime1, formatter);
	    LocalDateTime localDateTime2 = LocalDateTime.parse(dateTime2, formatter);

	    // Compare the two LocalDateTime objects
	    return localDateTime1.isAfter(localDateTime2);
	}
	
	public static boolean isDateTimeBeforeNow(String dateTime) {
	    // Define the date-time formatter
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    // Parse the input string into a LocalDateTime object
	    LocalDateTime inputDateTime = LocalDateTime.parse(dateTime, formatter);

	    // Get the current date-time
	    LocalDateTime currentDateTime = LocalDateTime.now();

	    // Compare the input date-time with the current date-time
	    return inputDateTime.isBefore(currentDateTime);
	}
	
	public static boolean isDateTimeWithinNextMonth(String dateTime) {
	    // Define the date-time formatter
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    // Parse the input string into a LocalDateTime object
	    LocalDateTime inputDateTime = LocalDateTime.parse(dateTime, formatter);

	    // Get the current date-time
	    LocalDateTime currentDateTime = LocalDateTime.now();

	    // Get the date-time one month from now
	    LocalDateTime oneMonthFromNow = currentDateTime.plus(1, ChronoUnit.MONTHS);

	    // Check if the input date-time is between the current date-time and one month from now
	    return inputDateTime.isAfter(currentDateTime) && inputDateTime.isBefore(oneMonthFromNow);
	}
}

