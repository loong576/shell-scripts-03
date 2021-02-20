#!/bin/bash
#written by loong576
#脚本运行示例：`sh file_space_calc.sh /var /home /opt /usr`

CHECK_DIRECTORIES=" $1 $2 $3 $4"     #以传参方式确定目录

DATE=$(date '+%Y%m%d')               #获取时间信息

exec > file_space_$DATE.log          #将输出的结果重定向至日志

echo "各目录$CHECK_DIRECTORIES下大小排名前20的目录"

for DIR_CHECK in $CHECK_DIRECTORIES  #各目录循环检查
do
  echo ""
  echo "目录$DIR_CHECK统计情况:"
  du -Sm $DIR_CHECK 2>/dev/null |    #循环统计各目录(不包含子目录)大小并排序输出
  sort -rn |                         #对统计结果排序
  sed '{21,$D; =}' |                 #取排名前20的目录
  sed 'N; s/\n/ /' |                 #对结果编号
  gawk '{printf $1 ":" "\t" $2"M"  "\t" $3 "\n"}'  #对结果进行规整，大小后面加M
done
exit
