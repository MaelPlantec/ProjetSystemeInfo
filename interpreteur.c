#include "interpreteur.h"

int i = 0;

void interpreteur_init(struct ta_instru ta[TAILLE_I], int max) {
  while(i<max) {
    traitement(ta[i]);
    ++i;
  }
}

void traitement(struct ta_instru instru){
  if(strcmp(instru.OPE, "ADD") == 0) {
      registres[instru.A] = registres[instru.B]+registres[instru.C];
  } else if(strcmp(instru.OPE, "MUL") == 0) {
      registres[instru.A] = registres[instru.B]*registres[instru.C];
  } else if(strcmp(instru.OPE, "SOU") == 0) {
      registres[instru.A] = registres[instru.B]-registres[instru.C];
  } else if(strcmp(instru.OPE, "DIV") == 0) {
      registres[instru.A] = registres[instru.B]/registres[instru.C];
  } else if(strcmp(instru.OPE, "AFC") == 0) {
      registres[instru.A] = instru.B;
  } else if(strcmp(instru.OPE, "LOAD") == 0) {
      registres[instru.A] = memoire[instru.B];
  } else if(strcmp(instru.OPE, "STORE") == 0) {
      memoire[instru.A] = registres[instru.B];
  } else if(strcmp(instru.OPE, "EQU") == 0) {
      if (registres[instru.B] == registres[instru.C]) {
        registres[instru.A] = 1;
      } else {
        registres[instru.A] = 0;
      }
  } else if(strcmp(instru.OPE, "INF") == 0) {
      if (registres[instru.B] < registres[instru.C]) {
        registres[instru.A] = 1;
      } else {
        registres[instru.A] = 0;
      }
  } else if(strcmp(instru.OPE, "INFE") == 0) {
      if (registres[instru.B] <= registres[instru.C]) {
        registres[instru.A] = 1;
      } else {
        registres[instru.A] = 0;
      }
  } else if(strcmp(instru.OPE, "SUP") == 0) {
      if (registres[instru.B] > registres[instru.C]) {
        registres[instru.A] = 1;
      } else {
        registres[instru.A] = 0;
      }
  } else if(strcmp(instru.OPE, "SUPE") == 0) {
      if (registres[instru.B] >= registres[instru.C]) {
        registres[instru.A] = 1;
      } else {
        registres[instru.A] = 0;
      }
  } else if(strcmp(instru.OPE, "JMP") == 0) {
      i = instru.A;
  } else if(strcmp(instru.OPE, "JMPC") == 0) {
      if(registres[instru.B] == 0) {
        i = instru.A;
      }
  } else if(strcmp(instru.OPE, "PRT") == 0) {
      printf("%d\n", memoire[instru.A]);
  } else {
    printf("Erreur : Instruction non reconnue.\n");
  }
}
