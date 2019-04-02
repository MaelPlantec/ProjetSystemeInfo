// Taille maximale du tableau des instructions d'assembleur.
#define TAILLE_I 150
// T : Les opérations, les noms des registres ou les adresses ne dépasseront pas 6.
#define T 6

unsigned int ta_index;

struct ta_instru {
  char OPE[T];
  char A[T];
  char B[T];
  char C[T];
};

struct ta_instru ta[TAILLE_I];

void ta_init (void);

void ta_add (char* OPE, char* A, char* B, char* C);

