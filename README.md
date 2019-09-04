## gerechtlab-hpruitt

# SETTING UP GIT ON YOUR MAC AND HOW IT WORKS

Git basically allows for version control (track changes) on a project for multiple users. On Mac, this is done through the Terminal. 

First, let's establish the concept of a remote and local repository. GitHub is the remote repository, where all the project code is stored. A local repository is located on your computer. You must set up a "link" between the two repositories to keep both updated and in sync. 

# The Git Cycle
For each file/folder that you create in the local repo, you must first **track** it. This file will become **staged**, i.e. git now knows about it. When a **staged** file is **modified** (a newly created file that is tracked will be considered modified), it must be **committed** to your local repo to be saved. Once a **staged** file is **committed**, it is considered unmodified, and you may now **push** those **commits** (i.e. changes) to the remote repo (at GitHub). This will update the remote repo and all your fellow collaborators will see your edit. To get the latest updated version of the remote repo (when someone has worked on it and had **comitted** and you want the latest version), you will **pull** those files from the remote repo to your local repo.

# To set up your local repository: 
1. Open Terminal, use the cd command to navigate to a folder where you will be setting up the local repo 
cd means change directory, if you never worked with linux before, just type the following to create a file named mycoderepo on your Desktop (each line indicates a single command, make sure to hit return after each line)

> cd ~/Desktop 
> mkdir mycoderepo
> cd mycoderepo

2. Do: 
> git init

This sets up the Git local repo


> git status 
at anytime to see which files are **tracked**



# Codes for T-cell tracking analysis in MatLab. 
# Use initData to convert excel data to processable matrix
# Make sure to read the specifications for each function before using it, all of them should use standard dataset (column 1 is the track number, column 2 is the slice number (starts from 1, ascending order, no skips), and column 3 is x coordinate, column 4 is y coordinates. All tracks should be grouped together. 
