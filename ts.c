#include "ts.h"

void ts_init (void) {
  // Initialisation de l'index de la table.
  ts_index = 0;
  ts_profondeur_actuelle = 0;
}

// Appelée à la déclaration d'une variable.
// Renvoie 1 si la variable est déjà dans la table, 0 sinon.
int ts_declaration(char* name, Type type) {
  int addr = 1;
  int i = 0;

  if (ts_index == TAILLE - 1) {
    printf("Erreur : Stack Overflow (SO).\n");
    exit(0);
  }

  for (i = 0; i < ts_index; i++) {
      if ((strcmp(ts[i].ts_name, name) == 0) && (strcmp(name, "") != 0)) {
        // La variable est déjà dans la table.
        addr = -1;
        printf("%s est déjà dans la table.\n", name);
      }
  }
  if (addr != -1) {
    printf("%s n'est pas dans la table.\n", name);
    struct ligne_ts ligne;
    ligne.ts_name = malloc(sizeof(char)*256);
    strcpy(ligne.ts_name, name);
    ligne.ts_type = type;
    ligne.ts_addr = DEBUTPILE + (ligne.ts_type*ts_index);
    ligne.ts_profondeur = ts_profondeur_actuelle;
    ts[ts_index] = ligne;
    ts_index++;
    addr = ligne.ts_addr;
  }
  return addr;
}

// Renvoie l'addresse en mémoire de la variable
// 0 si elle n'est pas dans la table
int ts_get_addr(char* name) {
  int addr = 0;
  int i;
  for (i = 0; i < ts_index; i++) {
      if ((strcmp(ts[i].ts_name, name) == 0) && (strcmp(name, "") != 0)) {
        addr = ts[ts_index].ts_addr;
      }
  }
  return addr;
}

void ts_depth_incr(void) {
  ts_profondeur_actuelle++;
}

void ts_depth_decr(void) {
  if(ts_profondeur_actuelle == 0) {
    printf("Erreur : Problème de profondeur du code.\n");
    exit(0);
  } else
    ts_profondeur_actuelle--;
}

/* Décrémente l'index, et donc on va écraser ce qu'il y avait à l'index courant. (inutile de le faire ici). */
void ts_pop (void) {
  ts_index--;
  if (ts_index == -1) {
    printf("Erreur : L'index de la TS est négatif.\n");
    exit(0);
  }
}

/* Ajoute une variable temporaire dans la TS, renvoi : l'adresse. */
int ts_add_tmp (void) {
  int addr = 0;

  struct ligne_ts ligne;
  ligne.ts_name = malloc(sizeof(char)*256);
  strcpy(ligne.ts_name, "");
  ligne.ts_type = TMP;
  ligne.ts_addr = DEBUTPILE + (ligne.ts_type*ts_index);
  ligne.ts_profondeur = ts_profondeur_actuelle;
  ts[ts_index] = ligne;
  ts_index++;
  addr = ligne.ts_addr;

  return addr;
}

void ts_text ()
{
  int i = 0;
  FILE* file = NULL;
  file = fopen("variables.txt", "w");
  if (file != NULL)
  {
    while (i < ts_index)
    {
      fputs(ts[i].ts_name, file);
      fputs(" = ", file);

      char a[10];
      sprintf(a, "%d\n", ts[i].ts_addr);
      fputs(a, file);

      i++;
    }
    fclose(file);
  }
}
