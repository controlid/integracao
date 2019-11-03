package Example;

import CIDBio.CIDBio;
import CIDBio.RetCode;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		RetCode ret = CIDBio.Init();
		if(ret == RetCode.SUCCESS) {
			System.out.println("Success");
		} else {
			System.out.println("Error: " + CIDBio.GetErrorMessage(ret));
		}
	}

}
