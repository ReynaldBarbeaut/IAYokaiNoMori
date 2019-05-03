/*
 **********************************************************
 *
 *  Programme : IAClient.java
 *
 *  resume :    programme java qui va communiquer avec le
 *  client c pour jouer au Yokai-No-Mori
 *
 *  date :      03 / 05 / 19
 *
 ***********************************************************
 */
public class IAClient {

	public static void main(String[] args) {
		IASictus ia = new IASictus();
		ia.searchSolution("initialBoard(Board), bestAction(north,Board, [], Type, P1, P2).");
		System.out.println(ia.getType());
		System.out.println(ia.getP1().toString());
		System.out.println(ia.getP2().toString());
		
		lPieces board = new lPieces();
		lPieces hand = new lPieces();
		board.initBoard();
		System.out.println(board.toString());
		System.out.println(hand.toString());
		
		
	}
	
}
