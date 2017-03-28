//
//  main.m
//  线性表的顺序存储
//
//  Created by 刘朋 on 2017/3/28.
//  Copyright © 2017年 刘朋. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LIST 1

#define MAXSIZE 20 /*存储空间初始分配量*/
typedef int ElemType;
typedef struct {
    ElemType data[MAXSIZE];
    int length;
} SqList;

// 顺序存储结构的插入与删除
#define OK 1
#define ERROR 0
typedef int Status;


/**
 查找线性表中第i个元素，用e返回

 @param L 线性表
 @param i 第i个元素(不是索引值)
 @param e 返回查找到的值到e中
 @return 查找数据的结果
 */
Status GetElem(SqList L, int i, ElemType *e) {
    if (L.length == 0 || i < 1 || i > L.length) {
        return ERROR;
    }
    *e = L.data[i-1];
    return OK;
}


/**
 线性表中在第i个位置，插入e

 @return 插入的结果
 */
Status ListInsert(SqList *L, int i, ElemType e) {
    int k;
    if (L->length == MAXSIZE) {
        return ERROR;
    }
    if (i < 1 || i > L->length+1) {
        return ERROR;
    }
    
    if (i <= L->length+1) {
        for (k = L->length-1; k >= i-1; k--) {
            L->data[k+1] = L->data[k];  // 这里当K为[L->length-1], L->data[k+1]可能会数组越界 **** !!!!这里不会数组越界，因为之前数据放满的时候已经RETURN了
        }
    }
    
    L->data[i-1] = e;
    L->length++;
    return OK;
}

Status ListDelete(SqList *L, int i, ElemType *e) {
    int k;
    if (L->length == 0) {
        return ERROR;
    }
    
    if (i < 1 || i > L->length) {
        return ERROR;
    }
    
    *e = L->data[i-1];
    
    if (i != L->length) {
        for (k = i; k < L->length; k++) {
            L->data[k-1] = L->data[k];
        }
    }
    
    L->length--;
    return OK;
}

// 线性表顺序存储的优缺点

/*
 ————————————————————————————————————————————
 |      优点
 |  1.无需为表示表中元素之间的立即关系而
 |  增加额外的存储空间
 |  2.可以快速的存储表中任一位置的元素
 ————————————————————————————————————————————
 
 ————————————————————————————————————————————
 |      缺点
 |  1.插入和删除操作需要移动大量元素
 |  2.当线性表长度变化较大时，难以确定存储空间的容量
 |  3.造成存储空间的‘碎片’
 ————————————————————————————————————————————
 
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SqList *list = malloc(sizeof(SqList));
        
        for (int i = 1; i < 20; i++) {
            ListInsert(list, i, i);
        }
        
        ElemType e;
        
        ListInsert(list, 7, 22);
        ListDelete(list, 8, &e);
//
        NSLog(@"%d", e);
        
        for (int i = 0; i < list->length; i++) {
            NSLog(@"idx:%02d value:%d", i+1, list->data[i]);
        }
    }
    return 0;
}
