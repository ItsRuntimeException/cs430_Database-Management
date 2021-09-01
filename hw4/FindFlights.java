import java.io.IOException;
import java.sql.*;
import java.util.Scanner;

class FindFlights
{
    public static void main(String args[]) {
        Connection conn = null;
        try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@dbs3.cs.umb.edu:1521:dbs3", "runlin", "runlin");
            System.out.println("connected.");
            System.out.println("Trying FindFlight.java...\n");
			tryFindFlights(conn);
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

	public static void tryFindFlights(Connection conn) throws SQLException
	{
        Statement stmt = conn.createStatement();
        ResultSet rset;
        String origin = null;
        String destination = null;
    	try 
    	{
            Scanner in = new Scanner(System.in);
            origin = readEntry(in, "Flight Origin: ");
            destination = readEntry(in, "Flight Destination: ");
            
    		String quer = "SELECT f.flno, f.distance, (f.arrives - f.departs) as timeDiff FROM flights f "
    		+ " WHERE f.origin=" + "'"+origin+"'"+ " AND f.destination=" +"'"+destination+"'";
    		
    		System.out.println(quer + "\n");
        	rset = stmt.executeQuery(quer);
        	while (rset.next())
        	{
        		System.out.println("flno = " + rset.getInt("flno"));
        		System.out.println("distance = " + rset.getInt("distance"));
                System.out.println("timeDiff = " + rset.getString(3) + "\n");
                System.out.println();
            }
        }
        catch (IOException e) {
                System.out.println("Problem with user input, please try again\n");
                System.exit(3);
        } finally {
            conn.close();
        	stmt.close();
        }
    } // end main

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