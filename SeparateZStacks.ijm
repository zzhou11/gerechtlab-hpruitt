
while (nImages > 0) {
	// Must be ran on a hyperstack
	targetChannel = 2; // Parameter can be changed 	
	// Stores dimensions
	getDimensions(width, height, channels, slices, frames); 
	// Gets the generic meta data name of the .czi file
	oldTitle = getMetadata("Image");
	oldTitle = substring(oldTitle, indexOf(oldTitle, "-") + 2);
	// Convert stack to images
	run("Stack to Images");
	// Loop through all open images
	for (i = 1; i <= channels; i++) {
		for (j = 1; j <= slices; j++) {
			if (i == targetChannel) {
				//Save the image, note that files of the same name will be overridden 
				saveAs("Jpeg", "/Users/zacharyzhou/Desktop/Output Folder/"+ "Channel" + i + " Slice" + j + " " + oldTitle);
			}
			close();
		}
	}
}