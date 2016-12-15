//
//  FileUDPServer.m
//  EasyNews
//
//  Created by mac_zly on 2016/12/15.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "FileUDPServer.h"


int sock;         // serverSocket
int clientSocket; // client

FILE* file;       // 存储的文件

int state = -1;

/**
 监听IP和端口
 
 @param ip ip
 @param port 端口
 @return 是否成功监听 0 失败 1 成功
 */
int Listener(char* ip, int port){
    sock = socket(AF_INET, SOCK_STREAM, 0);
    
    printf("%s : %d \n", ip, port);
    
    /* 设置IP 和 端口 协议 等 */
    struct sockaddr_in sockaddrIn;
    memset(&sockaddrIn, 0, sizeof(sockaddrIn));
    sockaddrIn.sin_family = PF_INET;
    sockaddrIn.sin_addr.s_addr = inet_addr(ip);
    sockaddrIn.sin_port = htons(port);
    
    /* 绑定 */
    if (bind(sock, (struct sockaddr *)&sockaddrIn, sizeof(sockaddrIn)) < 0){
        printf("bind_error_server \n");
        return 0;
    }
    
    /* 监听 队列长度20 */
    if (listen(sock, 20) < 0) {
        printf("listen_error_server \n");
        return 0;
    }
    return 1;
}

int Accept() {
    struct sockaddr_in _sockaddr;
    unsigned int size = sizeof(_sockaddr);
    clientSocket = accept(sock, (struct sockaddr *)&_sockaddr, &size);
    if (clientSocket <= 0) {
        return 0;
    }
    
    printf("Accept Success \n");
    return 1;
}

/**
 关闭连接
 
 @param SHUT
 // #define	SHUT_RD		0		//  shut down the reading side */
// #define	SHUT_WR		1		/* shut down the writing side */
// #define	SHUT_RDWR	2		/* shut down both sides */

void CloseServer(shut s) {
    //shutdown(sock, s);              // 断开连接 WR表示如果缓冲区还有数据要读完
    int e = fclose(file);
    close(clientSocket);
    //close(sock);
    printf("close, %d", e);
    state = -1;
}


int CreateFile(char* filePath) {
    /*
     │type│读写性  │文本/2进制文件│建新/打开旧文件  │
     │r   │读      │文本          │打开旧的文件    │
     │w   │写      │文本          │建新文件        │
     │a   │添加     │文本          │有就打开无则建新  │
     │r+  │读/写    │不限制        │打开            │
     │w+  │读/写    │不限制        │建新文件         │
     │a+  │读/添加  │不限制        │有就打开无则建新   │
     */
    printf("%s \n", filePath);
    // 新建并打开
    file = fopen(filePath, "w");
    if (file == NULL) {
        printf("create file error");
        return 0;
    }
    return 1;
}

void Reciver() {
    printf("Reciver \n");
    
    char buffer[BUFF_SIZE] = {0};
    // 接收 返回接收的大小
    size_t length = recv(clientSocket, buffer, BUFF_SIZE, 0);
    
    printf("data: %s - %zu \n", buffer, length);
    
    if (length == 0) {
        state = 0;
    }else {
        // 写入文件
        fwrite(buffer, length, 1, file);
        state = (int)length;
    }
}

int getState() {
    // 一来返回随便一个比0大的数
    if (state == -1) {
        return 3;
    }else {
        return state;
    }
}
