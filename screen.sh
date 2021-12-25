#!/usr/bin/env bash

green(){ echo -e "\033[32m$1\033[0m";}
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

get_char() {
SAVEDSTTY=`stty -g`
stty -echo
stty cbreak
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -raw
stty echo
stty $SAVEDSTTY
}

back(){
white "------------------------------------------------------------------------------------------------"
white " 回主菜单，请按任意键"
white " 退出脚本，请按Ctrl+C"
get_char && bash <(curl -sSL https://cdn.jsdelivr.net/gh/kkkyg/screen-script/screen.sh)
}

[[ $(type -P yum) ]] && yumapt='yum -y' || yumapt='apt -y'
[[ $(type -P screen) ]] || (yellow "检测到screen未安装，升级安装中" && $yumapt install screen)	   

ab="1.创建screen窗口程序名称\n2.查看并进入指定screen窗口\n3.查看并删除指定screen窗口\n4.清除所有screen窗口\n0.退出\n 请选择："
readp "$ab" cd
case "$cd" in 
1 )
readp "为方便管理，设置screen窗口程序名称：" screen
screen -S $screen
back;;
2 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ -n $names ]] && green "$names" && readp "输入进入的screen窗口程序名称：" screename && screen -r $screename || red "无执行内容"
back;;
3 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ -n $names ]] && green "$names" && readp "输入删除的screen窗口程序名称：" screename && screen -S $screename -X quit || red "无执行内容"
back;;
4 )
names=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
screen -wipe
[[ -n $names ]] && screen -ls | grep '(Detached)' | cut -d. -f1 | awk '{print $1}' | xargs kill && green "所有screen窗口清除完毕"|| red "无执行内容，无须清除"
back;;
0 ) exit 0
esac
