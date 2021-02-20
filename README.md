## 一、专题背景

最近使用了个自动化平台（详见[自动化运维平台Spug测试](https://blog.51cto.com/3241766/2537675)）进行每周的变更，效果很不错，平台将大量重复繁琐的操作通过脚本分发方式标准化自动化了，平台核心是下发到各个服务器的shell脚本，感觉有必要对shell脚本做个总结，所以有了写本专题的想法。本专题将结合运维实际介绍shell脚本的各项用法，预计10篇左右，将包括系统巡检、监控、ftp上传下载、数据库查询、日志清理、时钟同步、定时任务等，里面会涉及shell常用语法、注意事项、调试排错等。

## 二、本文前言

本文是该专题的第三篇。

文章主要统计指定目录下排名靠前的目录。生产上文件系统超阀值是很常见的告警项，通过本文的统计脚本可以快速准确的定位超阀值文件系统下使用率较高的目录。

## 三、脚本测试

### 1.执行脚本

```bash
[root@ansible-tower ~]# sh dir_space_calc.sh /var /opt /home /usr
```

![image-20210219163247382](https://i.loli.net/2021/02/20/2gj9WEU6exAoBik.png)

统计/var /opt /home /usr这4个目录下所有目录的大小

### 2.查看执行结果

```bash
[root@ansible-tower ~]# more file_space_20210219.log 
```

![image-20210219163421762](https://i.loli.net/2021/02/20/zrdkaYcPewM8Bu6.png)

执行结果输出至日志 file_space_20210219.log，可查看各目录下排名前20的目录具体大小和文件名。

## 四、ansible方式下发执行

### 1.ansible方式执行

```bash
[root@ansible-tower ~]#  ansible  -m script -a "chdir=/tmp /root/dir_space_calc.sh /home /log /usr"  test157
```

![image-20210219165444216](https://i.loli.net/2021/02/20/4ZkT7EyI6LABt2X.png)

使用ansible的script模块执行脚本dir_space_calc.sh，先进入远端服务器test157的/tmp目录，再执行脚本。

### 2.查看执行结果

```bash
[root@ansible-tower ~]# ansible -m shell -a 'more /tmp/file_space_20210219.log' test157
```

![image-20210219165748378](https://i.loli.net/2021/02/20/mjMc2qOTnXYC9wy.png)

此次传参的目录只有3个：/home /log /usr，其中/log目录还不存在，统计结果会忽略不存在的目录。

## 五、本文总结

本文主要介绍了如何快速统计指定目录下的大文件，通过脚本输出的日志可以很方便的定位大文件路径。生产上很多时候都是日志所在文件系统使用率超阀值告警，由于日志一般很多目录层次很深，手动查看劳时费力且容易有疏漏，本文的脚本可完美解决该问题。

&nbsp;

&nbsp;

**更多请点击：**[shell专题](https://blog.51cto.com/3241766/category18.html)
