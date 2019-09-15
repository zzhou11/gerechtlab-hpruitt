
// Must be ran on a hyperstack
targetChannel = 2 // Parameter can be changed 
// Stores dimensions
getDimensions(width, height, channels, slices, frames); 
oldTitle = getTitle();
// Convert stack to images
run("Stack to Images");
// Loop through all open images
for (i = 1; i <= channels; i++) {
	for (j = 1; j <= slices; j++) {
		title = "c:" + i + "/" + channels + " z:" + j + "/" + slices + " - " + oldTitle + " #1";
		selectWindow(title);
		if (i == targetChannel) {
			//Save the image, note that files of the same name will be overridden 
			saveAs("Jpeg", "/Users/zacharyzhou/Desktop/Output Folder/"+ "Channel" + i + " Slice" + j + " " + oldTitle);
		}
		close();
	}
}
run("Close All");
