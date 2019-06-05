### DOCKER 配置

#### 工作目录
创建统一的网络环境
```
docker network app_net

```
### 工作路径
```
ln -s $(pwd)/apps /www
```
### 启动

```
docker-composer up nginx
```


### branch 分支介绍

master 用于发布 阿里云镜像

modify 修改提交分支： 来源 yun 分支

image  公司开发特性分支

yun   云服务器特性分支
