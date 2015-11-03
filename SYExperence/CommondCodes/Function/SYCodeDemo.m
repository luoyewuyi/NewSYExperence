//
//  SYCodeDemo.m
//  SYExperence
//
//  Created by yuhang on 15/9/22.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYCodeDemo.h"

/*
 
 一 __attribute__可以设置函数属性（Function Attribute）、变量属性（Variable Attribute）和类型属性（Type Attribute）
    1 __attribute__((sentinel)) 可变参数结尾必须有结束标志（nil）
    2 format (archetype, string-index, first-to-check)
        format属性告诉编译器，按照printf, scanf, strftime或strfmon的参数表格式规则对该函数的参数进行检查
        __attribute__((format(printf,m,n)))
        __attribute__((format(scanf,m,n)))
        其中参数m与n的含义为：
        m：第几个参数为格式化字符串（format string）；
        n：参数集合中的第一个，即参数“…”里的第一个参数在函数参数总数排在第几
 */

/*
 * 可变参数函数
 */

int addemUp(int firstNum, ...)
{
    va_list args;
    
    int sum = firstNum;
    int number;
    
    va_start(args, firstNum);
    while (1) {
        number = va_arg(args, int);
        sum += number;
        if (number == 0)
        {
            break;
        }
    }
    va_end(args);
    return sum;
}

void printStrings(char *first, ...) __attribute__((sentinel));

void printStrings(char *first, ...)
{
    va_list vrgs;
    va_start(vrgs, first);
    char* string = first;
    while (string != NULL)
    {
        //
        printf("%s", string);
        string = va_arg(vrgs, char *);
    }
    va_end(vrgs);
    printf("\n");
}


@implementation SYCodeDemo


/*
 * @param 测试代码
 * return
 */
+ (void)variableParameter
{
    //
    int sum1 = addemUp(1, 2, 3, 0);
    int sum2 = addemUp(1, 2, 3);
    
    printf("%d, %d\n", sum1, sum2);
    //
    printStrings("今天","不错", "天气", nil);
}
@end
