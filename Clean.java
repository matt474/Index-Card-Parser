import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Clean {
	
	static String body, current;
	static String prefix, suffix;
	
	static int ptr;

	static Scanner scan;

	static BufferedWriter bw;
	static FileWriter fw;
	
	public static void main(String[] args)
	{
		int scanNum = Integer.parseInt(args[0]);
		
		prefix = "";
		suffix = "";
		if(args.length > 1)
			prefix = args[1];
		if(args.length > 2)
			suffix = args[2];
			
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
				current = new Scanner(new File("in/"+prefix+zeros+i+suffix+".txt")).useDelimiter("\\Z").next();
				Parse(current, zeros+i);
			} catch (Exception e) {
				System.err.println("ERROR: file "+prefix+zeros+i+suffix+".txt can not be read");
				try
				{
					fw = new FileWriter("mid1/"+prefix+zeros+i+suffix+".txt");
					bw = new BufferedWriter(fw);
					//print
					bw.write("Blank");
		
				} catch (IOException ioe) {
					System.err.println("ERROR: Can not write file "+prefix+zeros+i+suffix+".txt");
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
		}
	}

	public static void Parse(String in, String num)
	{
		scan = new Scanner(in);
		
		body = cleanLine(scan.nextLine());
		
		boolean splitWord = false;

		while(scan.hasNextLine())
		{
			current = cleanLine(scan.nextLine());
			if(current.length() > 2)
			{
				if(splitWord)
					body += current;
				else
					body += " "+current;
				splitWord = false;
				//if the last character is '-', combine with the next line
				if(current.charAt(current.length() -1) == '-')
				{
					body = body.substring(0, body.length()-1);
					splitWord = true;
				}
			}
		}
		
		if(body.length() < 5)
		{
			System.err.println("Warning: File "+prefix+num+suffix+" does not contain sufficient data");
			body = "Blank";
		}
		try
		{
			fw = new FileWriter("mid1/"+prefix+num+suffix+".txt");
			bw = new BufferedWriter(fw);
			//print
			bw.write(body);
		
		} catch (IOException e) {
			System.err.println("ERROR: Can not write file "+prefix+num+suffix+".txt");
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
