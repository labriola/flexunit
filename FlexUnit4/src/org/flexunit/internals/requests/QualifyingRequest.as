package org.flexunit.internals.requests {
	import org.flexunit.internals.builders.OnlyRecognizedTestClassBuilder;
	import org.flexunit.runner.Request;
	
	/**
	 * A QualifyingRequest is a request that verifies each class passed to it is in fact a viable
	 * test before attempting to include it.
	 *  
	 * @author mlabriola
	 * 
	 */
	public class QualifyingRequest extends Request {
		/**
		 * Constructor 
		 * 
		 */
		public function QualifyingRequest() {
			super();
		}

		/**
		 *  
		 * @param argumentsArray possible test classes to be included in a Request
		 * @return a Request composed of all the arguments which could be identified as runnable tests
		 * 
		 */
		public static function classes( ...argumentsArray ):Request {
			var allQualifiedBuilders:OnlyRecognizedTestClassBuilder = new OnlyRecognizedTestClassBuilder(true);
			var arrayLen:int = argumentsArray.length;
			var modifiedArray:Array = new Array();
			
			//Loop through array of classes and determine
			//if the classes are valid test case classes
			//If they are not, then remove them from the array			
			for(var i:int = 0; i<arrayLen; i++) {
				//if allqualifiedbuilders.qualify returns true, we've found
				//a builder so add the class to the modified array
				if ( ( allQualifiedBuilders.qualify(argumentsArray[i] ) ) )
					modifiedArray.push(argumentsArray[i]);				
			}
			
			//Take Arguments Array length minus the modified Array length
			//this will give us the number of files skipped
			//To Do: Somehow display this variable to the user
			//var totalFilesSkipped:int = arrayLen - modifiedArray.length;
			
			//Build out builders for every qualified testcase in the array
			return Request.classes.apply( null, modifiedArray );  
		}
	}
}