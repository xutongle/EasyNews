//
//  FileUDPServer.h
//  EasyNews
//
//  Created by mac_zly on 2016/12/15.
//  Copyright © 2016年 zly. All rights reserved.
//


#ifndef C_SOCKET_FILE_SERVER_H
#define C_SOCKET_FILE_SERVER_H

#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <zconf.h>

#define BUFF_SIZE 1024

// 关闭模式
typedef enum SHUT {
    S_SHUT_RD = 0,
    S_SHUT_WR,
    S_SHUT_RDWR
}shut;

// 接受到数据的回调
// typedef void(^ReciverData)(char buffer[1024]);

/**
 绑定监听 ip port
 */
int Listener(char* ip, int port);

/* 阻塞 */
int Accept();

/*  关闭 */
void CloseServer(shut s);

int CreateFile(char* filePath);

/* 接收到了数据 */
void Reciver();

/* 等于0表示数据接收完毕 -1 表示未接收到数据 */
int getState();

#endif //C_SOCKET_FILE_SERVER_H
