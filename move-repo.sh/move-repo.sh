#!/usr/bin/env bash

# Repositories
repos=(
CrappyRepo-name-OnE
Crappy--rePO-name-2
)

# Rename repos, if you aren't
# renaming repos, then just
# make sure reporenames=$repos
reporename=(
crap-repo-one
crap-repo-two
)

for ((x=0;x < ${#repos[@]};x++)); do                                                                                                              
  echo ${repos[$x]}                                                                                                                               
  echo ${reporenames[$x]}                                                                                                                         
  if [ -d "${repos[$x]}" ]; then                                                                                                                  
    echo "repo exists locally"                                                                                                                    
    continue;                                                                                                                                     
  fi      
  #
  # Make Sure you change this to where the current repo lives
  # ie git@github.com:JoshuaEstes/REPONAME.git
  # You only need to edit the first part
  #                                                                                                                                        
  git clone git@github.com:JoshuaEstes/${repos[$x]}.git                                                                                              
  cd ${repos[$x]}                                                                                                                                 
  for branch in $(git branch -r | grep -v 'origin\/HEAD' | awk '{ print $1 }' | sed 's/origin\///g'); do                                          
    git checkout -B $branch origin/$branch                                                                                                        
    git pull origin $branch                                                                                                                       
  done;
  #
  # You will need to make sure this points to your new git repo
  #
  git remote set-url origin git@git.localhost:${reporenames[$x]}.git                                                                         
  git push -u origin                                                                                                                              
  cd ..                                                                                                                                           
done;