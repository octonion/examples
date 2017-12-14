Non-Recursive

public static boolean pali(String testMe){
	StringBuilder sb = new StringBuilder(testMe);
	return testMe.equals(sb.reverse().toString());
}
Recursive (this version does not work correctly with upper-plane Unicode)

public static boolean rPali(String testMe){
	if(testMe.length()<=1){
		return true;
	}
	if(!(testMe.charAt(0)+"").equals(testMe.charAt(testMe.length()-1)+"")){
		return false;
	}
	return rPali(testMe.substring(1, testMe.length()-1));
}
Recursive using indexes (this version does not work correctly with upper-plane Unicode)

public static boolean rPali(String testMe){
	int strLen = testMe.length();
	return rPaliHelp(testMe, strLen-1, strLen/2, 0);
}
 
public static boolean rPaliHelp(String testMe, int strLen, int testLen, int index){
	if(index > testLen){
		return true;
	}
	if(testMe.charAt(index) != testMe.charAt(strLen-index)){
		return false;
	}
	return rPaliHelp(testMe, strLen, testLen, index + 1);
}
 
Regular Expression (source)

public static boolean pali(String testMe){
	return testMe.matches("|(?:(.)(?<=(?=^.*?(\\1\\2?)$).*))+(?<=(?=^\\2$).*)");
}
