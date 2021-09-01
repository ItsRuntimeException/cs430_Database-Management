import java.io.IOException;
import java.sql.*;
import java.util.Scanner;

class FindRestaurants
{
    public static void main(String args[]) {
        Connection conn = null;
        try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runlindb", "runlin", "runlin");
            System.out.println("connected.");
            System.out.println("Trying FindRestaurants.java...\n");
			tryFindRestaurants(conn);
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

	public static void tryFindRestaurants(Connection conn) throws SQLException
	{
        Statement stmt = conn.createStatement();
        ResultSet rset;
        String origin = null;
        String destination = null;
    	try 
    	{
            Scanner in = new Scanner(System.in);
            String listing = readEntry(in, "Enter an apartment listing number: ");
            
    		String quer = "SELECT distinct b.name, b.stars, b.review_count FROM yelp_db.business b, yelp_db.apartments a, yelp_db.category c "
            + " WHERE b.review_count >= 10 AND b.city = 'Las Vegas' AND b.state = 'NV' AND b.id = c.business_id AND c.category = 'Restaurants' " 
            + " AND a.listing = " +"'"+listing+"'"+ " AND 200 >= (select ST_Distance_Sphere( point(a.longitude,a.latitude), point(b.longitude,b.latitude)) from dual)";
    		
    		System.out.println(quer + "\n");
        	rset = stmt.executeQuery(quer);
        	while (rset.next())
        	{
                System.out.println("Business Name = " + rset.getString(1));
        		System.out.println("Rating = " + rset.getString(2));
                System.out.println("Review Count = " + rset.getString(3));
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