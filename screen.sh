#!/usr/bin/env bash

red(){ echo -e "\033[31m$1\033[0m";}
yellow(){ echo -e "\033[33m$1\033[0m";}
white(){ echo -e "\033[37m$1\033[0m";}
blue(){ echo -e "\033[36m$1\033[0m";}
readp(){ read -p "$(white "$1")" $2;}

yellow "===================================================================="
blue "简单小白的Screen脚本"
blue "项目地址：https://github.com/kkkyg/screen-script"
blue "YouTube频道：甬哥侃侃侃"
yellow "===================================================================="

[[ $(type -P yum) ]] && yumapt='yum -y' || yumapt='apt -y'
[[ $(type -P screen) ]] || (yellow "检测到screen未安装，升级安装中" && $yumapt install screen)	   

ab="1.创建screen窗口程序名称\n2.查看并进入指定screen窗口\n3.查看并删除指定screen窗口\n4.清除所有screen窗口\n0.退出\n 请选择："
readp "$ab" cd
case "$cd" in 
1 )
readp "为方便管理，设置screen窗口程序名称：" screen
screen -S $screen
;;
2 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ -n $names ]] && green "$names" && readp "输入进入的screen窗口程序名称：" screename && screen -r $screename || red "无执行内容"
;;
3 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ -n $names ]] && green "$names" && readp "输入删除的screen窗口程序名称：" screename && screen -S $screename -X quit || red "无执行内容"
;;
4 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ -n $names ]] && screen -ls | grep '(Detached)' | cut -d. -f1 | awk '{print $1}' | xargs kill && green "所有screen窗口清除完毕"|| red "无执行内容，无须清除"
;;
0 ) exit 0
esac
