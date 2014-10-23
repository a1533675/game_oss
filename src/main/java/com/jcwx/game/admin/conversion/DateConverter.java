package com.jcwx.game.admin.conversion;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import ognl.DefaultTypeConverter;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;

/**
 * 日期转换器 struts2 中时差问题
 * 
 * @author Administrator
 * 
 */
public class DateConverter extends DefaultTypeConverter {

    private static final String DATE_PATTERN = "yyyy-MM-dd";

    private static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    private static final Logger logger = Logger.getLogger(DateConverter.class);

    private static final String MONTH_PATTERN = "yyyy-MM";

    /**
     * Convert value between types
     */
    @SuppressWarnings("rawtypes")
    @Override
    public Object convertValue(Map ognlContext, Object value, Class toType) {
	Object result = null;
	if (toType == Date.class) {
	    try {
		result = doConvertToDate(value);
	    } catch (ParseException e) {
		e.printStackTrace();
	    }
	} else if (toType == String.class) {
	    result = doConvertToString(value);
	}
	return result;
    }

    /**
     * Convert String to Date
     * 
     * @param value
     * @return
     * @throws ParseException
     */
    private Date doConvertToDate(Object value) throws ParseException {
	Date result = null;

	if (value instanceof String) {
	    result = DateUtils.parseDate((String) value, new String[] {
		    DATE_PATTERN, DATETIME_PATTERN, MONTH_PATTERN });

	    // all patterns failed, try a milliseconds constructor
	    if (result == null && StringUtils.isNotEmpty((String) value)) {

		try {
		    result = new Date(new Long((String) value).longValue());
		} catch (Exception e) {
		    logger.error("Converting from milliseconds to Date fails!");
		    e.printStackTrace();
		}

	    }

	} else if (value instanceof Object[]) {
	    // let's try to convert the first element only
	    Object[] array = (Object[]) value;

	    if ((array != null) && (array.length >= 1)) {
		value = array[0];
		result = doConvertToDate(value);
	    }

	} else if (Date.class.isAssignableFrom(value.getClass())) {
	    result = (Date) value;
	}
	return result;
    }

    /**
     * Convert Date to String
     * 
     * @param value
     * @return
     */
    private String doConvertToString(Object value) {
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
		DATETIME_PATTERN);
	String result = null;
	if (value instanceof Date) {
	    result = simpleDateFormat.format(value);
	}
	return result;
    }
}