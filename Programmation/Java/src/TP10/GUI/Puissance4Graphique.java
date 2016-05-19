package TP10.GUI;

import TP10.App.*;

import java.awt.*;
import javax.swing.*;

public class Puissance4Graphique {

    public static void main(String[] args) {
	Puissance4 p4 = new Puissance4(5,6);

	JFrame frame=new JFrame("Puissance 4");

	ControleurVuePuissance4Graphique cvp4gr = new ControleurVuePuissance4Graphique(p4);

	ControleurPuissance4Graphique cp4gr = new ControleurPuissance4Graphique(p4);

	frame.setContentPane(cvp4gr);
	frame.pack();
	frame.setVisible(true);
    }
}
