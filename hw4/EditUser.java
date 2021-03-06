import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.lang.String;

public class EditUser {
	public static void main(String[] args) {

		String dbSys = null;
		Scanner in = null;
		try {
			in = new Scanner(System.in);
			System.out.println("Please enter information for connection to the database");
			dbSys = readEntry(in, "Using Oracle (o) or MySql (m)? ");

		} catch (IOException e) {
			System.out.println("Problem with user input, please try again\n");
			System.exit(1);
		}
		// Prompt the user for connect information
		String username = null;
		String password = null;
		String connStr = null;
		String yesNo;
		try {
			if (dbSys.equals("o")) {
				username = readEntry(in, "Oracle username: ");
				password = username; // readEntry(in, "Oracle password: ");
				yesNo = readEntry(in, "use canned Oracle connection string (y/n): ");
				if (yesNo.equals("y")) {
					String host = "dbs3.cs.umb.edu";// readEntry(in, "host: ");
					String port = "1521"; // readEntry(in, "port (often 1521): ");
					String sid = "dbs3"; // readEntry(in, "sid (site id): ");
					connStr = "jdbc:oracle:thin:@" + host + ":" + port + ":" + sid;
				} else {
					connStr = readEntry(in, "connection string: ");
				}
			} else if (dbSys.equals("m")) {// MySQL--
				username = readEntry(in, "MySQL username: ");
				password = username; // readEntry(in, "MySQL password: ");
				yesNo = readEntry(in, "use canned MySql connection string (y/n): ");
				if (yesNo.equals("y")) {
					String host = readEntry(in, "host: ");
					String port = readEntry(in, "port (often 3306): ");
					String db = username + "db";
					connStr = "jdbc:mysql://" + host + ":" + port + "/" + db;
				} else {
					connStr = readEntry(in, "connection string: ");
				}
			}
		} catch (IOException e) {
			System.out.println("Problem with user input, please try again\n");
			System.exit(3);
		}
		System.out.println("using connection string: " + connStr);
		System.out.print("Connecting to the database...");
		Connection conn = null;
		try {
			conn = getConnected(connStr, username, password);
			UserDB.setConnection(conn);  // let UserDB know connection
			editMember(in, conn);
		} catch (SQLException e) {
			System.out.println("Problem with JDBC Connection\n");
			printSQLException(e);
			System.exit(4);
		} finally {
			closeConnection(conn);
		}
	}

	// Do main part of application
	static void editMember(Scanner in, Connection conn) throws SQLException {
		String firstName = null;
		String lastName = null;
        String email = null;
        User user = null;
		System.out.println("To edit a member in the email list, enter the email below.");
		try {
            email = readEntry(in, "Email search: ");
            if (UserDB.emailExists(email)) {
                user = UserDB.selectUser(email);
                System.out.println("User's first name: " + user.getFirstName());
                System.out.println("User's last name: " + user.getLastName());
                System.out.println("Selected this email's user, entering edit mode...\n");
                
                firstName = readEntry(in, "New firstName: ");
                lastName = readEntry(in, "New lastName: ");
                if (!firstName.isEmpty() && !lastName.isEmpty())
                {
                    UserDB.delete(user); // delete existing user credential from database.
                    user = new User(firstName, lastName, email); // update user credential.
                    UserDB.insert(user); // insert updated user credential into database.
                }
                else if (!firstName.isEmpty() && lastName.isEmpty())
                {
                    lastName = user.getLastName();
                    UserDB.delete(user); // delete existing user credential from database.
                    user = new User(firstName, lastName, email); // update user credential.
                    UserDB.insert(user); // insert updated user credential into database.
                }
                else if (firstName.isEmpty() && !lastName.isEmpty())
                {
                    firstName = user.getFirstName();
                    UserDB.delete(user); // delete existing user credential from database.
                    user = new User(firstName, lastName, email); // update user credential.
                    UserDB.insert(user); // insert updated user credential into database.
                }
                else if (firstName.isEmpty() && lastName.isEmpty())
                {
                    System.out.println("No change to first and last name.");
                }
                System.out.println("Now the user's name is...");
                System.out.println("First name: " + user.getFirstName());
                System.out.println("Last name: " + user.getLastName());
            }
            else
            {
                System.out.println("This email is not in the database, try again later...\n");
            }
		} catch (IOException e) {
			System.out.println("Problem with user input, please try again\n");
			return;
		}
	}

	public static Connection getConnected(String connStr, String user, String password) throws SQLException {

		System.out.println("using connection string: " + connStr);
		System.out.print("Connecting to the database...");
		System.out.flush();

		// Connect to the database
		Connection conn = DriverManager.getConnection(connStr, user, password);
		System.out.println("connected.");
		return conn;
	}
	
	public static void closeConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close(); // this also closes the Statement and
								// ResultSet, if any
			} catch (SQLException e) {
				System.out
						.println("Problem with closing JDBC Connection\n");
				printSQLException(e);
			}
		}
	}

	// print out all exceptions connected to e by nextException or getCause
	static void printSQLException(SQLException e) {
		// SQLExceptions can be delivered in lists (e.getNextException)
		// Each such exception can have a cause (e.getCause, from Throwable)
		while (e != null) {
			System.out.println("SQLException Message:" + e.getMessage());
			Throwable t = e.getCause();
			while (t != null) {
				System.out.println("SQLException Cause:" + t);
				t = t.getCause();
			}
			e = e.getNextException();
		}
	}

	// super-simple prompted input from user
	public static String readEntry(Scanner in, String prompt) throws IOException {
		System.out.print(prompt);
		return in.nextLine().trim();
	}
}
