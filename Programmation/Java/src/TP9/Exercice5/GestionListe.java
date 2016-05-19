package TP9.Exercice5;

import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;


public class GestionListe extends JPanel {
  private JList<String> list;
  private DefaultListModel<String> listModel;

  private JTextField nomPersonne;
  private JButton enlever;

  public GestionListe() {
    setBorder(BorderFactory.createTitledBorder("Personnel"));
    setLayout(new BorderLayout(5,5));

    // création de la liste et de ses barres de défilement
    listModel = new DefaultListModel<String>();
    listModel.addElement("Nicolas");
    listModel.addElement("Maurice");
    listModel.addElement("Jacques");
    listModel.addElement("Mauro");
    list = new JList<String>(listModel);
    list.setSelectedIndex(0);
    list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    list.addListSelectionListener(new GestionSelection());
    JScrollPane listScrollPane = new JScrollPane(list);
    add(listScrollPane, BorderLayout.CENTER);

    // panneau contenant le textfield et les 2 boutons
    // (FlowLayout par defaut)
    JPanel panneauBouton = new JPanel();
    add(panneauBouton, BorderLayout.SOUTH);

    // création des boutons et du champs de saisie
    nomPersonne = new JTextField(10);
    panneauBouton.add(nomPersonne);
    nomPersonne.setText(list.getSelectedValue().toString());

    JButton ajout = new JButton("Ajouter");
    panneauBouton.add(ajout);
    ajout.addActionListener(new AjoutListener());

    enlever = new JButton("Enlever");
    panneauBouton.add(enlever);
    enlever.addActionListener(new EnleveListener());
  }

  public String removeSelection() {
    int index = list.getSelectedIndex();
    if (index <= -1)
      return null;
    String retour = this.listModel.remove(index);
    int size = listModel.getSize();
    if (size == 0) {
  	  enlever.setEnabled(false);
  	  nomPersonne.setText("");
  	}
  	else {
  	  if (index == size)
  	    index--;
  	  list.setSelectedIndex(index);
  	}
    return retour;
  }

  public void addElement(String elt) {
    if (elt != null) {
      this.listModel.add(this.listModel.size(), elt);
    	list.setSelectedIndex(this.listModel.getSize()-1);
    }
  }

  // gestion de la selection de la liste
  private class GestionSelection implements ListSelectionListener {
    public void valueChanged(ListSelectionEvent e) {
      // une fois la selection fixe
      if (!e.getValueIsAdjusting()) {
	Object item = list.getSelectedValue();
	if (item != null) {
	  enlever.setEnabled(true);
	  nomPersonne.setText(item.toString());
	}
	else {
	  enlever.setEnabled(false);
	  nomPersonne.setText("");
	}
      }
    }
  }

  // gestion du bouton "enlever"
  private class EnleveListener implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      // retrait de l'element selectionne
      int index = list.getSelectedIndex();
      if (index != -1) {
	listModel.remove(index);


	int size = listModel.getSize();
	// si la liste est vide on desactive le bouton "enlever"
	if (size == 0) {
	  enlever.setEnabled(false);
	  nomPersonne.setText("");
	}
	else {
	  // reajustement de la selection
	  if (index == size)
	    index--;
	  list.setSelectedIndex(index);
	}
      }
    }
  }

  // gestion du bouton "ajout"
  private class AjoutListener implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      String contenuChampsPersonne = nomPersonne.getText().trim();
      // si on rentre un nom vide : Beeeeeeeeeeeeeeeeeeeeeeeeeep
      if (contenuChampsPersonne.equals("")) {
	Toolkit.getDefaultToolkit().beep();
	return;
      }

      int index = list.getSelectedIndex();
      int size  = listModel.getSize();

      // si on ajoute en fin de liste ou dans une liste vide
      if ( index == -1 || (index+1 == size) ) {
	listModel.addElement(contenuChampsPersonne);
	list.setSelectedIndex(size);
      }
      // si on ajoute en milieu de liste
      else {
	listModel.insertElementAt(contenuChampsPersonne, index+1);
	list.setSelectedIndex(index+1);
      }
    }
  }

}
