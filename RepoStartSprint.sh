#! /bin/bash
#step 3
function RepoStartSprint(){
    echo "==========================仓库$1开启迭代$2开始============================"
    # 切换到远程master的最新代码分支
    cd ./$1
    git fetch 

    temp_branch_name=$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32)
    git checkout -b $temp_branch_name remotes/origin/master

    # 核心代码：将临时分支推送到远程分支上
    git push origin +$temp_branch_name:sprint_$2

    # 删除临时创建的分支
    git checkout -
    git branch -d $temp_branch_name
    echo "==========================仓库$1开启迭代$2完成============================"
    cd ..
}

cd ~/Documents/workspace/upgrade/
version_no=$1
for dir in $(ls -d */)
do 
    RepoStartSprint $dir $version_no
done