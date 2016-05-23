package TP12;

import java.util.*;

public class Utilitaires {
    private static Random alea = new Random();

    public static int getIntAlea_1_Max(int max) {
	return 1+Math.abs( alea.nextInt() ) % max;
    }

}
