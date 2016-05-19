package TP10.CUI;

import TP10.App.*;
public class Puissance4Txt {
  public static void main(String[] args) {
  	Puissance4 p4 = new Puissance4(5,6);
  	VuePuissance4Txt vp4txt = new VuePuissance4Txt(p4);
  	ControleurPuissance4Txt cp4txt = new ControleurPuissance4Txt(p4);
  	cp4txt.joue();
  }
}
