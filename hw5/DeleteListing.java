import java.io.IOException;
import java.sql.*;
import java.util.Scanner;

class DeleteListing
{
    public static void main(String args[]) {
        Connection conn = null;
        try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@dbs3.cs.umb.edu:1521:dbs3", "runlin", "runlin");
            System.out.println("CONNECTED...");
            System.out.println("\nTrying DeleteListing.java...\n");
			tryDelete(conn);
		} catch (SQLException e) {
			System.out.println("Problem with JDBC Connection\n");
			printSQLException(e);
			System.exit(4);
		} finally {
			// Close the connection, if it was obtained, no matter what happens
			// above or within called methods
			if (conn != null) {
				try {
					conn.close(); // this also closes the Statement and
									// ResultSet, if any
				} catch (SQLException e) {
					System.out.println("Problem with closing JDBC Connection\n");
					printSQLException(e);
					System.exit(5);
                }
            }
        }
    }

    public static void tryDelete(Connection conn) throws SQLException
	{
        Statement stmt = conn.createStatement();
        ResultSet rset;
    	try 
    	{
            Scanner in = new Scanner(System.in);
            String listing = readEntry(in, "Enter an apartment listing number: ");
            
			String quer = "INSERT INTO rented_apartments "
			+ "(SELECT * FROM apartments a WHERE a.listing = "
			+ "'"+listing+"')";
    		System.out.println(quer + "\n");
        	rset = stmt.executeQuery(quer);
			System.out.println("listing inserted into rented_apartments table...\n");

			quer = "DELETE FROM apartments a WHERE a.listing = "
			+ "'"+listing+"'";
            System.out.println(quer + "\n");
        	rset = stmt.executeQuery(quer);
        	System.out.println("listing deleted from apartments table...\n");
        }
        catch (IOException e) {
                System.out.println("Problem with user input, please try again\n");
                System.exit(3);
        } finally {
            conn.close();
        	stmt.close();
        }
    }

    // print out all exceptions connected to e by nextException or getCause
	static void printSQLException(SQLException e) {
		// SQLExceptions can be delivered in lists (e.getNextException)
		// Each such exception can have a cause (e.getCause, from Throwable)
		while (e != null) {
			System.out.println("SQLException Message:" + e.getMessage());
			System.out.println("SQLState: " + e.getSQLState());
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
} // end class