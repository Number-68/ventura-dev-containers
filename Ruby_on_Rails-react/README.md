services:
- git
- ruby 3.4.8
- rails 7.2.3
- node.js 20
- 

dependencies: 
- vite 
- react



todo: fix up gem bundle issue. global gem bundles create an issue when making multiple projects in a single dev container
to fix this. we might need to change how docker creates gem bundle file. 
shouldn't be too hard. instead of defining the directory in the docker file, we can just make it a bit of logic in the create_new_project.sh
otherwise, everything works properly. I can use this to start building and working in ruby and rails whenever I wanna make a website. 
good stuff. 
