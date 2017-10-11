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
