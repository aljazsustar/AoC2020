import java.util.Scanner;
import java.io.*;
public class Day7{
	public static void main(String[] args) throws IOException{
		InputStream vhod = new FileInputStream(args[0]);
		Scanner sc = new Scanner(vhod);
		String[] podatki = new String[594];
		String[][] bagContents = new String[594][2];
		String[] uporabljeni = new String[600];
		String template = "shiny gold";

		int distinctCounter = 0;
		int counter = 0;
		while(sc.hasNextLine()){
			podatki[counter] = sc.nextLine();
			bagContents[counter] = podatki[counter].split(" bags contain", 0);

			if(bagContents[counter][1].contains(template)){
				if(dodaj(uporabljeni, bagContents[counter][0])){
					distinctCounter++;
				}
			}
			counter++;
		}
		for(int i = 0; i < uporabljeni.length; i++){
			if(uporabljeni[i] != null){
				distinctCounter += isci(uporabljeni[i], bagContents, uporabljeni);
			}
		}
		int stTorbic = kolokoBagov(template, bagContents);
		System.out.println(stTorbic);
		System.out.println(distinctCounter);
	}

	public static boolean dodaj(String[] zbirka, String torbica){
		for(int i = 0; i < zbirka.length; i++){
			if(zbirka[i] == null){
				zbirka[i] = torbica;
				return true;
			}
			if(zbirka[i].equals(torbica)){
				return false;
			}
			
		}
		return false;
	}

	public static int isci(String template, String[][] bagContents, String[] uporabljeni){
		int distinctCounter = 0;
		for(int i = 0; i < bagContents.length; i++){
			if(bagContents[i][1].contains(template)){
				//System.out.println(bagContents[i][1]);
				if(dodaj(uporabljeni, bagContents[i][0])){
					distinctCounter++;
				}
			}
		}
		return distinctCounter;
	}

	public static int kolokoBagov(String template, String[][] bagContents){
		int notranjeTorbice = 0;
		for(int i = 0; i < bagContents.length; i++){
			if(bagContents[i][0].contains(template) && bagContents[i][1].contains("no other bags")){
				return 1;
			} else if(bagContents[i][0].contains(template)){
				String[] vsebina = bagContents[i][1].split(",", 0);
				for(int j = 0; j < vsebina.length; j++){
					String[] besede = vsebina[j].split(" ", 0);
					String torbicaZaNaprej = besede[1] + " " + besede[2];
					if(besede[0].equals("")){
						torbicaZaNaprej = besede[2] + " " + besede[3];
					}
					System.out.println(vsebina[j].charAt(1));
					notranjeTorbice += 1+ (Character.getNumericValue(vsebina[j].charAt(1)) * kolokoBagov(torbicaZaNaprej, bagContents));
				}
			}
		}
		return notranjeTorbice;
	}
}