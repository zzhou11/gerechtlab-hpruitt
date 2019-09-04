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
run("Duplicate...", "title=["+"T Cell Thresholding"+"]");
//run("Duplicate...", "title=["+"Original"+"]");
min=newArray(3);
max=newArray(3);

//Sets the resize scale, this does not neccessarily reflects accuracy, 
//rather, a lower scale just meanst that the program takes longer to run
binScale = 5;


//Splits RGB into a 3 image stack
selectWindow("T Cell Thresholding");
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

//Filters by size and fills in any holes
run("Analyze Particles...", "size=300-Infinity show=Masks include in_situ");

//Rename the resulting thresholded image
rename("T Cell Thresholding");

//************************Do it again for Collagen**************************
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

//Select each image for selection and resize them according to binScale
selectWindow("T Cell Thresholding");
run("Bin...", "x="+ binScale + " y=" + binScale + " bin=Average");
run("Make Binary");
run("Create Selection");
if(selectionType() != -1){//Makes ure that the image has a selection
	getSelectionCoordinates(tCellXpoints, tCellYpoints);
}
else{
	tCellXpoints = newArray(0);
	tCellYpoins = newArray(0);
}
selectWindow("Collagen Thresholding");
run("Bin...", "x="+ binScale + " y=" + binScale + " bin=Average");
run("Make Binary");
run("Create Selection");
if(selectionType() != -1){ //Makes sure that the image has a selection
	getSelectionCoordinates(collagenXpoints, collagenYpoints);
}
else {
	collagenXpoints = newArray(0);
	collagenYpoints = newArray(0);
}

//selectWindow("Original")
//run("Bin...", "x="+ binScale + " y=" + binScale + " bin=Average");

print("T Cell coordinate array has " + tCellXpoints.length + " elements");
print("Collagen coordinate array has " + collagenXpoints.length + " elements");
print("Checking for " + tCellXpoints.length * collagenXpoints.length + " possible combinations");

//Find the shortest distance from each T cell coord to a collagen coord and append them to an array
distanceArray = newArray(tCellXpoints.length);
for (i=0;i<tCellXpoints.length;i++){
	min_distance = 1000000;
	if(collagenXpoints.length > 0){
		for(j=0;j<collagenXpoints.length;j++){
			distance = sqrt(pow(tCellXpoints[i] - collagenXpoints[j], 2) 
			+ pow(tCellYpoints[i] - collagenYpoints[j], 2));
			if(distance < min_distance){
			min_distance = distance; 
			}
		}
		distanceArray[i] = min_distance;
	} else {
		distanceArray[i] = NaN;
	}
}

//Average the distances in the array to obtain a proximity value average
sum = 0;
for (i=0;i<distanceArray.length;i++){
	sum += distanceArray[i];
}
average = sum / distanceArray.length; 

//Display the proximity value results
currRow = nResults;
setResult("Title", currRow, oldTitle);
setResult("Proximity Value Average", currRow, average);
setResult("Bin Scale", currRow, binScale);

//Color the images
selectWindow("Collagen Thresholding");
run("RGB Color");
setForegroundColor(0, 54, 255);
if(selectionType() != -1) {
	run("Fill", "slice");
}
selectWindow("T Cell Thresholding");
run("RGB Color");
setForegroundColor(255, 201, 0);
if(selectionType() != -1) {
	run("Fill", "slice");
}
//Combines the thresholded images
imageCalculator("AND create", "Collagen Thresholding", "T Cell Thresholding");
selectWindow("Collagen Thresholding");
close();
//selectWindow("Original");
//close();
selectWindow("T Cell Thresholding");
close();
selectWindow("Result of Collagen Thresholding");
rename(oldTitle + " Colored");

//Resize
run("Size...", "width=" + getWidth()*binScale + " height=" + getHeight()*binScale + " depth=1 constrain average interpolation=Bilinear");

//Save the image, note that files of the same name will be overridden 
saveAs("Jpeg", "/Users/zacharyzhou/Desktop/Output Folder/"+ getTitle);

close();