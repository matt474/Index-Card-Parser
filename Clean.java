import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Clean {
	
	static String body, current;
	
	static int ptr;

	static Scanner scan;

	static BufferedWriter bw;
	static FileWriter fw;
	
	public static void main(String[] args)
	{
		String set = args[0];
		int scanNum = Integer.parseInt(args[1]);
		String zeros = "000";
		for(int i=1; i<=scanNum; i++)
		{
			if(i==10)
				zeros = "00";
			if(i==100)
				zeros = "0";
			if(i==1000)
				zeros = "";
			try{
				current = new Scanner(new File("in/"+set+"-"+zeros+i+".txt")).useDelimiter("\\Z").next();
				Parse(current, set+"-"+zeros+i);
			} catch (Exception e) {
				System.err.println("ERROR: file "+set+"-"+zeros+i+".txt can not be read");
			}
		}
	}

	public static void Parse(String in, String fileName)
	{
		scan = new Scanner(in);
		
		body = scan.nextLine();
		while(scan.hasNextLine())
		{
			current = scan.nextLine();
			if(current.length() > 2)
				body += " "+current;
		}
		
		if(body.length() < 5)
		{
			System.err.println("REJECTED: file "+fileName+".txt is too short");
			return;
		}
		try
		{
			fw = new FileWriter("out/"+fileName+"-Clean.txt");
			bw = new BufferedWriter(fw);
			//print
			bw.write(body);
		
		} catch (IOException e) {
			System.err.println("ERROR: Can not write file "+fileName+".txt");
		} finally {	
			try {
				if (bw != null)
					bw.close();
				if (fw != null)
					fw.close();
			} catch (IOException ex) {
			}
		}
		
	}
	private static String cleanLine(String in)
	{
		String out = in;
		ptr = 1;
		while(ptr < out.length()){
			if(out.charAt(ptr) == ' ' && out.charAt(ptr-1) == ' ')
				out = out.substring(0, ptr)+out.substring(ptr+1);
			else
				ptr++;
		}
		return out;
	}
}
