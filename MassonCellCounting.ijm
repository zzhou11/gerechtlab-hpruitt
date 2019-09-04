
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

min=newArray(3);
max=newArray(3);

//Splits RGB into a 3 image stack
run("HSB Stack");
run("Convert Stack to Images");


//Renaming the 3 components to fit with min/max arrays 
selectWindow("Hue");
rename("0");
selectWindow("Saturation");
rename("1");
selectWindow("Brightness");
rename("2");

//Selecting Hue thresholds
min[0]=0; 
max[0]=255;
//Selecting Saturation thresholds
min[1]=125;
max[1]=255;
//Selecting Brightness thresholds
min[2]=57;
max[2]=255;

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
run("Nucleus Counter", "smallest=200 largest=5000 threshold=Current smooth=None show");
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
close();
if(isOpen("Exception")){
	selectWindow("Exception");
	run("Close");
}
if(isOpen("ROI Manager")) {
selectWindow("ROI Manager");
run("Close");
}
