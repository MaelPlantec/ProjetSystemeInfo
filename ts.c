#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

void ts_init (void) {
  // Initialisation de l'index de la table.
  ts_index = 0;
  ts_profondeur_actuelle = 0;
}

// Appelée à la déclaration d'une variable.
// Renvoie 1 si la variable est déjà dans la table, 0 sinon.
unsigned int ts_declaration(char* name, Type type) {
  unsigned int addr = 0;
  int i;
  if(ts_index == 0) {
    printf("Première déclaration.\n");
    // Sinon on l'ajoute.
    struct ligne_ts ligne;
    ligne.ts_name = malloc(sizeof(char)*256);
    strcpy(ligne.ts_name, name);
    ligne.ts_type = type;
    ligne.ts_addr = 0x4000;
    ligne.ts_profondeur = ts_profondeur_actuelle;
    ts[0] = ligne;
    ts_index++;
  }
  else {
    for (i = 0; i < ts_index; i++) {
        if ((strcmp(ts[i].ts_name, name) == 0) && (strcmp(name, "") != 0)) {
          // La variable est déjà dans la table.
          addr = 0;
        }
    }
    // Sinon on l'ajoute.
    struct ligne_ts ligne;
    ligne.ts_name = malloc(sizeof(char)*256);
    strcpy(ligne.ts_name, name);
    ligne.ts_type = type;
    ligne.ts_addr = 0x4000 + (ligne.ts_type*ts_index);
    ligne.ts_profondeur = profondeur;
    ts[ts_index] = ligne;
    ts_index++;
    addr = ligne.ts_addr;
  }
  return addr;
}

// Renvoie l'addresse en mémoire de la variable
// 0 si elle n'est pas dans la table
unsigned int ts_get_addr(char* name) {
  unsigned int addr = 0;
  for (i = 0; i < ts_index; i++) {
      if ((strcmp(ts[i].ts_name, name) == 0) && (strcmp(name, "") != 0)) {
        addr = ts[indice].ts_addr;
      }
  }
  return addr;
}

void ts_depth_incr(void) {
  ts_profondeur_actuelle++;

void ts_depth_decr(void) {
  if(ts_profondeur_actuelle == 0) {
    printf("Erreur : Problème de profondeur du code.\n", name);
    exit(0);
  } else
    ts_profondeur_actuelle--;
}

// Tests
int main(void) {
  ts_init();
  printf("index = %d\n", ts_index);
  ts_declaration("a", INT);
  printf("index = %d\n", ts_index);
  ts_declaration("a",INT);
  printf("index = %d\n", ts_index);
  ts_declaration("c",CONST_INT);
  printf("index = %d\n", ts_index);
  printf("Fin du programme.\n");
  return 0;
}
