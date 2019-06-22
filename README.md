# 2048-win-c-linux-shell
在win平台上用C以及在linux平台上用shell实现2048小程序

project2.c在win平台上实现2048
主要思路分为主流程、创建矩阵模块、随机参数生成模块、统计模块、测试矩阵上下左右可移动性模块、上下左右移动模块

Shell2048.sh在linux平台上实现2048
采用win同样的设计思路，不同于win下，shell采用在临时文件里生成矩阵模型，所有对矩阵的判断、修改、测试都实为对文件的读写并输出到屏幕
由于shell对于数字计算较慢、大量对文件的读写操作，所以其运行比较缓慢
