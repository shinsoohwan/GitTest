package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator{
	PasswordAuthentication pa;
	
	public SMTPAuthenticator() {
		String mail_id = "derstsa00@naver.com";
		String mail_pw = "fldnjsehdbs9!";
		
		pa = new PasswordAuthentication(mail_id, mail_pw);
	}
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}

	
	
}
