public class DressingException extends Exception {
	public DressingException() {
	}
	public DressingException(String s) {
		super(s);
	}
	public DressingException(String s, Exception e) {
		super(s,e);
	}
}

/*
javac -cp .:/usr/share/java/postgresql.jar GestionDressing.java
java -cp .:/usr/share/java/postgresql.jar MainGestionDressing
*/
