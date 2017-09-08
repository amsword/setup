# Setup

Scripts to easily install the software in Ubuntu
## Dockerfile
The docker is targeted for a develop environment for deep learning, especially for caffe. Pull it by
```shell
docker pull amsword/setup
```

### Vim
* command-t
    * Open a file fastly. 
    * click , and t to invoke the command-t plugin and then type the file name. Use arrows to select. Click enter to select. 
    * If the file has ever opened, click , and b to search the file list in all the opened. 
    * The name in the search mode doesn't have to be the full name. Partial matching is supported. 
    * Use ctrl+c to exit the search mode if you don't want to open any file. 
    * Use ctrl+f to update the command-t so that it can index the newly-created file. 
* ConqueGDB
    * An easy way to debug the c/c++ code inside vim. 
* YouCompleteMe
    * Auto completion
    * Click j and d to go to the definition if it works. 
* Fugitive
    * Easy way to work with Git inside vim. 
    * Gstatus to show the result of git status in one buffer
        * click D on the file which is changed to show the different. 
        * Click U to revert the change. 
    * GCommit to commit a code change
### Tmux
* enter the tmux: tmux a -d -t id
    * -d: to detach the existing attached session. 
    * -t: which tmux session you want to attach
* show all the tmux sessions: tmux ls
* create a new window: ctrl a c
* go back to the previous window: ctrl a a
* kill the window: ctrl a &
* change the window name: ctrl a ,

## setup_cntk.sh
one script to install the development environment for CNTK in ubuntu environment. 
