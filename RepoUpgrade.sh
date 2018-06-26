#! /bin/bash
#step 2
function RepoUpgrade(){
    echo "==========================仓库$1升级版本$2开始============================"
    # 切换到远程master的最新代码分支
    cd $1
    git fetch 

    temp_branch_name=$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32)
    git checkout -b $temp_branch_name remotes/origin/sprint_$2


    # 在最新代码分支上创建Tag，并推送到远程
    bak_tag_hash=$(git rev-parse --verify --quiet v$2)
    # 如果本地存在备份Tag，从本地和远程删除该Tag
    if [ -n "$bak_tag_hash" ]
    then 
        git tag -d v$2
        git push origin :refs/tags/v$2
    fi

    # 新建版本Tag并且推送到远程
    git tag -a v$2 -m "迭代$2版本升级前备份"

    # 核心代码：1. 更新远程分支的master到sprint分支所在的位置 2. 更新远程分支的tag
    git push origin +$temp_branch_name:master
    git push origin v$2

    # 删除临时创建的分支
    git checkout -
    git branch -d $temp_branch_name
    echo "==========================仓库$1升级版本$2完成============================"
    cd ..
}

cd ~/Documents/workspace/upgrade/
version_no=$1
for dir in $(ls -d */)
do 
    RepoUpgrade $dir $version_no
done