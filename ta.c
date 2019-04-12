#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ta.h"

void ta_init (void) {
  // Initialisation de l'index de la table.
  ta_index = 0;
}

void ta_add (char* OPE, int A, int B, int C) {
  struct ta_instru NewInstru;

  strcpy(NewInstru.OPE, OPE);
  NewInstru.A = A;
  NewInstru.B = B;
  NewInstru.C = C;

  ta[ta_index] = NewInstru;
  ta_index++;
}

void ta_update_jmp(int indice_jmp) {
  ta[indice_jmp].A = ta_index;
}

void ta_text ()
{
  int i = 0;
  FILE* file = NULL;
  file = fopen("instructions.asm", "w");
  if (file != NULL)
  {
    while (i < ta_index)
    {
      fputs(ta[i].OPE, file);
      fputs("\t", file);

      char a[6];
      sprintf(a, "%d", ta[i].A);
      fputs(a, file);

      if (ta[i].B != -1)
      {
        fputs(" ", file);
        char b[6];
        sprintf(b, "%d", ta[i].B);
        fputs(b, file);
      }
      if (ta[i].C != -1)
      {
        fputs(" ", file);
        char c[6];
        sprintf(c, "%d", ta[i].C);
        fputs(c, file);
      }
      fputs("\n", file);
      i++;
    }
    fclose(file);
  }
}

// Tests
/*
int main(void) {
  printf("Début.\n");

  ta_init();
  printf("--- ta_init ---\n");
  ta_add("LOAD",4,1,-1);
  ta_add("ADD",4,1,1);
  ta_add("JMP",0x356,-1,-1);
  printf("--- ta_add ---\n");

  ta_text();

  printf("Fin.\n");
  return 0;
}
*/
