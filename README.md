# V2Ray ArukasCloud

## 概述

用于在 ArukasCloud 上部署 V2Ray mkcp和websocket。
推荐websocket+cf CDN加上custom domain，速度很快，而且不受节点变化影响。

**与 Openshift 一样，ArukasCloud 为我们提供了免费的容器服务，我们不应该滥用它。**

**ArukasCloud 的容器IP在中国被 TCP 阻断。**

**ArukasCloud 的网络并不稳定，部署前请三思。**

## ENV 设定
 
**UUID VER ROOT_PASSWORD SSH_PORT
