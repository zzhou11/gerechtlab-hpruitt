
title = getTitle();
//In order to set bounds for threshold, we need to convert images to a HSB stack
//This conversion can only be done from RBG type images, first convert to RGB if it's not already.

cellCount = 0;

if (bitDepth != 24) {
	run("RGB Color");
	selectWindow(title);
	close();
	title = getTitle();
}

//	Measures the average color of the pictures
run("Measure");
avgColor = getResult("Mean", nResults - 1);
IJ.deleteRows(nResults - 1, nResults)

min=newArray(3);
max=newArray(3);

//Splits RGB into a 3 image stack
run("RGB Stack");
run("Convert Stack to Images");


//Renaming the 3 components to fit with min/max arrays 
selectWindow("Red");
rename("0");
selectWindow("Green");
rename("1");
selectWindow("Blue");
rename("2");



// Set thresholding. threshGap value is the "gap" between average and desired. All final values must at least be between max threshold and min threshold
threshGap = 60;
minThresh = 20;
maxThresh = 100;
for (i = 0; i < 3; i++) {
	min[i]=0; 
	threshold = avgColor - threshGap;
	if (threshold <= maxThresh && threshold >= minThresh) {
		max[i]= threshold;
		} else if (threshold < minThresh){
			max[i] = minThresh;
		} else {
			max[i] = maxThresh;
		}
}

//Sets all the thresholds and converting all images to masks
for (i=0;i<3;i++){
  selectWindow(""+i); 
  setThreshold(min[i], max[i]);
  run("Convert to Mask");
}

//Combines all 3 images
imageCalculator("AND create", "0","1");
imageCalculator("AND create", "Result of 0","2");

//Close the previous image stacks
for (i=0;i<3;i++){
  selectWindow(""+i);
  close();
}

selectWindow("Result of 0");
close();
selectWindow("Result of Result of 0");
//Rename the resulting thresholded image
rename(title);

//Make black and white and creates the selection
run("Make Binary");
run("Create Selection");

//Runs the Nucleus Counter plugin
run("Nucleus Counter", "smallest=800 largest=5000 threshold=Current smooth=None show");
//Renames Summary for temporary access as "Results"
IJ.renameResults("Summary", "Results");
//If this is the first iteration, rename the useless "Slice" column to "Title", otherwise, delete the accumlating "Slice" column data
if(nResults == 1) {
Table.renameColumn("Slice", "Title");
} else {	
	Table.deleteColumn("Slice");
}
//Sets the title 
setResult("Title", nResults - 1, title); 
IJ.renameResults("Results", "Summary");
//Deletes the useless "Mean" column
Table.deleteColumn("Mean");
//Closes all the unnecessary window
selectWindow(title);
//close();
if(isOpen("Exception")){
	selectWindow("Exception");
	run("Close");
}
if(isOpen("ROI Manager")) {
selectWindow("ROI Manager");
run("Close");
}
