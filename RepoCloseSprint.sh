#! /bin/bash
#step 4
function RepoCloseSprint(){
    echo "==========================仓库$1关闭迭代$2开始============================"
    # 切换到远程master的最新代码分支
    cd ./$1

    # 核心代码：将旧的迭代分支删除
    git push origin :sprint_$2
    echo "==========================仓库$1关闭迭代$2完成============================"
    cd ..
}

cd ~/Documents/workspace/upgrade/
version_no=$1
for dir in $(ls -d */)
do 
    RepoCloseSprint $dir $version_no
done