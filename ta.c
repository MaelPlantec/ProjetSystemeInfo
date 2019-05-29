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

void ta_update_jmp(int indice_jmp, int addr) {
  ta[indice_jmp].A = addr;
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

void ta_hexa ()
{
  int i = 0;
  FILE* file = NULL;
  file = fopen("hexa.txt", "w");
  if (file != NULL)
  {
    while (i < ta_index)
    {
      char ope[2];
      switch (ta[i].OP) {
        case "ADD" :
          ope = "01";
          break;
        case "MUL" :
          ope = "02";
          break;
        case "SOU" :
          ope = "03";
          break;
        case "DIV" :
          ope = "04";
          break;
        case "AFC" :
          ope = "06";
          break;
        case "LOAD" :
          ope = "07";
          break;
        case "STORE" :
          ope = "08";
          break;
      }
      fputs(ope, file);

      char a[2];
      sprintf(a, "%02d", ta[i].A);
      fputs(a, file);

      if (ta[i].B != -1)
      {
        char b[2];
        sprintf(b, "%02d", ta[i].B);
        fputs(b, file);
      }
      if (ta[i].C != -1)
      {
        char c[2];
        sprintf(c, "%02d", ta[i].C);
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
