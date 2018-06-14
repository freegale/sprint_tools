# sprint_tools
该工程包括四个脚本，分别执行工程升级前备份，升级，旧迭代关闭与新迭代开启工作。
创建这四个脚本的目的是为了应对工作中多工程自动升级的问题。运行任何一个脚本，都可以使工作目录[~/Document/workspace/git/]下所有git仓库依次执行相同的操作。
## 升级前备份
在远程为当前正式版本（master分支）创建tag ，标识为升级迭代分支前BAK。示例如下：
```shell script
# 迭代分支sprint_chicken升级前备份
$./RepoBackup.sh chicken

```

## 迭代升级
执行升级操作。将远程master分支指向迭代分支，实现代码版本的升级。示例如下
```shell script
# 迭代分支sprint_chicken升级到正式环境
$./RepoUpgrade.sh chicken

```

## 关闭旧迭代
升级成功后，旧的迭代需要关闭，具体即删除旧迭代分支sprint。
```shell script
# 迭代分支sprint_chicken关闭
$./RepoCloseSprint.sh chicken

```

## 开启新的迭代
升级成功后，旧的迭代已经关闭，这时需要开启新的迭代，即从当前的master分支创建新的sprint迭代分支。
```shell script
# 迭代分支sprint_duck开启
$./RepoStartSprint.sh duck

```

# 注意:
1. 在执行升级操作前，需要保证本地工作空间没有未提交的变更
2. 默认的执行路径是我本地的系统：`~/Documents/workspace/git/`
