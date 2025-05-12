package com.svalero.basededatos.util;

import java.text.NumberFormat;
import java.util.Locale;

public class CurrencyUtils {

    public static String format(double amount){     // el métdo estático sirve para invocarlo sin necesidad de manifestarlo a través de un objeto
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(Locale.of("es","es"));  //buscamos poner los decimales con comas y los euros
        return numberFormat.format(amount);
    }

}
