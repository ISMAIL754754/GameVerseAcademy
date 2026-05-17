package ma.ac.esi.gameverseacademy.service;

import java.sql.SQLException;

import ma.ac.esi.gameverseacademy.repository.UserRepository;

public class UserService {
	
	
	private final UserRepository userRepository;
	
	
	public UserService() {
		super();
		this.userRepository = new UserRepository();
	}


	

	public boolean finUserByCredentials(String login, String password) throws SQLException
	{
		return userRepository.userExists(login, password);
		
	}

}
