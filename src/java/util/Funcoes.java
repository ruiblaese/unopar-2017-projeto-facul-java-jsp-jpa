/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author RUIBL
 */


public class Funcoes {
    
    public static final String TITULOHTML = "Unopar Choco";

    public static String CalendarToString(Calendar calendar) {
        if (calendar != null) {
            //calendar.add(Calendar.DATE, 1);
            SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
            String formatted = format1.format(calendar.getTime());            
            return formatted;
        } else {
            return "";
        }        
    }

    public static Calendar StringToCalendar(String strDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");            
            Calendar cal = Calendar.getInstance();
            cal.setTime(sdf.parse(strDate));
            return cal;
        } catch (Exception e) {
            return null;
        }

    }

}
