#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ta.h"

void ta_init (void) {
  // Initialisation de l'index de la table.
  ta_index = 0;
}

void ta_add (char* OPE, char* A, char* B, char* C) {
  struct ta_instru NewInstru;

  strcpy(NewInstru.OPE, OPE);
  strcpy(NewInstru.A, A);
  strcpy(NewInstru.B, B);
  strcpy(NewInstru.C, C);

  ta[ta_index] = NewInstru;
  ta_index++;
}

void ta_text ()
{
  int i = 0;
  FILE* file = NULL;
  file = fopen("asm.txt", "w");
  if (file != NULL) 
  {
    while (i < ta_index)
    {
      fputs(ta[i].OPE, file);
      fputs("  ", file);
      fputs(ta[i].A, file);
      if (strcmp(ta[i].B, "") != 0)
      {
        fputs(",", file);
        fputs(ta[i].B, file);
      }
      if (strcmp(ta[i].C, "") != 0)
      {
        fputs(",", file);
        fputs(ta[i].C, file);
      }
      fputs("\n", file);
      i++;
    }
    fclose(file);
  }
}

// Tests
int main(void) {
  printf("Début.\n");

  ta_init();
  printf("--- ta_init ---\n");
  ta_add("LOAD","R4","R1","");
  ta_add("ADD","R4","R1","R1");
  ta_add("JMP","0x356","","");
  printf("--- ta_add ---\n");

  ta_text();

  printf("Fin.\n");
  return 0;
}
