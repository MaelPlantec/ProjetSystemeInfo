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
static const char *ng0 = "/home/feuillet/Bureau/4A/S2/Projet info/projet_systeme_info/BR.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void work_a_2707757086_3212880686_p_0(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int t24;
    int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;

LAB0:    xsi_set_current_line(53, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB17:    t21 = (t0 + 2472U);
    t22 = *((char **)t21);
    t21 = (t0 + 1352U);
    t23 = *((char **)t21);
    t21 = (t0 + 7744U);
    t24 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t23, t21);
    t25 = (t24 - 15);
    t26 = (t25 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, t24);
    t27 = (16U * t26);
    t28 = (0 + t27);
    t29 = (t22 + t28);
    t30 = (t0 + 4792);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memcpy(t34, t29, 16U);
    xsi_driver_first_trans_fast_port(t30);

LAB2:    t35 = (t0 + 4680);
    *((int *)t35) = 1;

LAB1:    return;
LAB3:    t15 = (t0 + 2312U);
    t16 = *((char **)t15);
    t15 = (t0 + 4792);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t16, 16U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB5:    t3 = (t0 + 1352U);
    t10 = *((char **)t3);
    t3 = (t0 + 1992U);
    t11 = *((char **)t3);
    t12 = 1;
    if (4U == 4U)
        goto LAB11;

LAB12:    t12 = 0;

LAB13:    t1 = t12;
    goto LAB7;

LAB8:    t3 = (t0 + 2152U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t2 = t9;
    goto LAB10;

LAB11:    t13 = 0;

LAB14:    if (t13 < 4U)
        goto LAB15;
    else
        goto LAB13;

LAB15:    t3 = (t10 + t13);
    t14 = (t11 + t13);
    if (*((unsigned char *)t3) != *((unsigned char *)t14))
        goto LAB12;

LAB16:    t13 = (t13 + 1);
    goto LAB14;

LAB18:    goto LAB2;

}

static void work_a_2707757086_3212880686_p_1(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int t24;
    int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;

LAB0:    xsi_set_current_line(55, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB17:    t21 = (t0 + 2472U);
    t22 = *((char **)t21);
    t21 = (t0 + 1512U);
    t23 = *((char **)t21);
    t21 = (t0 + 7760U);
    t24 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t23, t21);
    t25 = (t24 - 15);
    t26 = (t25 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, t24);
    t27 = (16U * t26);
    t28 = (0 + t27);
    t29 = (t22 + t28);
    t30 = (t0 + 4856);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memcpy(t34, t29, 16U);
    xsi_driver_first_trans_fast_port(t30);

LAB2:    t35 = (t0 + 4696);
    *((int *)t35) = 1;

LAB1:    return;
LAB3:    t15 = (t0 + 2312U);
    t16 = *((char **)t15);
    t15 = (t0 + 4856);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t16, 16U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB5:    t3 = (t0 + 1512U);
    t10 = *((char **)t3);
    t3 = (t0 + 1992U);
    t11 = *((char **)t3);
    t12 = 1;
    if (4U == 4U)
        goto LAB11;

LAB12:    t12 = 0;

LAB13:    t1 = t12;
    goto LAB7;

LAB8:    t3 = (t0 + 2152U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t2 = t9;
    goto LAB10;

LAB11:    t13 = 0;

LAB14:    if (t13 < 4U)
        goto LAB15;
    else
        goto LAB13;

LAB15:    t3 = (t10 + t13);
    t14 = (t11 + t13);
    if (*((unsigned char *)t3) != *((unsigned char *)t14))
        goto LAB12;

LAB16:    t13 = (t13 + 1);
    goto LAB14;

LAB18:    goto LAB2;

}

static void work_a_2707757086_3212880686_p_2(char *t0)
{
    char t19[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    int t20;
    unsigned int t21;
    int t22;
    int t23;
    unsigned int t24;
    unsigned int t25;

LAB0:    t1 = (t0 + 4360U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(61, ng0);

LAB6:    t2 = (t0 + 4712);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t6 = (t0 + 4712);
    *((int *)t6) = 0;
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t5 = (t3 == (unsigned char)2);
    if (t5 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 2312U);
    t4 = *((char **)t2);
    t2 = (t0 + 1992U);
    t6 = *((char **)t2);
    t11 = (3 - 3);
    t17 = (t11 * 1U);
    t18 = (0 + t17);
    t2 = (t6 + t18);
    t7 = (t19 + 0U);
    t10 = (t7 + 0U);
    *((int *)t10) = 3;
    t10 = (t7 + 4U);
    *((int *)t10) = 0;
    t10 = (t7 + 8U);
    *((int *)t10) = -1;
    t20 = (0 - 3);
    t21 = (t20 * -1);
    t21 = (t21 + 1);
    t10 = (t7 + 12U);
    *((unsigned int *)t10) = t21;
    t22 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t2, t19);
    t23 = (t22 - 15);
    t21 = (t23 * -1);
    t24 = (16U * t21);
    t25 = (0U + t24);
    t10 = (t0 + 4920);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t4, 16U);
    xsi_driver_first_trans_delta(t10, t25, 16U, 0LL);

LAB12:    goto LAB2;

LAB5:    t4 = (t0 + 992U);
    t5 = xsi_signal_has_event(t4);
    if (t5 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 == 1)
        goto LAB4;
    else
        goto LAB6;

LAB7:    goto LAB5;

LAB8:    t6 = (t0 + 1032U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t3 = t9;
    goto LAB10;

LAB11:    xsi_set_current_line(64, ng0);
    t2 = xsi_get_transient_memory(256U);
    memset(t2, 0, 256U);
    t6 = t2;
    t7 = (t0 + 8175);
    t8 = (16U != 0);
    if (t8 == 1)
        goto LAB14;

LAB15:    t12 = (t0 + 4920);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t2, 256U);
    xsi_driver_first_trans_fast(t12);
    goto LAB12;

LAB14:    t11 = (256U / 16U);
    xsi_mem_set_data(t6, t7, 16U, t11);
    goto LAB15;

}


extern void work_a_2707757086_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2707757086_3212880686_p_0,(void *)work_a_2707757086_3212880686_p_1,(void *)work_a_2707757086_3212880686_p_2};
	xsi_register_didat("work_a_2707757086_3212880686", "isim/Processor_isim_beh.exe.sim/work/a_2707757086_3212880686.didat");
	xsi_register_executes(pe);
}
