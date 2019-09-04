### gerechtlab-hpruitt

### SETTING UP GIT ON YOUR MAC AND HOW IT WORKS

Git basically allows for version control (track changes) on a project for multiple users. On Mac, this is done through the Terminal. 

First, let's establish the concept of a remote and local repository. GitHub is the remote repository, where all the project code is stored. A local repository is located on your computer. You must set up a "link" between the two repositories to keep both updated and in sync. 

# The Git File Workflow 
When you create a file in the local repo, it is considered **untracked**, you must first **track** it. This file will become **staged**, i.e. git now knows about it. A **staged** file must then **committed** to your local repo to be saved. Once a **staged** file is **committed**, it is considered **unmodified**, and you may now **push** those commits (i.e. changes) to the remote repo (at GitHub). This will update the remote repo and all your fellow collaborators will see your edit. A **unmodified** file that is edited is considered **modified**, and must be **staged** to be **committed**. To get the latest updated version of the remote repo (when someone has worked on it and had **comitted** and you want the latest version), you will **pull** those files from the remote repo to your local repo. 

# Set up your local repository: 
1. Open Terminal, use the cd command to navigate to a folder where you will be setting up the local repo 
cd means change directory

> cd ~/Desktop

This will navigate to your Desktop

2. Next, do 

> git clone <remote-repo-url>
  
  Get the <remote-repo-url> by going to this GitHub repo and click clone, you should see a http url pop up for you to copy
  
3. Done! A new local repo called gerechtlab-hpruitt is now created on your Desktop! 

# Modify your local repo and commit and push the commits to the remote repo

1. Open Terminal, cd to the folder where the git repo is (for the above example, it would be 
cd ~/Desktop/gerechtlab-hpruitt

2. If you created a new file, it must be **tracked**, track it by 
> git add filename

Similarly, you do the exact same thing a file that is tracked but **modified**
> git add filename

To see what files need to be tracked/staged, as well as files ready to be committed, and commit version status, do 

> git status

3. Commit by 
> git commit -m "A message"

You must always write a message, this will commit all **staged** files to the remote repo (GitHub) 

To see a history of all commits you have done, do 

> git log 

4. Push the changes to the remote repo by 

> git push 

# Get the latest version of the code from the remote repo

1. Always a good practice whenever you start to work on a project to do git status to see if any new commits were made. 
If so, do 
> git pull

to get a current version of the code on your local repo. 


### Specific Instructions for Certain Codes

# Codes for T-cell tracking analysis in MatLab. 
# Use initData to convert excel data to processable matrix
# Make sure to read the specifications for each function before using it, all of them should use standard dataset (column 1 is the track number, column 2 is the slice number (starts from 1, ascending order, no skips), and column 3 is x coordinate, column 4 is y coordinates. All tracks should be grouped together. 
