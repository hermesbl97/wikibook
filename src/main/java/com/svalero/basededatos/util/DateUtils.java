package com.svalero.basededatos.util;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class DateUtils {

    private static String DATE_PATTERN = "dd/MM/yyyy";

    public static String format(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN); //con esto formateamos la fecha para el formato que queremos
        return  sdf.format(date);
    }
}