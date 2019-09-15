 // SAME CODE AS MASSONTHRESHOLDING.IJM BUT ONLY CALCULATES COLLAGEN AREA + NORMALIZATION
 
 
 //Create two separate windows for processing, initialize arrays for storing and processing threshold bounds
oldTitle = getTitle();
//In order to set bounds for threshold, we need to convert images to a HSB stack
//This conversion can only be done from RBG type images, first convert to RGB if it's not already.

if (bitDepth != 24) {
	run("RGB Color");
	selectWindow(oldTitle);
	close();
}
oldTitle = getTitle();
rename("Collagen Thresholding");
run("Duplicate...", "title=["+"Collagen Normalization"+"]");
//run("Duplicate...", "title=["+"Original"+"]");
min=newArray(3);
max=newArray(3);

//Sets the resize scale, this does not neccessarily reflects accuracy, 
//rather, a lower scale just meanst that the program takes longer to run
binScale = 5;

//Splits RGB into a 3 image stack
selectWindow("Collagen Thresholding");
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
min[0]=135; 
max[0]=210;
//Selecting Saturation thresholds
min[1]=0;
max[1]=70;
//Selecting Brightness thresholds
min[2]=0;
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

//Filters by size and fills in holes
run("Analyze Particles...", "size=0-Infinity show=Masks include in_situ");

//Rename the resulting thresholded image
rename("Collagen Thresholding");



//************************Do it again for Collagen Normalization**************************
//Splits RGB into a 3 image stack
selectWindow("Collagen Normalization");
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
min[1]=0;
max[1]=255;
//Selecting Brightness thresholds
min[2]=180;
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

//Filters by size and fills in holes
run("Analyze Particles...", "size=0-Infinity show=Masks include in_situ");

//Rename the resulting thresholded image
rename("Collagen Normalization");


//Select each image for selection and resize them according to binScale

selectWindow("Collagen Thresholding");
run("Bin...", "x="+ binScale + " y=" + binScale + " bin=Average");
run("Make Binary");
run("Create Selection");
collagenArea = 0;
if(selectionType() != -1){ //Makes sure that the image has a selection
	run("Measure"); //Gets the collagen area 
	collagenArea = getResult("Area", nResults - 1); // Stores the area
	IJ.deleteRows(nResults - 1, nResults); // Deletes the result on the table
}

selectWindow("Collagen Normalization");
run("Bin...", "x="+ binScale + " y=" + binScale + " bin=Average");
run("Make Binary");
run("Measure"); //Gets the total area
totalArea = getResult("Area", nResults - 1); // Stores the area
IJ.deleteRows(nResults - 1, nResults); // Deletes the result on the table

run("Create Selection");
normalizedArea = 0;
if(selectionType() != -1){//Makes ure that the image has a selection
	run("Measure");//Gets the normalized area 
	normalizedArea = getResult("Area", nResults - 1); // Stores the area
	IJ.deleteRows(nResults - 1, nResults); // Deletes the result on the table
}


//Display the proximity value results
currRow = nResults;
setResult("Title", currRow, oldTitle);
setResult("Bin Scale", currRow, binScale);

//Calculate and Display collagen normalization
setResult("Collagen Area", currRow, collagenArea);
setResult("Normalized Area", currRow, normalizedArea);
setResult("Total Area", currRow, totalArea);
setResult("Percent Collagen", currRow, collagenArea/(totalArea - normalizedArea) * 100);

//Closes windows
run("Close All");