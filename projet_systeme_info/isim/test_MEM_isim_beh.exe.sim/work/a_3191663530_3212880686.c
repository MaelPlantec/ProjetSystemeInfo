/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/memoireDonnees.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void work_a_3191663530_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(46, ng0);

LAB3:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t1 = (t0 + 6344U);
    t4 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t3, t1);
    t5 = (t4 - 255);
    t6 = (t5 * -1);
    xsi_vhdl_check_range_of_index(255, 0, -1, t4);
    t7 = (16U * t6);
    t8 = (0 + t7);
    t9 = (t2 + t8);
    t10 = (t0 + 3728);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 16U);
    xsi_driver_first_trans_fast_port(t10);

LAB2:    t15 = (t0 + 3632);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3191663530_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    unsigned char t19;
    char *t20;
    char *t21;
    int t22;
    int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t17 = (t0 + 10553);
    t19 = (16U != 16U);
    if (t19 == 1)
        goto LAB7;

LAB8:    t20 = (t0 + 1192U);
    t21 = *((char **)t20);
    t22 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t21, t1);
    t23 = (t22 - 255);
    t24 = (t23 * -1);
    t25 = (16U * t24);
    t26 = (0U + t25);
    t20 = (t0 + 3792);
    t27 = (t20 + 56U);
    t28 = *((char **)t27);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    memcpy(t30, t17, 16U);
    xsi_driver_first_trans_delta(t20, t26, 16U, 0LL);

LAB2:    t31 = (t0 + 3648);
    *((int *)t31) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 1032U);
    t5 = *((char **)t1);
    t1 = (t0 + 1192U);
    t6 = *((char **)t1);
    t1 = (t0 + 6344U);
    t7 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t6, t1);
    t8 = (t7 - 255);
    t9 = (t8 * -1);
    t10 = (16U * t9);
    t11 = (0U + t10);
    t12 = (t0 + 3792);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t5, 16U);
    xsi_driver_first_trans_delta(t12, t11, 16U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

LAB7:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB8;

}


extern void work_a_3191663530_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3191663530_3212880686_p_0,(void *)work_a_3191663530_3212880686_p_1};
	xsi_register_didat("work_a_3191663530_3212880686", "isim/test_MEM_isim_beh.exe.sim/work/a_3191663530_3212880686.didat");
	xsi_register_executes(pe);
}
