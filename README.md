# gerechtlab-hpruitt-codes

# Codes for T-cell tracking analysis in MatLab. 
TCT_InitData: Makes a matrix from an excel file of the T cell movement data, specify which columns to include. 
    -Make sure your excel sheet is in your MATLAB folder (by default, this is where MatLab access all of your code/resources)
    e.g. data = TCT_InitData('sampledata.xlsx', 5)
    
    -First column must ALWAYS be the track number, and all track numbers MUST be grouped together. Make sure your excel sheet 
    e.g. This is OK
    Track Number
    1
    1
    3
    3
    2
    2
    2
    10
    
    But this is NOT OK
    Track Number
    1
    1
    3
    1
    2
    2
    2
    10
TCT_getTrack: Makes a matrix of the slices and corresponding data of a particular track. Returns an empty matrix if no track found. 
    -Slice numbers MUST be unique, and preferably in ascending order to make calculations easier for you...
    
            
